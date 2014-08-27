{-# LANGUAGE OverloadedStrings #-}


module OrcBot.Options
    ( args
    , envSettings
    ) where


import           Control.Applicative
import           Control.Error
import           Data.Version
import           Database.Orchestrate.Utils
import           Network.URI
import           Options.Applicative
import           System.Environment

import           OrcBot.Types
import           Paths_orcbot


args' :: Parser Args
args' = pure Args

args :: ParserInfo Args
args = info (helper <*> args')
     $  fullDesc
     <> progDesc "A nicer IRC bot."
     <> header ("orc v" ++ showVersion version ++ " --- a nicer IRC bot than Ribot is.")

envSettings :: IO (Either String Settings)
envSettings = do
    session <- envSession
    orcUri  <- getEnv "ORC_URI"
    return . fmap (Settings session) . note ("Invalid URI: " ++ orcUri) $ parseURI orcUri
