defmodule FinanceWeb.TransactionsControllerTest do
  use FinanceWeb.ConnCase

  import Finance.FinancesFixtures

  @create_attrs %{date: ~D[2021-11-29], description: "some description", title: "some title", valor: 120.5}
  @update_attrs %{date: ~D[2021-11-30], description: "some updated description", title: "some updated title", valor: 456.7}
  @invalid_attrs %{date: nil, description: nil, title: nil, valor: nil}

  describe "index" do
    test "lists all transaction", %{conn: conn} do
      conn = get(conn, Routes.transactions_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Transaction"
    end
  end

  describe "new transactions" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.transactions_path(conn, :new))
      assert html_response(conn, 200) =~ "New Transactions"
    end
  end

  describe "create transactions" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transactions_path(conn, :create), transactions: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.transactions_path(conn, :show, id)

      conn = get(conn, Routes.transactions_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Transactions"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transactions_path(conn, :create), transactions: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Transactions"
    end
  end

  describe "edit transactions" do
    setup [:create_transactions]

    test "renders form for editing chosen transactions", %{conn: conn, transactions: transactions} do
      conn = get(conn, Routes.transactions_path(conn, :edit, transactions))
      assert html_response(conn, 200) =~ "Edit Transactions"
    end
  end

  describe "update transactions" do
    setup [:create_transactions]

    test "redirects when data is valid", %{conn: conn, transactions: transactions} do
      conn = put(conn, Routes.transactions_path(conn, :update, transactions), transactions: @update_attrs)
      assert redirected_to(conn) == Routes.transactions_path(conn, :show, transactions)

      conn = get(conn, Routes.transactions_path(conn, :show, transactions))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, transactions: transactions} do
      conn = put(conn, Routes.transactions_path(conn, :update, transactions), transactions: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Transactions"
    end
  end

  describe "delete transactions" do
    setup [:create_transactions]

    test "deletes chosen transactions", %{conn: conn, transactions: transactions} do
      conn = delete(conn, Routes.transactions_path(conn, :delete, transactions))
      assert redirected_to(conn) == Routes.transactions_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.transactions_path(conn, :show, transactions))
      end
    end
  end

  defp create_transactions(_) do
    transactions = transactions_fixture()
    %{transactions: transactions}
  end
end
