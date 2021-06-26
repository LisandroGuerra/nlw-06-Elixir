defmodule Wabanex.Users.Get do
  alias Ecto.UUID
  alias Wabanex.{Repo, User}

  # to refactor using "case"
  # def call(id) do
  #   id
  #   |> UUID.cast()
  #   |> handle_response()
  # end

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid UUID"}
      {:ok, user} -> handle_response({:ok, user})
    end
  end

  # to refactor using "case"
  # defp handle_response(:error) do
  #   {:error, "Invalid UUID"}
  # end

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
