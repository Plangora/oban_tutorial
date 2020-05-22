defmodule ObanTutorialWeb.PageController do
  use ObanTutorialWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
