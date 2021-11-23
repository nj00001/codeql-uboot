
import cpp

from MacroInvocation MI
where MI.getMacroName().regexpMatch("ntoh(l|ll|s)")
select MI
