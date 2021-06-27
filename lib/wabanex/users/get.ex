defmodule Wabanex.Users.Get do
  import Ecto.Query

  alias Ecto.UUID
  alias Wabanex.{Repo,Training, User}

  ## to refactor using "case"
  # def call(id) do
  #   id
  #   |> UUID.cast()
  #   |> handle_response()
  # end
  ## DONE

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid UUID"}
      {:ok, user} -> handle_response({:ok, user})
    end
  end

  ## to refactor using "case"
  # defp handle_response(:error) do
  #   {:error, "Invalid UUID"}
  # end
  ## DONE

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, load_training(user)}
    end
  end

  defp load_training(user) do
    today = Date.utc_today()

    query = from training in Training,
      where: ^today >= training.start_date and ^today <= training.end_date

    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
