defmodule WebhookProcessor.Application do
   @moduledoc "OTP Application specification for WebhookProcessor"

   use Application

   def start(_type, _args) do
     # List all child processes to be supervised
     children = [
       # Use Plug.Cowboy.child_spec/3 to register our endpoint as a plug
       Plug.Cowboy.child_spec(
         scheme: :http,
         plug: WebhookProcessor.Endpoint,
         options: [port: 4000]
       )
     ]

     opts = [strategy: :one_for_one, name: WebhookProcessor.Supervisor]
     Supervisor.start_link(children, opts)
   end
end
