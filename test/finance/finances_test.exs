defmodule Finance.FinancesTest do
  use Finance.DataCase

  alias Finance.Finances

  describe "transaction" do
    alias Finance.Finances.Transactions

    import Finance.FinancesFixtures

    @invalid_attrs %{date: nil, description: nil, title: nil, valor: nil}

    test "list_transaction/0 returns all transaction" do
      transactions = transactions_fixture()
      assert Finances.list_transaction() == [transactions]
    end

    test "get_transactions!/1 returns the transactions with given id" do
      transactions = transactions_fixture()
      assert Finances.get_transactions!(transactions.id) == transactions
    end

    test "create_transactions/1 with valid data creates a transactions" do
      valid_attrs = %{date: ~D[2021-11-29], description: "some description", title: "some title", valor: 120.5}

      assert {:ok, %Transactions{} = transactions} = Finances.create_transactions(valid_attrs)
      assert transactions.date == ~D[2021-11-29]
      assert transactions.description == "some description"
      assert transactions.title == "some title"
      assert transactions.valor == 120.5
    end

    test "create_transactions/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finances.create_transactions(@invalid_attrs)
    end

    test "update_transactions/2 with valid data updates the transactions" do
      transactions = transactions_fixture()
      update_attrs = %{date: ~D[2021-11-30], description: "some updated description", title: "some updated title", valor: 456.7}

      assert {:ok, %Transactions{} = transactions} = Finances.update_transactions(transactions, update_attrs)
      assert transactions.date == ~D[2021-11-30]
      assert transactions.description == "some updated description"
      assert transactions.title == "some updated title"
      assert transactions.valor == 456.7
    end

    test "update_transactions/2 with invalid data returns error changeset" do
      transactions = transactions_fixture()
      assert {:error, %Ecto.Changeset{}} = Finances.update_transactions(transactions, @invalid_attrs)
      assert transactions == Finances.get_transactions!(transactions.id)
    end

    test "delete_transactions/1 deletes the transactions" do
      transactions = transactions_fixture()
      assert {:ok, %Transactions{}} = Finances.delete_transactions(transactions)
      assert_raise Ecto.NoResultsError, fn -> Finances.get_transactions!(transactions.id) end
    end

    test "change_transactions/1 returns a transactions changeset" do
      transactions = transactions_fixture()
      assert %Ecto.Changeset{} = Finances.change_transactions(transactions)
    end
  end
end
