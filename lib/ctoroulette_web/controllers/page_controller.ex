defmodule CtorouletteWeb.PageController do
  use CtorouletteWeb, :controller
  alias Ctoroulette.Roulette

  def index(conn, _params) do
    destinations = Roulette.list_destinations()
    destination = Enum.random(destinations)
    render(conn, "index.html",
      destination: destination,
      destinations: destinations
    )
  end
end
