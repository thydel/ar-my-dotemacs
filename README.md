# Usage

[shar(1)]: https://linux.die.net/man/1/shar "man"
[dotemacs-role.yml]: dotemacs-role.yml "file"

Edit [shar(1)][] like [dotemacs-role.yml][]

```bash
make main host=$somenode
make run main host=$somenode

version () { ansible --version | cut -d. -f-2 | line | fmt -1 | sed -n 2p; }
versions () { version | xargs -i echo ${1:?} {} | fmt -1 | sort -V; }
min-version () { versions ${1:?} | line | xargs -i test $1 = {}; }
choose-python () { min-version 2.10 && env ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3 "$@" || "$@"; }

choose-python dotemacs-play.yml -i localhost, -c local -CD
```
