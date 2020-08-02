import parsecfg except Config
import strutils

type
  Config* = ref object
    host*: string
    port*: int


proc get*[T](config: parsecfg.Config, s, v: string, default: T): T=
  let val = config.getSectionValue(s, v)
  if val.len == 0: return default

  when T is int: parseInt(val)
  elif T is bool: parseBool(val)
  elif T is string: val

proc getConfig*(path: string): Config =
  let cfg = loadConfig(path)
  return Config( 
              host: cfg.get("", "host", "0.0.0.0"),
              port: cfg.get("", "port", 5000)
  )
