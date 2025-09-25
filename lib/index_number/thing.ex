defmodule IndexNumber.Thing do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> {0, 0} end, name: __MODULE__)
  end

  def pull() do
    pulled =
      Agent.get_and_update(
        __MODULE__,
        fn {pull_number, called_number} ->
          {pull_number + 1, {pull_number + 1, called_number}}
        end
      )

    IndexNumber.Pubsub.new_pull(pulled)
    pulled
  end

  def next() do
    called_number =
      Agent.get_and_update(
        __MODULE__,
        fn {pull_number, called_number} ->
          {called_number + 1, {pull_number, called_number + 1}}
        end
      )

    IndexNumber.Pubsub.call_next(called_number)
    called_number
  end

  def on_screen() do
    Agent.get(__MODULE__, fn {_pull_number, called_number} ->
      called_number
    end)
  end

  def waiting() do
    Agent.get(__MODULE__, fn {pull_number, called_number} ->
      pull_number - called_number
    end)
  end
end
