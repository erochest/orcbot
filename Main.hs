{-# LANGUAGE OverloadedStrings #-}


module Main where


import Options.Applicative

import OrcBot.Options


main :: IO ()
main = print =<< execParser args
