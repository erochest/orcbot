{-# LANGUAGE TemplateHaskell #-}


module OrcBot.Types
    (
    -- * Args
      Args(..)

    -- * Settings
    , Settings(..)
    , orcOrchestrateSession
    , orcIrcUri
    ) where


import           Control.Lens
import           Database.Orchestrate.Types
import           Network.URI


data Args = Args
          {
          }
          deriving (Show, Eq)

data Settings = Settings
              { _orcOrchestrateSession :: Session
              , _orcIrcUri             :: URI
              } deriving (Show)
$(makeLenses ''Settings)
