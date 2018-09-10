# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
user_id = Ecto.UUID.generate()

users = [
  %{id: user_id, email: "trialapi@daviann.com", password: "OrangePhoenix_Pal"}
]

# Documents List
documents = [
  %{title: "Project A121992-01 Specs", user_id: user_id, file: Ecto.UUID.generate()},
  %{title: "Project A121992-01 Dataset", user_id: user_id, file: Ecto.UUID.generate()},
  %{title: "Project A121992-01 Overview", user_id: user_id, file: Ecto.UUID.generate()},
  %{title: "Project A121992-02 Changeset", user_id: user_id, file: Ecto.UUID.generate()},
  %{title: "Project U892891-01 Specs", user_id: user_id, file: Ecto.UUID.generate()}
]

users
|> Enum.each(fn user ->
  Api.Repo.insert!(
    Api.Accounts.User.changeset(%Api.Accounts.User{}, %{
      id: user.id,
      email: user.email,
      password: user.password,
      password_confirmation: user.password
    })
  )
end)

documents
|> Enum.each(fn document ->
  Api.Repo.insert!(
    Api.Documents.Document.changeset(%Api.Documents.Document{}, %{
      title: document.title,
      user_id: document.user_id,
      file: document.file
    })
  )
end)
