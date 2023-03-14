grammar kmmszarp;

program : (statement NEWLINE? | NEWLINE)*;

statement : loopFor | loopWhile | conditional | functionDefinition | variableDeclaration | arrayDeclaration | variableAssignment | arrayAssignment | functionCall;

loopFor : 'pętla' 'zakres' variableDeclaration 'od' INT 'do' INT 'początekpętli' (statement NEWLINE)* 'koniecpętli';
loopWhile : 'pętla' 'podczas' expression 'początekpętli' (statement NEWLINE)* 'koniecpętli';

conditional : 'jeżeli' expression 'wtedy' 'początekjeżeli' (statement NEWLINE)* 'koniecjeżeli';
ifelse: 'jeżeli' expression 'wtedy' 'początekjeżeli' (statement NEWLINE)* 'koniecjeżeli' (NEWLINE)* 'w przeciwnym wypadku' 'początekjeżeli' (statement NEWLINE)* 'koniecjeżeli';

functionDefinition : 'czynność' ID ('parametry' parameterList)? 'zwraca' type 'początekczynności' (statement NEWLINE)* 'koniecczynności';
parameterList : (parameter ('i' parameter)*)?;
parameter : 'zmienna' type ID;

variableDeclaration : 'zmienna' type ID 'to' expression;
arrayDeclaration : 'tablica' type ID 'to' arrayValue ('i' arrayValue)* ('o' 'długości' PINT)?;
arrayValue : expression;

variableReference : ID | arrayAccess;
arrayAccess : 'weź' ID 'element' ID;

variableAssignment : ID 'to' expression;
arrayAssignment : 'włóż' ID 'na' ID 'miejsce' expression;

functionCall : 'wywołaj' ID argumentList;
argumentList : ((variableDeclaration|expression) ('i' (variableDeclaration|expression))*)?;

expression : logicOr;
logicOr : logicAnd ('lub' logicAnd)*;
logicAnd : equality (('oraz') equality)*;
equality : comparison (('równe'|'nierówne') comparison)*;
comparison : addition (('większe niż'|'mniejsze niż'|'większe lub równe'|'mniejsze lub równe') addition)*;
addition : multiplication (('dodać'|'odjąć') multiplication)*;
multiplication : primary (('razy'|'przez'|'moduł') primary)*;
primary : INT | STRING | BOOL | variableReference | LPAR expression RPAR;

type : 'liczba' | 'napis' | 'prawdziwość' | 'nicość';

ID : LETTER (LETTER | DIGIT)*;
INT : ('minus')? DIGIT+;
PINT : DIGIT+;
STRING : 'początekcudzysłowu' ~('\r' | '\n')* 'konieccudzysłowu';
BOOL : 'prawda' | 'kłamstwo';

LPAR : 'począteknawiasu';
RPAR : 'koniecnawiasu';

NEWLINE: '\r'? '\n';
WHITESPACE : [ \t]+ -> skip;

fragment LETTER: 'a'..'z' | 'A'..'Z' | [\u0104-\u0107] | [\u0118-\u0119] | [\u0141-\u0144] | '\u00D3' | '\u00F3' | '\u015A' | '\u015B' | '\u0179' | '\u017A' | '\u017B' | '\u017C'; 
fragment DIGIT: '0'..'9';
