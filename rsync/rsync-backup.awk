{
   if (index($0, "ir-chk=") > 0)
   {
	split($0, pieces, "ir-chk=");
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
