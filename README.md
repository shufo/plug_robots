# PlugRobots

An Elixir plug serving robots.txt.

## Installation

Add plug_robots to your list of dependencies in mix.exs:


```elixir
def deps do
  [{:plug_robots, "~> 0.1.0"}]
end
```

## Usage

- Add it to your endpoint before the router

`endpoint.ex`

```elixir
plug PlugRobots, rules: :allow_all

plug MyApp.Router
```

## Examples

- Deny all crawler

```elixir
plug PlugRobots, rules: :deny_all

plug MyApp.Router
```

- Returns different rules by environment

```elixir
case Mix.env do
    :prod -> plug PlugRobots, rules: :allow_all
    _     -> plug PlugRobots, rules: :deny_all
end

plug MyApp.Router
```

- Returns custom rules

```elixir
@googlebot_rule """
User-agent: GoogleBot
Disallow: /images/dogs.jpg
"""

plug PlugRobots, rules: @googlebot_rule

plug MyApp.Router
```
### Options

- `rules`
  - `:allow_all`: Allow all crawlers to all path
  - `:deny_all`: Disallow all crawlers to all path
  - string: any other custom rules
