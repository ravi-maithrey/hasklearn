{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_hasklearn (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/bb18ea89cd43645f63d688ad234a062bfd3241912296d84ce62310afc9d73bb7/9.2.5/bin"
libdir     = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/bb18ea89cd43645f63d688ad234a062bfd3241912296d84ce62310afc9d73bb7/9.2.5/lib/aarch64-osx-ghc-9.2.5/hasklearn-0.1.0.0-KIERTZrST4HU8o2sx0UWr-hasklearn"
dynlibdir  = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/bb18ea89cd43645f63d688ad234a062bfd3241912296d84ce62310afc9d73bb7/9.2.5/lib/aarch64-osx-ghc-9.2.5"
datadir    = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/bb18ea89cd43645f63d688ad234a062bfd3241912296d84ce62310afc9d73bb7/9.2.5/share/aarch64-osx-ghc-9.2.5/hasklearn-0.1.0.0"
libexecdir = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/bb18ea89cd43645f63d688ad234a062bfd3241912296d84ce62310afc9d73bb7/9.2.5/libexec/aarch64-osx-ghc-9.2.5/hasklearn-0.1.0.0"
sysconfdir = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/bb18ea89cd43645f63d688ad234a062bfd3241912296d84ce62310afc9d73bb7/9.2.5/etc"

getBinDir     = catchIO (getEnv "hasklearn_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "hasklearn_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "hasklearn_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "hasklearn_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hasklearn_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hasklearn_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
