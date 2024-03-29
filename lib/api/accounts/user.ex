defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field(:email, :string)
    field(:password_hash, :string)

    # Virtual fields:
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    # Remove hash, add pw + pw confirmation
    |> cast(attrs, [:email, :password, :password_confirmation])
    # Remove hash, add pw + pw confirmation
    |> validate_required([:email, :password, :password_confirmation])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    # Check that password length is >= 8 
    |> validate_length(:password, min: 8)
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    # Add put_password_hash to changeset pipeline
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
