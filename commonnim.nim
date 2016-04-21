import strutils

proc readAllBuffer(file: File): string =
  result = ""
  const BufSize = 1024
  var buffer = newString(BufSize)
  while true:
    var bytesRead = readBuffer(file, addr(buffer[0]), BufSize)
    if bytesRead == BufSize:
      result.add(buffer)
    else:
      buffer.setLen(bytesRead)
      result.add(buffer)
      break

proc readFileSysfs*(filename: string): TaintedString =
  var f = open(filename)
  try:
    result = readAllBuffer(f).TaintedString
  finally:
    close(f)

# --- unpackSeq ---

type Pair[A, B] = tuple[first: A, second: B]

proc unpackSeq1*[T](args: T): auto =
  assert args.len == 1
  return args[0]

proc unpackSeq2*[T](args: T): auto =
  assert args.len == 2
  return (args[0], args[1])

proc unpackSeq3*[T](args: T): auto =
  assert args.len == 3
  return (args[0], args[1], args[2])

# urandom
import collections/bytes, collections/random, collections/lang
export bytes, random, lang
