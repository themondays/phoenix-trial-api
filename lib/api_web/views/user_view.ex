defmodule ApiWeb.UserView do
  use ApiWeb, :view
  alias ApiWeb.UserView

  def render("jwt.json", %{token: token}) do
    %{token: token}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email}
  end

  def render("documents.json", %{user: user}) do
    %{documents: user.documents}
  end
end
