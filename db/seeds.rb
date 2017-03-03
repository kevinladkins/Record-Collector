records_list = {
    "It's Blitz" => {
      :artist => Artist.find_by(name: "Yeah Yeah Yeahs"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "Show Your Bones" => {
      :artist => Artist.find_by(name: "Yeah Yeah Yeahs"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "In The Flat Field" => {
      :artist => Artist.find_by(name: "Bauhaus"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "Mask" => {
      :artist => Artist.find_by(name: "Bauhaus"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "The Sky's Gone Out" => {
      :artist => Artist.find_by(name: "Bauhaus"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "Sound of Silver" => {
      :artist => Artist.find_by(name: "LCD Soundsystem"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find_by(name: "DFA"),
      :rpm => "33rpm"
    },
    "This is Happening" => {
      :artist => Artist.find_by(name: "LCD Soundsystem"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find_by(name: "DFA"),
      :rpm => "33rpm"
    },
    "Extra Width" => {
      :artist => Artist.find_by(name: "The Jon Spencer Blues Explosion"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "Orange" => {
      :artist => Artist.find_by(name: "The Jon Spencer Blues Explosion"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    },
    "Now I Got Worry" => {
      :artist => Artist.find_by(name: "The Jon Spencer Blues Explosion"),
      :format => "12\"",
      :record_type => "LP",
      :label => Label.find(2),
      :rpm => "33rpm"
    }
  }

records_list.each do |name, record_hash|
  p = Record.new
  p.name = name
  record_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end
