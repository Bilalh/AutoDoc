#!/usr/bin/env ruby


#TODO func and block pointers
# tests
# line = "type ***parse_time ( );"
# line = "struct tm *parse_time(char *aaa);"
# line = "void *parse_time_spec(char** strarr, struct tm* tm, int *index, int multiplier);"
# line = "#define dprintf(fmt, ...) "
# line = "void string_add_m(String *s, bool add_space, int length, ...)"
# line = "int main (int argc, char *argv[])" 
# line = "int main (int argc, const char *argv[])" 
# line = "bool strcmp_null(const char *s1, const char *s2);"
# line = "bool strcmp_null(const char *s1, char *s2);"
# line = "bool strcmp_null( 
#           const char *s1, 
#           char *s2 
#         );"
# line = "int
#      mergesort(void *base, size_t nel, size_t width,
#          int a);
# "
# FIXME
# line = "int ss(int *a, int (*compar)(const void *, const void *));"

# line = STDIN.read
line = `head -n $((TM_LINE_NUMBER+1)) | tail -n 1`

# Makes sure the below line is a funs  (but allow zero spaces with stars and no ,)
if !((line =~ /^(struct\s+)?\w+\s*\**\s*\w+\s*\((\s*\w+\s*\**\s*\w+(\[\])?\s*,?)*(\w*\s*\.\.\.)?\s*\)/) ||
	 (line =~ /^#define\s+\w+\(.*\)/ )) then
	exit(0)
end
	
ret_val =  line[/^(?:(?:struct\s*)?\w+)/]
words = line.scan(/(\w+\[?\]?|\w*\s*\.\.\.)\s*[,\)]/).to_a.flatten

i = 0
dox = "/**\n"
dox << " * @brief $#{i+=1}\n"
dox << " *\n" if words.length > 0
words.each do |e|
	e.sub! /\[\]/, ""
	dox << " * @param #{e.strip} $#{i+=1}\n"
end
dox << " * @return $#{i+=1}\n" if ret_val != "void"  && ret_val != nil
dox << "**/"
print dox