defmodule PlugRobots do
  @moduledoc """
    A robots.txt Plug
  """

  import Plug.Conn, only: [put_status: 2, put_resp_content_type: 2, send_resp: 3, halt: 1]

  @robots_path "/robots.txt"
  @content_type "text/plain"

  def init(opts), do: opts

  def call(conn, opts) do
    case conn.request_path do
      @robots_path -> resp_robots(conn, opts)
      _ -> conn
    end
  end

  def resp_robots(conn, opts) do
    conn
    |> put_resp_content_type(@content_type)
    |> send_resp(:ok, resp_body(opts))
    |> halt()
  end

  def resp_body([rules: :allow_all] = _opts) do
    """
    User-agent: *
    Allow: /
    """
  end
  def resp_body([rules: :deny_all] = _opts) do
    """
    User-agent: *
    Disallow: /
    """
  end
  def resp_body([rules: body] = _opts), do: body
  def resp_body(_opts) do
    """
    User-agent: *
    Allow: /
    """
  end
end
