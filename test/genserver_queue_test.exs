defmodule GenserverQueueTest do
  use ExUnit.Case
  doctest GenserverQueue

  test "greets the world" do
    assert GenserverQueue.hello() == :world
  end
end
