

module OrcBot.Types
    ( Args(..)
    ) where


data Args = Args
          { orcConfigFile :: FilePath
          }
          deriving (Show, Eq)
