require 'pry'
require 'json'
file = File.read('spec/fixtures/contestants.json')
hash = JSON.parse(file)


def get_first_name_of_season_winner(data, season)
  name = "notfound"
  data.each do |key,value| # key = ...season x, season y, season z
    if key == season
      value.each do |k,v|
        if k["status"] == "Winner" # k = {"age", "hometown", ..etc}
          name = k["name"]
        end
      end
    end
  end
  name = name.split # => ["Firstname, Lastname"]
  name = name.shift # => ["Firstname"]
  name = name.to_s # => "Firstname"
  name
end

# get_first_name_of_season_winner(hash, "season 10")

def get_contestant_name(data, occupation)
  data.each do |key, value| # value = [ {"name", "occupation", "age"}, {}, {} ]
    value.each do |contestant|
      if contestant["occupation"] == occupation
        return contestant["name"]
      end
    end
  end
end

# get_contestant_name(hash, "Cruise Ship Singer")

def count_contestants_by_hometown(data, hometown)
  from_hometown = 0

  data.each do |key, value| # value = [ {"name", "occupation", "age"}, {}, {} ]
    value.each do |contestant|
      if contestant["hometown"] == hometown
        from_hometown+=1
      end
    end
  end
  from_hometown
end

# count_contestants_by_hometown(hash, "New York, New York")

def get_occupation(data, hometown)
  data.each do |key, value| # value = [ {"name", "occupation", "age"}, {}, {} ]
    value.each do |contestant|
      if contestant["hometown"] == hometown
        return contestant["occupation"]
      end
    end
  end
end

def get_average_age_for_season(data, season)
  ages = []
  sum_ages = 0
  avg_age = 0

  data.each do |key, value| # value = [ {"name", "occupation", "age"}, {}, {} ]
    if key == season
      value.each do |contestant,_value|
        ages << contestant["age"].to_i
      end
    end
  end

  ages.each do |age|
    sum_ages += age
  end

  avg_age = (sum_ages/(ages.length).to_f).round
  avg_age
end

get_average_age_for_season(hash, "season 10")
