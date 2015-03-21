{
   if (index($0, "to-check=") > 0)
   {
	split($0, pieces, "to-check=");
	term = substr(pieces[2], 0, length(pieces[2])-1);
	split(term, division, "/");
	print (1-(division[1]/division[2]))*100"%"
   }
   else
   {
	print "#"$0;
   }
   fflush();
}
