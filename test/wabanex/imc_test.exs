defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, return the data" do
      params = %{"filename" => "test_file.csv"}

      response = IMC.calculate(params)

      expected_response = {:ok, %{"Cida" => 21.007667798746546, "Lica" => 20.01836547291093, "Lisandro" => 28.680111097693512}}

      assert response == expected_response
    end

    test "when the file does not exists, return an error message" do
      params = %{"filename" => "wrong_file.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert expected_response == response
    end
  end
end
