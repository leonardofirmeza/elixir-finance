defmodule FinanceWeb.TransactionsController do
  use FinanceWeb, :controller

  alias Finance.Finances
  alias Finance.Finances.Transactions

  def index(conn, _params) do
    transaction = Finances.list_transaction()
    render(conn, "index.html", transaction: transaction)
  end

  def new(conn, _params) do
    changeset = Finances.change_transactions(%Transactions{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transactions" => transactions_params}) do
    case Finances.create_transactions(transactions_params) do
      {:ok, transactions} ->
        conn
        |> put_flash(:info, "Transactions created successfully.")
        |> redirect(to: Routes.transactions_path(conn, :show, transactions))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transactions = Finances.get_transactions!(id)
    render(conn, "show.html", transactions: transactions)
  end

  def edit(conn, %{"id" => id}) do
    transactions = Finances.get_transactions!(id)
    changeset = Finances.change_transactions(transactions)
    render(conn, "edit.html", transactions: transactions, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transactions" => transactions_params}) do
    transactions = Finances.get_transactions!(id)

    case Finances.update_transactions(transactions, transactions_params) do
      {:ok, transactions} ->
        conn
        |> put_flash(:info, "Transactions updated successfully.")
        |> redirect(to: Routes.transactions_path(conn, :show, transactions))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transactions: transactions, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transactions = Finances.get_transactions!(id)
    {:ok, _transactions} = Finances.delete_transactions(transactions)

    conn
    |> put_flash(:info, "Transactions deleted successfully.")
    |> redirect(to: Routes.transactions_path(conn, :index))
  end
end
