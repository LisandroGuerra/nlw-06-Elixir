defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "Lisandro Guerra", email: "lisandro@sparta.dev", password: "secret"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        changes: %{email: "lisandro@sparta.dev", name: "Lisandro Guerra", password: "secret"},
        errors: [], valid?: true} = response
    end

    # todo - create tests for some more cases
    test "when there are invalid params (no password), returns an error message" do
      params = %{name: "Lisandro Guerra", email: "lisandro@sparta.dev", password: ""}

      response = User.changeset(params)

      expected_response = %{
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end

    test "when there are invalid params (name with one character), returns an error message" do
      params = %{name: "L", email: "lisandro@sparta.dev", password: "secret"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"]
      }

      assert errors_on(response) == expected_response
    end

    test "when there are invalid params (invalid e-mail), returns an error message" do
      params = %{name: "Lisandro Guerra", email: "lisandro2sparta.dev", password: "secret"}

      response = User.changeset(params)

      expected_response = %{
        email: ["has invalid format"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
