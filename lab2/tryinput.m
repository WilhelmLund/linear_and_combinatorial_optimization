% Petter Strandmark 2012
function D = tryinput(str)
	ok = false;
	while ~ok
		ok = true;
		try
			D = input(str);
		catch 
			disp('Incorrect input, use brackets: [1 2 3]');
			ok = false;
		end
	end
end