defmodule Finance.FinancesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Finance.Finances` context.
  """

  @doc """
  Generate a transactions.
  """
  def transactions_fixture(attrs \\ %{}) do
    {:ok, transactions} =
      attrs
      |> Enum.into(%{
        date: ~D[2021-11-29],
        description: "some description",
        title: "some title",
        valor: 120.5
      })
      |> Finance.Finances.create_transactions()

    transactions
  end
end
