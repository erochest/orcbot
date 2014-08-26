{-# LANGUAGE OverloadedStrings #-}


module OrcBot.Options
    ( args
    ) where


import           Data.Version
import           Options.Applicative

import           OrcBot.Types
import           Paths_orcbot


args' :: Parser Args
args' =   Args
      <$> strOption (  long "config" <> short 'c'
                    <> metavar "CONFIG_FILE"
                    <> help "The configuration file."
                    )

args :: ParserInfo Args
args = info (helper <*> args')
     $  fullDesc
     <> progDesc "A nicer IRC bot."
     <> header ("orc v" ++ showVersion version ++ " --- a nicer IRC bot than Ribot is.")

