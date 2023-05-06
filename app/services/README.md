# Rule for service class

Define business logic in service class. e.g. rake task, workers, or complicating logic such as order request of an endpoint. Define PORO(Plain Old Ruby Object) for simple class in model, lib, or any layer.
Inherit `ApplicationService` class.

```ruby
class OrderCreator < ApplicationService

  def initialize(**props)
    @buyer_id = props[:buyer_id]
    @address = props[:address]
    @product_id = props[:product_id]
  end

  private

  attr_reader :buyer_id, :address, :product_id

  def perform
    # write process
  end
end

OrderCreator.call(buyer_id: 1, address: 'Tokyo', product_id: 'abcdefg')
```
