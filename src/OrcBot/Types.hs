{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TemplateHaskell            #-}


module OrcBot.Types
    (
    -- * Args
      Args(..)

    -- * Settings
    , Settings(..)
    , orcOrchestrateSession
    , orcIrcUri

    -- * OrcT
    , OrcT
    , OrcIO
    , withOrc
    ) where


import           Control.Applicative
import qualified Control.Exception          as Ex
import           Control.Lens
import           Control.Monad.Error.Class
import           Control.Monad.IO.Class
import           Control.Monad.Reader.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Reader hiding (ask, local)
import           Database.Orchestrate.Types hiding (ask)
import           Database.Orchestrate.Utils (runO')
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

newtype OrcT m a = OrcT { runOrc :: ReaderT URI (OrchestrateT m) a }
                   deriving ( Functor, Applicative, Monad, MonadIO
                            , MonadError Ex.SomeException)

instance MonadTrans OrcT where
    lift = OrcT . lift . lift

instance Monad m => MonadReader URI (OrcT m) where
    ask     = OrcT $ ask
    local f = OrcT . local f . runOrc

type OrcIO = OrcT IO

withOrc :: Settings -> OrcIO a -> IO (Either Ex.SomeException a)
withOrc Settings{..} m =
    runO' (runReaderT (runOrc m) _orcIrcUri) _orcOrchestrateSession
