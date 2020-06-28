defmodule Ctoroulette.RouletteTest do
  use Ctoroulette.DataCase

  alias Ctoroulette.Roulette

  describe "destinations" do
    alias Ctoroulette.Roulette.Destination

    @valid_attrs %{name: "some name", url: "some url"}
    @update_attrs %{name: "some updated name", url: "some updated url"}
    @invalid_attrs %{name: nil, url: nil}

    def destination_fixture(attrs \\ %{}) do
      {:ok, destination} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Roulette.create_destination()

      destination
    end

    test "list_destinations/0 returns all destinations" do
      destination = destination_fixture()
      assert Roulette.list_destinations() == [destination]
    end

    test "get_destination!/1 returns the destination with given id" do
      destination = destination_fixture()
      assert Roulette.get_destination!(destination.id) == destination
    end

    test "create_destination/1 with valid data creates a destination" do
      assert {:ok, %Destination{} = destination} = Roulette.create_destination(@valid_attrs)
      assert destination.name == "some name"
      assert destination.url == "some url"
    end

    test "create_destination/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Roulette.create_destination(@invalid_attrs)
    end

    test "update_destination/2 with valid data updates the destination" do
      destination = destination_fixture()
      assert {:ok, %Destination{} = destination} = Roulette.update_destination(destination, @update_attrs)
      assert destination.name == "some updated name"
      assert destination.url == "some updated url"
    end

    test "update_destination/2 with invalid data returns error changeset" do
      destination = destination_fixture()
      assert {:error, %Ecto.Changeset{}} = Roulette.update_destination(destination, @invalid_attrs)
      assert destination == Roulette.get_destination!(destination.id)
    end

    test "delete_destination/1 deletes the destination" do
      destination = destination_fixture()
      assert {:ok, %Destination{}} = Roulette.delete_destination(destination)
      assert_raise Ecto.NoResultsError, fn -> Roulette.get_destination!(destination.id) end
    end

    test "change_destination/1 returns a destination changeset" do
      destination = destination_fixture()
      assert %Ecto.Changeset{} = Roulette.change_destination(destination)
    end
  end
end
