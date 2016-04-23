# FindIdsAntlr
Antlr realization of finding ids from map in text.

## Run command
```
	$ antlr4 FindIds.g4 && javac FindIds*.java && grun FindIds prog data.txt
```

## Example
### text.txt
```
asdfqwerwqef qaf	wer	asDFADFQ QAW) ( ( z
f (
	1, 2, k(
		1, m(
			1, 2, 3, 4, f(
				1, 2, 3
			)
		)
	)
) f(1,2,3,1)
```
### Output
```
ERROR <unknown_id>: asdfqwerwqef [Line: 1, Position: 0]
ERROR <unknown_id>: qaf [Line: 1, Position: 13]
ERROR <unknown_id>: wer [Line: 1, Position: 17]
ERROR <unknown_id>: asDFADFQ [Line: 1, Position: 21]
ERROR <unknown_id>: QAW [Line: 1, Position: 30]
ERROR <unknown_id>: z [Line: 1, Position: 39]
Found id f [Line: 5 [Line: 5, Position: 15]
Found id m [Line: 4 [Line: 4, Position: 5]
Found id k [Line: 3 [Line: 3, Position: 7]
Found id f [Line: 2 [Line: 2, Position: 0]
ERROR wrong number of arguments for id f (3 should be 2) [Line: 10, Position: 2]
######## knownIdsMap={f=3, k=2, m=5}
```