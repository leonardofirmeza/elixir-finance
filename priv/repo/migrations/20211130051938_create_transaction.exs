defmodule Finance.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction) do
      add :date, :date
      add :title, :string
      add :description, :string
      add :valor, :float

      timestamps()
    end
  end
end
