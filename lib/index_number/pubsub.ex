defmodule IndexNumber.Pubsub do
  @channel "queue"

  def sub() do
    Phoenix.PubSub.subscribe(IndexNumber.Number, @channel)
  end

  def call_next(number) do
    Phoenix.PubSub.broadcast(IndexNumber.Number, @channel, {:number_called, number})
  end

  def new_pull(number) do
    Phoenix.PubSub.broadcast(IndexNumber.Number, @channel, {:number_pulled, number})
  end
end
