defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid ID is given, returns the relative user", %{conn: conn} do
      params = %{
        name: "Lisandro Guerra",
        email: "lisandro@sparta.dev",
        password: "secret"
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}"){
          id
          name
          email
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "lisandro@sparta.dev",
            "id" => "#{user_id}",
            "name" => "Lisandro Guerra"}
            }
          }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valids", %{conn: conn} do

      mutation = """
        mutation{
          createUser(input: {
            name: "Lisandro G S Pires", email: "lisandropires@sparta.dev", password: "secret"
          }) {
            id,
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
        "data" => %{
          "createUser" => %{
            "id" => _id,
            "name" => "Lisandro G S Pires"
            }
          }
        } = response
    end
  end
end
