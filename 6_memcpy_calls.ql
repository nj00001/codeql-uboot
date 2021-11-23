import cpp

from FunctionCall call,Function f
where f.getName() = "memcpy" and call.getTarget() = f
select call
