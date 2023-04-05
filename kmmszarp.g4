grammar kmmszarp;

program : (statement NEWLINE? | NEWLINE)*;

statement
    : loopFor
    | loopWhile
    | conditional
    | ifelse
    | functionDefinition
    | variableDeclaration
    | arrayDeclaration
    | variableAssignment
    | arrayAssignment
    | functionCall
    | cast;

loopFor : 'pętla' 'zakres' variableDeclaration 'od' expression 'do' expression 'początek pętli' NEWLINE* (statement NEWLINE)* 'koniec pętli';
loopWhile : 'pętla' 'podczas' expression 'początek pętli' NEWLINE* (statement NEWLINE)* 'koniec pętli';

conditional : 'jeżeli' expression 'wtedy' 'początek jeżeli' NEWLINE* (statement NEWLINE)* 'koniec jeżeli';
ifelse: 'jeżeli' expression 'wtedy' 'początek jeżeli' NEWLINE* (statement NEWLINE)* 'koniec jeżeli' (NEWLINE)* 'w przeciwnym wypadku' 'początek jeżeli' NEWLINE* (statement NEWLINE)* 'koniec jeżeli';

functionDefinition : 'czynność' ID ('parametry' parameterList)? 'zwraca' type 'początek czynności' NEWLINE* (statement NEWLINE)* returnStatement? NEWLINE*? 'koniec czynności';
parameterList : (parameter ('i' parameter)*)?;
parameter : 'zmienna' type ID;
returnStatement : 'zwróć' expression;

variableDeclaration
    :'zmienna' type ID # pureVariableDeclaration
    |'zmienna' type ID 'to' expression # variableDeclarationWithAssignment
    ;

arrayDeclaration : 'tablica' type ID 'to' arrayValue ('i' arrayValue)* ('o długości' PINT)?;
arrayValue : expression;

variableReference : ID | arrayAccess;
arrayAccess : 'weź' expression 'element' expression;

variableAssignment : ID 'to' expression;
arrayAssignment : 'włóż' expression 'na' expression 'miejsce' expression;

functionCall : 'wywołaj' ID argumentList;
argumentList : ((variableDeclaration|expression) ('i' (variableDeclaration|expression))*)?;

cast : 'rzuć' expression 'na' type;

expression
    : expression op=('razy'|'przez'|'moduł') expression # Multiplication
    | expression op=('dodać'|'odjąć') expression # Addition
    | expression op=('większe niż'|'mniejsze niż'|'większe lub równe'|'mniejsze lub równe') expression # Comparison
    | expression eq=('równe'|'nierówne') expression # Equality
    | expression and='oraz' expression # LogicAnd
    | expression or='lub' expression # LogicOr
    | primary # PrimaryExpression
    ;

primary
    : INT # IntLiteral
    | STRING # StringLiteral
    | BOOL # BoolLiteral
    | variableReference # VariableReferencePrimary
    | LPAR expression RPAR # ParenthesizedExpression
    ;

type : 'liczba' | 'napis' | 'prawdziwość' | 'nicość';

EXID : 'odkryj' ID;

ID : ULETTER (ULETTER | DIGIT)*;
INT : ('minus')? DIGIT+;
PINT : DIGIT+;
STRING : 'początek cudzysłowu' ~('\r' | '\n')* 'koniec cudzysłowu';
BOOL : 'prawda' | 'kłamstwo';

LPAR : 'początek nawiasu';
RPAR : 'koniec nawiasu';

WHITESPACE : [ \t]+ -> skip;
NEWLINE: '\r'? '\n';

fragment ULETTER
    : 'A'..'Z'
    | '\u0104' | '\u0106' | '\u0118' | '\u0141' | '\u0143' | '\u00D3' | '\u015A' | '\u0179' | '\u017B';

fragment LETTER
    : 'a'..'z' | 'A'..'Z'
    | [\u0104-\u0107] | [\u0118-\u0119] | [\u0141-\u0144]
    | '\u00D3' | '\u00F3' | '\u015A' | '\u015B' | '\u0179' | '\u017A' | '\u017B' | '\u017C';

fragment DIGIT: '0'..'9';
