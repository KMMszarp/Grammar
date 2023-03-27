grammar kmmszarp;

program : (statement NEWLINE? | NEWLINE)*;

statement : loopFor | loopWhile | conditional | functionDefinition | variableDeclaration | arrayDeclaration | variableAssignment | arrayAssignment | functionCall;

loopFor : 'pętla' 'zakres' variableDeclaration 'od' expression 'do' expression 'początek pętli' (statement NEWLINE)* 'koniec pętli';
loopWhile : 'pętla' 'podczas' expression 'początek pętli' NEWLINE* (statement NEWLINE)* 'koniec pętli';

conditional : 'jeżeli' expression 'wtedy' 'początek jeżeli' NEWLINE* (statement NEWLINE)* 'koniec jeżeli';
ifelse: 'jeżeli' expression 'wtedy' 'początek jeżeli' NEWLINE* (statement NEWLINE)* 'koniec jeżeli' (NEWLINE)* 'w przeciwnym wypadku' 'początek jeżeli' NEWLINE* (statement NEWLINE)* 'koniec jeżeli';

functionDefinition : 'czynność' ID ('parametry' parameterList)? 'zwraca' type 'początek czynności' NEWLINE* (statement NEWLINE)* returnStatement? NEWLINE*? 'koniec czynności';
parameterList : (parameter ('i' parameter)*)?;
parameter : 'zmienna' type ID;
returnStatement : 'zwróć' expression;

variableDeclaration : 'zmienna' type ID ('to' expression)?;
arrayDeclaration : 'tablica' type ID 'to' arrayValue ('i' arrayValue)* ('o długości' PINT)?;
arrayValue : expression;

variableReference : ID | arrayAccess;
arrayAccess : 'weź' expression 'element' expression;

variableAssignment : ID 'to' expression;
arrayAssignment : 'włóż' expression 'na' expression 'miejsce' expression;

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
STRING : 'początek cudzysłowu' ~('\r' | '\n')* 'koniec cudzysłowu';
BOOL : 'prawda' | 'kłamstwo';

LPAR : 'początek nawiasu';
RPAR : 'koniec nawiasu';

NEWLINE: '\r'? '\n';
WHITESPACE : [ \t]+ -> skip;

fragment LETTER: 'a'..'z' | 'A'..'Z' | [\u0104-\u0107] | [\u0118-\u0119] | [\u0141-\u0144] | '\u00D3' | '\u00F3' | '\u015A' | '\u015B' | '\u0179' | '\u017A' | '\u017B' | '\u017C'; 
fragment DIGIT: '0'..'9';
