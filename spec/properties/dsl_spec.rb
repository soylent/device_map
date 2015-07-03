# frozen_string_literal: true

require 'device_map'

RSpec.describe DeviceMap::Properties::DSL do
  describe '.property' do
    let(:model) do
      Class.new do
        include DeviceMap::Properties::DSL
      end
    end

    it 'defines class attribute' do
      property_value = 'test'
      model.property :property
      model_instance = model.new('property' => property_value)

      expect(model_instance.property).to eq property_value
    end

    it 'allows to change source propery name' do
      other_property_name = 'other_property'
      other_property_value = 'test'
      model.property :property, source_name: other_property_name.to_sym
      model_instance = model.new(other_property_name => other_property_value)
      expect(model_instance.property).to eq other_property_value
    end

    it 'can cast property value to integer' do
      model.property :property, type: :integer
      model_instance = model.new('property' => '8')
      expect(model_instance.property).to eq 8
    end

    it 'can cast property value to boolean' do
      model.property :property, type: :boolean
      model_instance = model.new('property' => 'false')
      expect(model_instance.property).to eq false
    end

    it 'raises exception during initialization if given param is unknown' do
      expect do
        model.new('unknown_param' => 'value')
      end.to raise_error(DeviceMap::Properties::UnknownProperty)
    end

    it 'is equal to other object if it has the same properties' do
      property_value = 'test'
      model.property :property
      model_instance1 = model.new('property' => property_value)
      model_instance2 = model.new('property' => property_value)

      expect(model_instance1).to eq model_instance2
    end

    it 'is not equal to other object if it has different properties' do
      model.property :property
      model_instance1 = model.new('property' => 'test1')
      model_instance2 = model.new('property' => 'test2')

      expect(model_instance1).not_to eq model_instance2
    end
  end
end
