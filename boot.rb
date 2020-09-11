# require 'mathn'

Dir[Dir.pwd + "/initializers/*.rb"].each {|file| require file }
Dir[Dir.pwd + "/exceptions/*.rb"].each {|file| require file }

require Dir.pwd + "/app/multivector3D"
require Dir.pwd + "/app/packing"
require Dir.pwd + "/app/concealment"
require Dir.pwd + "/app/tools"
require Dir.pwd + "/app/ga"
