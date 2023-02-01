local M = {}

M.line_endings = {
	dos = "\r\n",
	unix = "\n",
	mac = "\r",
}

-- these filetype is not correct
M.fileType = {
	["cpp"] = "C++", -- ok
	["c"] = "C", -- ok
	["C#"] = "C#",
	["Cuda"] = "Cuda",
	["Objective-C"] = "Objective-C",
	["Objective-C++"] = "Objective-C++",
	["python"] = "Python", -- ok
	["java"] = "Java", -- ok
	["Scala"] = "Scala",
	["TeX"] = "TeX",
	["html"] = "HTML", -- ok
	["php"] = "PHP", -- ok
	["javaScript"] = "JavaScript", -- ok
	["typeScript"] = "TypeScript", -- ok
	["go"] = "Go", -- ok
	["sh"] = "Shell", -- ok
	["rust"] = "Rust", -- ok
	["css"] = "CSS", -- ok
	["sql"] = "SQL", -- ok
	["Kotlin"] = "Kotlin",
	["Pascal"] = "Pascal",
	["R"] = "r",
	["Fortran"] = "Fortran",
	["Lean"] = "Lean",
}

return M
