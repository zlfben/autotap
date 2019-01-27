AutoTap
===
## Requirement
- spot model checker
- qm0.2

## Run with docker
```console
docker build -t "autotap:v1" .
docker run -i -t autotap:v1
(in container) python3 test.py EvaluationTest
```
