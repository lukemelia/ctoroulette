defmodule CtorouletteWeb.DestinationControllerTest do
  use CtorouletteWeb.ConnCase

  alias Ctoroulette.Roulette

  @create_attrs %{name: "some name", url: "some url"}
  @update_attrs %{name: "some updated name", url: "some updated url"}
  @invalid_attrs %{name: nil, url: nil}

  def fixture(:destination) do
    {:ok, destination} = Roulette.create_destination(@create_attrs)
    destination
  end

  describe "index" do
    test "lists all destinations", %{conn: conn} do
      conn = get(conn, Routes.destination_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Destinations"
    end
  end

  describe "new destination" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.destination_path(conn, :new))
      assert html_response(conn, 200) =~ "New Destination"
    end
  end

  describe "create destination" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.destination_path(conn, :create), destination: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.destination_path(conn, :show, id)

      conn = get(conn, Routes.destination_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Destination"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.destination_path(conn, :create), destination: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Destination"
    end
  end

  describe "edit destination" do
    setup [:create_destination]

    test "renders form for editing chosen destination", %{conn: conn, destination: destination} do
      conn = get(conn, Routes.destination_path(conn, :edit, destination))
      assert html_response(conn, 200) =~ "Edit Destination"
    end
  end

  describe "update destination" do
    setup [:create_destination]

    test "redirects when data is valid", %{conn: conn, destination: destination} do
      conn = put(conn, Routes.destination_path(conn, :update, destination), destination: @update_attrs)
      assert redirected_to(conn) == Routes.destination_path(conn, :show, destination)

      conn = get(conn, Routes.destination_path(conn, :show, destination))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, destination: destination} do
      conn = put(conn, Routes.destination_path(conn, :update, destination), destination: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Destination"
    end
  end

  describe "delete destination" do
    setup [:create_destination]

    test "deletes chosen destination", %{conn: conn, destination: destination} do
      conn = delete(conn, Routes.destination_path(conn, :delete, destination))
      assert redirected_to(conn) == Routes.destination_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.destination_path(conn, :show, destination))
      end
    end
  end

  defp create_destination(_) do
    destination = fixture(:destination)
    %{destination: destination}
  end
end
