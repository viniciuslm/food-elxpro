defmodule FoodElxpro.Carts do
  def create(cart_id), do: GenServer.cast(:cart_session, {:create, cart_id})
  def add(cart_id, product), do: GenServer.call(:cart_session, {:add, cart_id, product})

  def remove(cart_id, product_id),
    do: GenServer.call(:cart_session, {:remove, cart_id, product_id})

  def inc(cart_id, product_id), do: GenServer.call(:cart_session, {:inc, cart_id, product_id})
  def dec(cart_id, product_id), do: GenServer.call(:cart_session, {:dec, cart_id, product_id})
  def get(cart_id), do: GenServer.call(:cart_session, {:get, cart_id})
  def delete(cart_id), do: GenServer.cast(:cart_session, {:delete, cart_id})
end
