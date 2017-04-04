defmodule PlugRobots.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_robots,
     version: "0.1.0",
     elixir: "~> 1.4",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  defp description do
    """
    An Elixir plug serving robots.txt.
    """
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:plug, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp package do
    [name: :plug_robots,
     files: ["lib", "config", "mix.exs", "README*"],
     maintainers: ["Shuhei Hayashibara"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/shufo/plug_robots"}]
  end
end
