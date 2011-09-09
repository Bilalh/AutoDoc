#!/usr/bin/env ruby19
string = STDIN.read

# Tests
# string = '-(id) initWithFilename:(NSString *)filename;'
# string ='-(id) initWithFilename:(NSString *)filename;'
# string ='- (void) setAlbumUrl:(NSString *)url;'
# string ='- (void) initButtonsState;'
# 
# string = <<EOF
# - (NSMutableDictionary*) makeButtonProperties:(NSString*)b1Title
#  								 button1Full:(NSString*)b1Full
#  								button2Title:(NSString*)b2Title
#  								 button2Full:(NSString*)b2Full
#  										name:(NSString*)name;
# EOF
# string = '- (NSString*) initWithTagString:(String::s) cppString;'


# Example 
# /** Changes the Language of of the specifed field.
#  
#  Each field can have a different language, the sender button language is switch with 
#  the current language.
#   
#  @param properties       The properties containg the data about the new language.	
#  @param buttonProperties The properties containg the data of the sender button.
#  */


vars = string.scan(/\([\w *^:]+\)\s*(\w+)/m).flatten;
returnPrint  = !string[/(void|IBAction|IBOutlet)/]

puts <<-EOF
/** 
 
EOF

if vars.length >=2 then

max = vars[1].length
vars[1..-1].each { |e| max  = e.length if e.length > max }

vars[1..-1].each do |e|
	puts " @param #{e.ljust max} " 
end
end

if returnPrint then
	puts " @return "
end

puts " */"
puts string