defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  defp handle_response({:ok, response}, conn), do: render_response(conn, response, :ok)

  defp handle_response({:error, reason}, conn), do: render_response(conn, reason, :bad_request)

  defp render_response(conn, response, status) do
    conn
    |> put_status(status)
    |> json(%{response: response})
  end
end
