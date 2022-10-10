{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_n_body_problem (
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

bindir     = "/Users/ravimaith/Documents/n_body_problem/.stack-work/install/aarch64-osx/538e5cfd6d0ab2aa57857467572052df83a547fb10f4981a8d0a7661d6c7da30/9.0.2/bin"
libdir     = "/Users/ravimaith/Documents/n_body_problem/.stack-work/install/aarch64-osx/538e5cfd6d0ab2aa57857467572052df83a547fb10f4981a8d0a7661d6c7da30/9.0.2/lib/aarch64-osx-ghc-9.0.2/n-body-problem-0.1.0.0-5at9Nn1EplhGMOW8FSysIi-n-body-problem"
dynlibdir  = "/Users/ravimaith/Documents/n_body_problem/.stack-work/install/aarch64-osx/538e5cfd6d0ab2aa57857467572052df83a547fb10f4981a8d0a7661d6c7da30/9.0.2/lib/aarch64-osx-ghc-9.0.2"
datadir    = "/Users/ravimaith/Documents/n_body_problem/.stack-work/install/aarch64-osx/538e5cfd6d0ab2aa57857467572052df83a547fb10f4981a8d0a7661d6c7da30/9.0.2/share/aarch64-osx-ghc-9.0.2/n-body-problem-0.1.0.0"
libexecdir = "/Users/ravimaith/Documents/n_body_problem/.stack-work/install/aarch64-osx/538e5cfd6d0ab2aa57857467572052df83a547fb10f4981a8d0a7661d6c7da30/9.0.2/libexec/aarch64-osx-ghc-9.0.2/n-body-problem-0.1.0.0"
sysconfdir = "/Users/ravimaith/Documents/n_body_problem/.stack-work/install/aarch64-osx/538e5cfd6d0ab2aa57857467572052df83a547fb10f4981a8d0a7661d6c7da30/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "n_body_problem_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "n_body_problem_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "n_body_problem_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "n_body_problem_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "n_body_problem_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "n_body_problem_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
