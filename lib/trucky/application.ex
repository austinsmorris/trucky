defmodule Trucky.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TruckyWeb.Telemetry,
      # Start the Ecto repository
      Trucky.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Trucky.PubSub},
      # Start Finch
      {Finch, name: Trucky.Finch},
      # Start the Endpoint (http/https)
      TruckyWeb.Endpoint
      # Start a worker by calling: Trucky.Worker.start_link(arg)
      # {Trucky.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Trucky.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TruckyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
