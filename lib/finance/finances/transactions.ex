defmodule Finance.Finances.Transactions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transaction" do
    field :date, :date
    field :description, :string
    field :title, :string
    field :valor, :float

    timestamps()
  end

  @doc false
  def changeset(transactions, attrs) do
    transactions
    |> cast(attrs, [:date, :title, :description, :valor])
    |> validate_required([:date, :title, :description, :valor])
  end
end
