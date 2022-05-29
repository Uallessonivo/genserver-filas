defmodule GenserverQueue do
  use GenServer

  # CLient
  def start_link(initial_stack) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def enqueue(pid, stack) do
    GenServer.cast(pid, {:enqueue, stack})
  end

  def dequeue(pid) do
    GenServer.call(pid, :dequeue)
  end

  # Server
  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_cast({:enqueue, element}, queue) do
    new_queue = queue ++ [element]
    {:noreply, new_queue}
  end

  @impl true
  def handle_call(:dequeue, _from, []) do
    {:reply, :empty_queue, []}
  end

  @impl true
  def handle_call(:dequeue, _from, [element | new_queue]) do
    {:reply, element, new_queue}
  end
end
