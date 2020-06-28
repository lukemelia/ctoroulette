defmodule Ctoroulette.Roulette.Destination do
  use Ecto.Schema
  import Ecto.Changeset

  schema "destinations" do
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(destination, attrs) do
    destination
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end
