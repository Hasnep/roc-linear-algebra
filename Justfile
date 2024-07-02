default: codegen format check test docs examples

codegen:
    julia --project=./codegen --startup-file=no --quiet --compile=min --optimize=0 --eval='import Pkg; Pkg.instantiate(); import RocLinAlg; RocLinAlg.main();'
    @just format

format:
    roc format src/
    roc format examples/

check:
    roc check src/main.roc
    fd --extension roc . examples --exec roc check

test:
    roc test src/main.roc

docs:
    roc docs src/main.roc

examples:
    fd --extension roc . examples --exec roc run
