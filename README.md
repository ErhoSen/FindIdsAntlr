# FindIdsAntlr
Antlr realization of finding ids from map in text.

## Run command
```
	$ antlr4 FindIds.g4 && javac FindIds*.java && grun FindIds prog data.txt
```

## Example
### knownIdsMap = { f=3, k=2, m=5 }
### data.txt
```
f() ASDAS 
c(1,2,3,4,f(1,f()),6,7)
f(1)
f(1,2)
f(1,2,3)
f(1,2,3,4)
```
### Output
```
Found id f satisfied arity 0 [Line: 1, Position: 0]
ERROR <unknown_id>: ASDAS [Line: 1, Position: 4]
Found id f satisfied arity 0 [Line: 2, Position: 14]
Found id f satisfied arity 2 [Line: 2, Position: 10]
Found id c satisfied arity 7 [Line: 2, Position: 0]
Found id f satisfied arity 1 [Line: 3, Position: 0]
Found id f satisfied arity 2 [Line: 4, Position: 0]
Found id f satisfied arity 3 [Line: 5, Position: 0]
ERROR wrong number of arguments for id f (found 4, can be [0, 1, 2, 3]) [Line: 6, Position: 0]
######## knownIdsMap={c=[7, 4], f=[0, 1, 2, 3]}
```