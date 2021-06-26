defmodule Wabanex.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.Training

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :name, :password]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    has_one :training, Training

    timestamps()
  end

  def changeset(params) do
    # %Wabanex.User{} #ou
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end