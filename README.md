# HTTP/0.9 Request Parser 
A HTTP/0.9 request parser written in C (flex and bison).

## Specification
A limited HTTP/0.9 specification is available [here](https://www.w3.org/Protocols/HTTP/AsImplemented.html)

## Usage
### Build
```bash
make
```

### Run
```bash
./http09_parser ./file.txt
```

### Run tests
```bash
python test.py
```