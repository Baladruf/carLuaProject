


local exoutils = {}


function exoutils.doExercise(module, exercise)

	module = module or 1
	exercise = exercise or 1
	local exo = require('course.module'..module..'.ex'..exercise)
	exo.setup()

	



end 



