class PasswordGenerator

  def self.character_sets(*ranges)
    ranges.collect(&:to_a).flatten
  end

  @@default_character_set = character_sets('a'..'z', 'A'..'Z', '0'..'9')
  cattr_accessor :default_character_set

  attr_accessor :character_set, :length

  def character_set
    @character_set ||= default_character_set
  end

  def length
    @length ||= 10
  end

  def random_character
    character_set.random_element
  end

  def characters
    length.times.map { random_character }
  end

  def create
    characters.join
  end

end
