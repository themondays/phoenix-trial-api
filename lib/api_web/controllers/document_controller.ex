defmodule ApiWeb.DocumentController do
  use ApiWeb, :controller

  alias Api.Documents
  alias Api.Documents.Document
  alias Api.Guardian

  action_fallback(ApiWeb.FallbackController)

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    documents = Documents.list_user_documents(user.id)
    conn |> render("index.json", documents: documents)
  end

  def all(conn, _params) do
    documents = Documents.list_documents()
    conn |> render("index.json", documents: documents)
  end

  def create(conn, %{"document" => document_params}) do
    user = Guardian.Plug.current_resource(conn)

    document_params = Enum.into(%{"user_id" => user.id}, document_params)

    with {:ok, %Document{} = document} <- Documents.create_document(document_params) do
      conn
      |> put_status(:created)
      |> render("show.json", document: document)
    end
  end

  def show(conn, %{"id" => id}) do
    document = Documents.get_document!(id)
    render(conn, "show.json", document: document)
  end

  def update(conn, %{"id" => id, "document" => document_params}) do
    document = Documents.get_document!(id)

    with {:ok, %Document{} = document} <- Documents.update_document(document, document_params) do
      render(conn, "show.json", document: document)
    end
  end

  def delete(conn, %{"id" => id}) do
    document = Documents.get_document!(id)

    with {:ok, %Document{}} <- Documents.delete_document(document) do
      send_resp(conn, :no_content, "")
    end
  end
end
