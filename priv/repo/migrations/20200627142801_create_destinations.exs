defmodule Ctoroulette.Repo.Migrations.CreateDestinations do
  use Ecto.Migration

  def change do
    create table(:destinations) do
      add :name, :string
      add :url, :string

      timestamps()
    end

  end
end
