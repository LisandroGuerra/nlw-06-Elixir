defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do

      params = %{"filename" => "test_file.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "response" => %{
          "Cida" => 21.007667798746546,
          "Lica" => 20.01836547291093,
          "Lisandro" => 28.680111097693512
        }
      }

      assert response == expected_response
    end

    test "when there are invalid params, returns an error message", %{conn: conn} do

      params = %{"filename" => "wrong_file.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"response" => "Error while opening the file"}

      assert response == expected_response
    end
  end
end
