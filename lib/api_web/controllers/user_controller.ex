defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.User
  alias Api.Guardian

  action_fallback(ApiWeb.FallbackController)

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token} <- Guardian.encode_and_sign(user) do
          conn |> render("jwt.json", token: token)
    end
  end

  def create(conn, %{"email" => email, "password" => password, "password_confirmation" => password_confirmation}) do

    user_params = %{"email" => email, "password" => password, "password_confirmation" => password_confirmation}

    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", token: token)
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_signin(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", token: token)
      {:error, _reason} ->
        conn
        |> put_status(401)
        |> render "error.json", error: _reason
      _ ->
        {:error, :unauthorized}
    end
  end
end
