defmodule ApiWeb.Router do
  use ApiWeb, :router
  alias Api.Guardian

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :jwt_authenticated do
    plug(Guardian.AuthPipeline)
  end

  scope "/api/1.0", ApiWeb do
    pipe_through(:api)
    resources("/users", UserController, only: [:create, :show])
    post("/signup", UserController, :create)
    post("/signin", UserController, :signin)
  end

  scope "/api/1.0", ApiWeb do
    pipe_through([:api, :jwt_authenticated])

    get("/profile", UserController, :show)
  end
end
