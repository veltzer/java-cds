# TOFIX

Findings from a code scan on 2026-10-04.

## High

- `scripts/dump_cds.py:17` - `java -Xshare:dump -XX:SharedArchiveFile=classes.jsa sample.jar` passes the jar as a stray positional argument, not on the classpath, so the archive holds only JDK classes. Verified with JDK 25: a run with `-XX:SharedArchiveFile=classes.jsa -Xlog:class+load -cp sample.jar JSmoothPropertiesDisplayer` loads the class with `source: file:.../sample.jar`, not from the shared archive, so the build never demonstrates application CDS. Generate an AppCDS archive instead: `-cp sample.jar` plus `-XX:SharedClassListFile=` (a class list made with `-XX:DumpLoadedClassList`), or `-XX:ArchiveClassesAtExit`.

## Medium

- `summary_of_work_on_grallvm.txt:1` - an internal performance report for a named employer/customer (Amdocs) sits in a PUBLIC repo. Decide whether it belongs here; if not, remove it (and consider history). The filename also misspells GraalVM.
- `wrap.py:1` - a root-level script that the build never checks (ruff/mypy cover only `scripts/`). `ruff check` finds F401 (unused `os`) and I001. It also never `wait()`s on the child and pipes stdout without reading it, so a chatty child can block on a full pipe; the docstring ("get the return text") does not match what it does. Move it to `scripts/` (so it gets linted) and fix it, or delete it if it is just a leftover.
- `README.md:1` - the README is only the heading `# java-cds`. It does not explain what CDS is, what `rsconstruct build` produces (`classes.jsa`), or how to run the comparison. Document the demo; `links.txt` and `doc/TODO.txt` hold the material.

## Low

- `links.txt:1` - a loose link list at the repo root, while siblings keep these under `doc/`. Move it to `doc/links.txt` or fold it into the README.
- `pyproject.toml:10` - `pytest` is in the dev group, but the repo has no tests and no pytest processor. Drop it.
