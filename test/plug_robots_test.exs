defmodule PlugRobotsTest do
  use ExUnit.Case
  doctest PlugRobots
  use Plug.Test

  @allow_all """
  User-agent: *
  Allow: /
  """
  test "Returns allow rules if /robots.txt requested with allow option" do
    # Create a test connection
    conn = conn(:get, "/robots.txt")
    conn = PlugRobots.call(conn, [rules: :allow_all])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == @allow_all
  end

  @deny_all """
  User-agent: *
  Disallow: /
  """
  test "Returns deny from all rules if /robots.txt requested with deny option" do
    # Create a test connection
    conn = conn(:get, "/robots.txt")
    conn = PlugRobots.call(conn, [rules: :deny_all])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == @deny_all
  end

  @googlebot_rule """
  User-agent: Googlebot-Image
  Disallow: /images/dogs.jpg
  """
  test "Returns custom rules if /robots.txt requested with custom option" do

    # Create a test connection
    conn = conn(:get, "/robots.txt")
    conn = PlugRobots.call(conn, [rules: @googlebot_rule])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == @googlebot_rule
  end

  @allow_all """
  User-agent: *
  Allow: /
  """
  test "Returns allow_all rules if /robots.txt requested withoud rules" do
    # Create a test connection
    conn = conn(:get, "/robots.txt")
    conn = PlugRobots.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == @allow_all
  end
end
