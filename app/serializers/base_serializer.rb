# frozen_string_literal: true

class BaseSerializer < ActiveModel::Serializer
  def attributes(*_args)
    {
      message: '',
      data: serialized_data
    }
  end

  def serialized_data
    object.map { |record| ActiveModelSerializers::SerializableResource.new(record, serializer: DataSerializer) }
  end
end
