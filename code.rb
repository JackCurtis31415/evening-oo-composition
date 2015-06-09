require 'pry'

class Airplane
  attr_accessor :total_capacity, :cargo, :cargo_weight

  def initialize(total_capacity, cargo=[])
    @total_capacity = 20000
    @cargo = cargo
    @cargo_weight = 0  # FIXME for array
  end

  def load_cargo(container)
    @cargo << container
    @cargo_weight += container.container.total_weight
    if @cargo_weight > @total_capacity
      puts "WARNING:   load weight of #{@cargo_weight} exceeds total aircraft capacity of #{@total_capacity}"
    end
  end

  
end

#
#  class container has a contents weight and a load method
#    plus a total weight
#

class Container
  attr_accessor :ingredient, :empty_weight, :capacity, :type, :total_weight, :contents_weight

  def initialize(ingredient, empty_weight, capacity)
    @ingredient = ingredient
    @empty_weight = empty_weight
    @capacity = capacity.to_f
    @contents_weight = 0
  end

  def load_stuff(pounds)
    @contents_weight += pounds
    if @contents_weight > @capacity
      puts "WARNING:   for contain #{@contents_weight} exceeds capacity of #{@capacity}"
    end
    @total_weight = @empty_weight + @contents_weight
  end
                 
end

class BrusselsSprout
  attr_accessor :container, :ingredient
  
  def initialize()
    @ingredient = Ingredient.new("Brussel_sprouts", 20.0)
    @container = Container.new(@ingredient, 200.0, 300.00)
  end

end

class CheesyPoof
  attr_accessor :container, :ingredient
  
  def initialize()
    @ingredient = Ingredient.new("Cheesy_poofs", 0.5 )
    @container = Container.new(@ingredient, 50.0, 20.0)
  end

end
                 
class Ingredient

  attr_accessor :type, :gms_per_item, :GRAMS_PER_POUND
  
  def initialize(type, gms_per_item)
    @type = type
    @gms_per_item = gms_per_item
    @GRAMS_PER_POUND = 453.592
  end

  def n_items_per_weight(lbs)
    lbs * @GRAMS_PER_POUND / @gms_per_item
  end
  
end

class LoadAirplane

  attr_accessor :cheesy_poof_weight, :airplane_total_load

  def initialize(cheesy_poof_weight, airplane_total_load)
    @cheesy_poof_weight = cheesy_poof_weight
    @airplane_total_load = airplane_total_load
    @plane = Airplane.new(@airplane_total_load)
    @load = []
  end

  def prepare_to_load_Cheesy_poofs
    # prepare a load
    w = 0
    @load = []

    # load Cheesy poofs containers

    while w < @cheesy_poof_weight
      box = CheesyPoof.new
      box.container.load_stuff(box.container.capacity)
      @load << box
      w += box.container.capacity

      if(w > @cheesy_poof_weight)
        load.pop
        w -= box.container.capacity
        newbox = CheesyPoof.new
        newbox.container.load_stuff(@cheesy_poof_weight - w)
        break
      end
    end
    puts " #{@load.size} CheesyPoof containers were required to load #{w} pounds of Cheesy poofs"

  end

  def load_containers_into_airplane
    @load.each do |container|
      @plane.load_cargo(container)
    end
  end
  
  def prepare_to_load_Brussels_sprouts
    @load = []
    w = 0
    b_weight = 0
    
    # load Brussels sprouts containers
    goal = @plane.total_capacity - @plane.cargo_weight

    while w < goal
      box = BrusselsSprout.new
      box.container.load_stuff(box.container.capacity)
      @load << box
      w += box.container.total_weight
      b_weight += box.container.contents_weight

      if(w > goal)
        @load.pop
        w -= box.container.total_weight
        b_weight -= box.container.contents_weight
        newbox = BrusselsSprout.new
        newbox.container.load_stuff(goal - w)
        b_weight += newbox.container.contents_weight
        @load << newbox
        break
      end
    end

    puts " #{@load.size} BrusselsSprout containers were required to load #{b_weight} pounds of Brussels sprouts"
    puts " total number of brussels sprouts is #{box.ingredient.n_items_per_weight(b_weight)} "
  end

end


=begin

How many total Brussels sprouts can be carried in a Concorde based on the following requirements? How many Brussels Sprouts containers are needed for that?:
5,000 lbs of Cheesy Poofs must be delivered
1,000 lbs of Cheesy Poofs must be delivered

=end


plane = LoadAirplane.new(5000, 20000)
plane.prepare_to_load_Cheesy_poofs
plane.load_containers_into_airplane
plane.prepare_to_load_Brussels_sprouts
plane.load_containers_into_airplane



plane = LoadAirplane.new(1000, 20000)
plane.prepare_to_load_Cheesy_poofs
plane.load_containers_into_airplane
plane.prepare_to_load_Brussels_sprouts
plane.load_containers_into_airplane


=begin

How many total Brussels sprouts can be carried in a Concorde based on the following requirements? How many Brussels Sprouts containers are needed for that?:
5,000 lbs of Cheesy Poofs must be delivered
1,000 lbs of Cheesy Poofs must be delivered

=end


