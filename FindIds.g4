grammar FindIds;

@header {
    import java.util.HashMap;
    import org.antlr.v4.runtime.Token;
}

@members {
    public static HashMap<String, Integer> knownIdsMap;
    static {
        knownIdsMap = new HashMap<String, Integer>();
        knownIdsMap.put("f", 3);
        knownIdsMap.put("k", 2);
        knownIdsMap.put("m", 5);
    }

    public static String lineCharPos(Token token) {
        return " [Line: " + token.getLine() + ", Position: " + token.getCharPositionInLine() + "]";
    }
}

prog: text*
    {
        System.out.println("######## knownIdsMap="+ knownIdsMap);
    };

text: butId | apply;

butId: OPEN | COMMA | CLOSE | id=unknownId
    {
        String id = $id.start.getText();
        System.out.println("ERROR <unknown_id>: " + id + lineCharPos($id.start));
    };

apply locals[int arity=0]: id=knownId OPEN balArgs=balancedArgs CLOSE
    {
        String id = $id.start.getText();
        // int realArity = knownIdsMap.get(id).size() - 1;
        int realArity = knownIdsMap.get(id) - 1;
        int arity = $balArgs.arity;
        if ( realArity == arity ){
            System.out.println("Found id " + id + " [Line: " + $id.start.getLine() + lineCharPos($id.start));
        } else { // ERROR wrong number of arguments for id {ID} ({arity} should be {N}) [Line: {L}, Position: {P}]
            System.out.println("ERROR wrong number of arguments for id " + id + " (" + arity + " should be " + realArity + ")" + lineCharPos($id.start));
        }
    };

balancedArgs returns [int arity]: {$arity = 0;} balancedArg? (COMMA balancedArg {$arity++;})*;

balancedArg: INT | apply;

knownId: {knownIdsMap.containsKey($id)}? id=IDENTIFIER | unknownId;
unknownId: {!knownIdsMap.containsKey($id)}? id=IDENTIFIER;


IDENTIFIER : [a-zA-Z]+ ;
INT : [0-9]+ ;
WS : [ \t\r\n]+ -> skip ;

UNKNOWNID : [a-zA-Z]+;
OPEN : '(' ;
CLOSE : ')' ;
COMMA : [,] ;


//if (knownIdsMap.get($id.currentId) != null){
//    System.out.println(knownIdsMap.get(current));
//    System.out.println($balArgs.arity);
//    if (knownIdsMap.get(current) - 1 == $balArgs.arity){
//        System.out.println("FOUND PATTERN: func " + current + '(' + $balArgs.text + ") FOR " + current + '(' + knownIdsMap.get(current) + ')');
//    }
//}

//anId returns [String currentId = ""]: id=IDENTIFIER
//    {
//        if ( knownIdsMap.containsKey($id.text) ) {
//            System.out.println("Found! "+ $id.text);
//            foundIds.add($id.text);
//        } else {
//            System.out.println("Not Found! "+ $id.text);
//            unknownIds.add($id.text);
//        }
//        currentId = $id.text;
//    };

//apply locals[int arity=0]: balArgs=balancedArgs 
//    {
//        if (knownIdsMap.get(current) != null){
//            System.out.println(knownIdsMap.get(current));
//            System.out.println($balArgs.arity);
//            if (knownIdsMap.get(current) - 1 == $balArgs.arity){
//                System.out.println("FOUND PATTERN: func " + current + '(' + $balArgs.text + ") FOR " + current + '(' + knownIdsMap.get(current) + ')');
//            }
//        }
//    };


//text: butId
//    | butId apply text;
//
//butId: OPEN | COMMA | CLOSE | unknownId;
//
//apply locals [int arity=-1] : id=knownId ( {$arity=0;} | OPEN balArgs=balancedArgs CLOSE {$arity=$balArgs.arity;} )
//       {ourIdentMap[$id.Text] == arity}? ;
//
//balancedArgs returns [int arity]: {$arity = 0;} balancedArg (COMMA balancedArg {$arity++;} )*;
//
//balancedArg:
//       | unknownId balancedArg
//       | OPEN balancedArgs CLOSE;
//
//knownId: id=IDENTIFIER {ourIdentMap.Contains($id)}?;
//unknownId: id=IDENTIFIER {!ourIdentMap.Contains($id)}?;