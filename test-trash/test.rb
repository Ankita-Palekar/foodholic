class Animals
	def initialize(name, type)
		@name = name
		@type = type
	end

	def get_property()
		"Property: #{@name}-- #{@type}--#{@nick_name}--#{@nick_name2}"
	end
	# seeting variable in the fasion of setter and geter 
	# way 1
	def nick_name=(n_name)
		@nick_name	=	n_name
	end

 	# way 2
end


class Aquatic < Animals
	def initialize(name, type, aquatic_type)
		super(name, type)
		@aquatic_type	=	aquatic_type
	end
	# 1 way
	# def get_property()
	# 	"Property: #{@name} -- #{@type} -- #{@aquatic_type}"
	# end
	# way 2
	
	def get_property()
			super	+	"-- #{@aquatic_type}"
	end
end


class Mammals
	main_type	=	"aquatic"

	def does_have_nickname(animal)
		return animal.type != main_type
	end
end

class Person 
	attr_reader :name
	attr_writer :name
	attr_accessor :name
end



class Song
	def initialize(name, artist, duration)
		@name = name
		@artist = artist
		@duration = duration		
	end

end

class SongList
	def initialize
		@songs = Array.new
	end

	def append(aSong)
		@songs.push(aSong)
		self
	end
	def delete_first
		@songs.shift
	end
	def delete_last
		@songs.pop
	end
end

 
class SongList
  def [](key)
    if key.kind_of?(Integer)
      return @songs[key]
    else
      for i in 0...@songs.length
        return @songs[i] if key == @songs[i].name
      end
    end
    return nil
  end
end



 
 
# pst = Post.new
# pst.title  = "Engg"
# puts pst.full_title


# song1 = Song.new('tennu samjava', 'arjit singh', 5)
# song2 = Song.new('London Thumkda', 'xxx', 10)
# song3 = Song.new('Why not me', 'yyy',15)
# list = SongList.new;
# list.append(song1).append(song2).append(song3)

# puts(list.delete_first)


# person1 = Person.new;
# person1.name ="Ankita"
# puts(person1.name)

 
# animal1	=	Animals.new("cat", "teristrial")
# animal1.nick_name 	= "popo"
# aq1	=	Aquatic.new("snake",	"aquatic",	"aquatic reptile")

# mem1	=	Mammals.new();
 
 

 # mam1 = Mammals.new();
 # puts(mam1.does_have_nickname(aq1))
 