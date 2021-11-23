import cpp

class NetByteSwap extends Expr{
    NetByteSwap(){
        exists( MacroInvocation MI|  MI.getMacroName().regexpMatch("ntoh(l|ll|s)") and this = MI.getExpr())
    }
}

from NetByteSwap n
select n,"net"

