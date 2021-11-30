import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetByteSwap extends Expr{
    NetByteSwap(){
        exists( MacroInvocation MI|  MI.getMacroName().regexpMatch("ntoh(l|ll|s)") and this = MI.getExpr())
    }

}

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFuncLength" }
  
    override predicate isSource(DataFlow::Node source) {
      source.asExpr() instanceof NetByteSwap
    }
    override predicate isSink(DataFlow::Node sink) {
      exists(FunctionCall call|  call.getTarget().getName() = "memcpy" 
                                and call.getArgument(2) = sink.asExpr())
                                
    }
}

from DataFlow::PathNode source,DataFlow::PathNode sink,Config cfg
where  cfg.hasFlowPath(source, sink)
select source,sink
