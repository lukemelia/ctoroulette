defmodule CtorouletteWeb.DestinationController do
  use CtorouletteWeb, :controller

  alias Ctoroulette.Roulette
  alias Ctoroulette.Roulette.Destination

  def index(conn, _params) do
    destinations = Roulette.list_destinations()
    render(conn, "index.html", destinations: destinations)
  end

  def new(conn, _params) do
    changeset = Roulette.change_destination(%Destination{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"destination" => destination_params}) do
    case Roulette.create_destination(destination_params) do
      {:ok, destination} ->
        conn
        |> put_flash(:info, "Destination created successfully.")
        |> redirect(to: Routes.destination_path(conn, :show, destination))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    destination = Roulette.get_destination!(id)
    render(conn, "show.html", destination: destination)
  end

  def edit(conn, %{"id" => id}) do
    destination = Roulette.get_destination!(id)
    changeset = Roulette.change_destination(destination)
    render(conn, "edit.html", destination: destination, changeset: changeset)
  end

  def update(conn, %{"id" => id, "destination" => destination_params}) do
    destination = Roulette.get_destination!(id)

    case Roulette.update_destination(destination, destination_params) do
      {:ok, destination} ->
        conn
        |> put_flash(:info, "Destination updated successfully.")
        |> redirect(to: Routes.destination_path(conn, :show, destination))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", destination: destination, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    destination = Roulette.get_destination!(id)
    {:ok, _destination} = Roulette.delete_destination(destination)

    conn
    |> put_flash(:info, "Destination deleted successfully.")
    |> redirect(to: Routes.destination_path(conn, :index))
  end
end
