{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_hasklearn (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/644c83ddabd724f43e13842e4a36551907685244d071f86aac204db3048a186a/9.0.2/bin"
libdir     = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/644c83ddabd724f43e13842e4a36551907685244d071f86aac204db3048a186a/9.0.2/lib/aarch64-osx-ghc-9.0.2/hasklearn-0.1.0.0-LrBGaPveQNj6lBc13uy3VD-hasklearn"
dynlibdir  = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/644c83ddabd724f43e13842e4a36551907685244d071f86aac204db3048a186a/9.0.2/lib/aarch64-osx-ghc-9.0.2"
datadir    = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/644c83ddabd724f43e13842e4a36551907685244d071f86aac204db3048a186a/9.0.2/share/aarch64-osx-ghc-9.0.2/hasklearn-0.1.0.0"
libexecdir = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/644c83ddabd724f43e13842e4a36551907685244d071f86aac204db3048a186a/9.0.2/libexec/aarch64-osx-ghc-9.0.2/hasklearn-0.1.0.0"
sysconfdir = "/Users/ravimaith/Documents/hasklearn/.stack-work/install/aarch64-osx/644c83ddabd724f43e13842e4a36551907685244d071f86aac204db3048a186a/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hasklearn_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hasklearn_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hasklearn_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hasklearn_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hasklearn_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hasklearn_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
