function scandir(directory)

    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end
--nema jebeni index 0 u lui -.-
function listvalues(s)
    local t = { }
    for k,v in ipairs(s) do
        t[#t+1] = tostring(v)
    end
    return table.concat(t,"\n")
end

function addFiles(path)

	local files = scandir(path)
	local yes_no = {"Add","Cancel"}
	local dialog= dialog.new ("banner", yes_no)
	dialog.label(dialog, "Pick files to add")
		
	for i,file in ipairs(files) do
			dialog:checkbox(files[i], false,files[i])	
		end

	local button, results = dialog:run()
	local cat={}
	local i = 1
	if results then

		for key,value in pairs(results)
			do
--			msg="\n"..key..":\t"..value
			if value == "1" then				
				cat[i]=key
				geany.message("Ovo je cat["..i.."] "..cat[i])
				i=i+1
				--geany.message(msg)
				--[[
				
				cmd ="cd "..path.."  2>&1\ngit add "..key.."  2>&1"
				geany.message(cmd)
				handle = io.popen(cmd)
				result = handle:read("*a")
				handle:close()
				geany.message(result)
				]]
			end
		
		end
		
		i=i-1
		for j=1,i do
		geany.message(cat[j])
		end
		geany.message(listvalues(cat))
	
	end	
	
end

	local FILE_DIR_PATH = geany.dirname(geany.filename())
	local files = scandir(FILE_DIR_PATH)
	local conc=listvalues(files)


	local yes_no = {"OK","Cancel"}
	local dialogUser= dialog.new ("Unesi Username", yes_no)
	local dialogPass= dialog.new ("Unesi Password", yes_no)
	--dialog.label(dialog, "Pick files to add")
	dialog.label(dialogUser, "							Push							")
	dialog.text(dialogUser, "username", "xxxxxx", "Username" )
	dialog.label(dialogPass, "							Push							")
	dialog.password (dialogPass, "password", "xxxxxx", "Password" )
	
	local btU, resU = dialog.run(dialogUser)
	local btnP, resP = dialog.run(dialogPass)
	
	if resU then
	
		for key,value in pairs(resU)
			do
			msg="\n"..key..":\t"..value
			--geany.message(msg)			
			name=value
		end
	end

	if resP then
		for key,value in pairs(resP)
			do
			msg="\n"..key..":\t"..value
			--geany.message(msg)			
			psw=value
		end
	end
--[[	
	cmd= "cd "..FILE_DIR_PATH.."\ngit push -u origin master 2>&1"--..name.." 2>&1" -- && echo "..name.." && echo "..psw.."\n"
	cmd2="cd "..FILE_DIR_PATH.."\n"..name.."2>&1"
	
	handle = io.popen(cmd)
	handle2 = io.popen(cmd2)
	
	result = handle:read("*a")
	result2 = handle2:read("*a")
	
	handle:close()
	geany.message(" "..cmd.." :\n"..result.."")
	geany.message(" "..cmd2.." :\n"..result2.."")
]]
function runCommand(cmd)
	
	handle = io.popen(cmd)
	result = handle:read("*a")
	handle:close()
	
	return result
end
--	cmd="{GIT} push --repo https://YOUR_USER_NAME:YOUR_PASSWORD@bitbucket.org/repo.git"
	cmd="cd "..FILE_DIR_PATH.."\n git push -u --repo https://VjeraTurk:schweppes6@github.com/VjeraTurk/test 2>&1"
	result = runCommand(cmd)
	geany.message(" "..cmd.." :\n"..result.."")
	--[[
	if message ~= nil then
		cmd="cd "..FILE_DIR_PATH.."  2>&1\n git commit -m \""..message.."\""
	else
		cmd="cd "..FILE_DIR_PATH.."  2>&1\n git commit -m \"no comment\""
	end

	handle = io.popen(cmd)
	result = handle:read("*a")
	handle:close()

	geany.message(" "..cmd.." :\n"..result.."")
	]]
