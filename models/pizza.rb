require('pg')

class Pizza

  attr_reader( :id, :first_name, :last_name, :topping, :quantity )

  def initialize( options )
    @id = options['id'].to_i
    @first_name = options['first_name']
    @last_name = options['last_name']
    @topping = options['topping']
    @quantity = options['quantity'].to_i
  end

  def self.all
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "SELECT * FROM pizzas"
    pizzas = db.exec(sql)

    result = pizzas.map{|pizza| Pizza.new(pizza)}

    db.close
    return result
  end

  def save
    db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
    sql = "INSERT INTO pizzas (
    first_name, 
    last_name,
    topping,
    quantity)
    VALUES (
    '#{@first_name}',
    '#{last_name}',
    '#{topping}',
    '#{quantity}') 
    RETURNING *"
    pizza_data = db.exec(sql)
    db.close
    @id = pizza_data.first()['id'].to_i
  end

  def pretty_name()
    return @first_name.concat(" #{@last_name}")
  end

  def total()
    return @quantity * 12
  end


end