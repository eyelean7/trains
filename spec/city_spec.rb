require 'spec_helper'

describe(City) do
  describe '#name' do
    it('gives the name of the city') do
      test_city = City.new({:name => "Toronto"})
      expect(test_city.name()).to eq("Toronto")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_city = City.new({:name => "Toronto"})
      test_city.save()
      expect(test_city.id()).to be_an_instance_of(Fixnum)
      expect(City.all()).to eq([test_city])
    end
  end

  describe '#==' do
    it('is true if cities have same name') do
      city1 = City.new({:name => "Toronto"})
      city2 = City.new({:name => "Toronto"})
      expect(city1).to eq(city2)
    end
  end

  describe '#trains' do
    it('returns an array of trains for that city') do
      train = Train.new({:name => "polar express"})
      train.save()
      train1 = Train.new({:name => "pineapple express"})
      train1.save()
      city = City.new({:name => "Toronto"})
      city.save()
      city.update_stops ([train.id, train1.id])
      expect(city.trains()).to eq([train, train1])
    end
  end

  describe '#delete_city' do
    it "deletes a city from the cities database" do
      city = City.new({:name => "Seattle"})
      city.save()
      city.delete_city()
      expect(City.all()).to eq([])
    end
    it "deletes a city from the stops database" do
      city = City.new({:name => "Seattle"})
      city.save()
      train = Train.new({:name => "polar express"})
      train.save()
      city.update_stops([train.id()])
      stop = Helper.all_stops().first()
      expect(stop["city_id"].to_i()).to eq(city.id())
      city.delete_city()
      expect(Helper.all_stops().first()).to eq(nil)
    end
  end
end
