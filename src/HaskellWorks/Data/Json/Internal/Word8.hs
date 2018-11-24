module HaskellWorks.Data.Json.Internal.Word8 where

import Data.Char
import Data.Word
import Data.Word8

isLeadingDigit :: Word8 -> Bool
isLeadingDigit w = w == _hyphen || (w >= _0 && w <= _9)

isTrailingDigit :: Word8 -> Bool
isTrailingDigit w = w == _plus || w == _hyphen || (w >= _0 && w <= _9) || w == _period || w == _E || w == _e

isAlphabetic :: Word8 -> Bool
isAlphabetic w = (w >= _A && w <= _Z) || (w >= _a && w <= _z)

isDigit :: Word8 -> Bool
isDigit w = w >= _0 && w <= _9

wIsJsonNumberDigit :: Word8 -> Bool
wIsJsonNumberDigit w = (w >= _0 && w <= _9) || w == _hyphen

doubleQuote :: Word8
doubleQuote = fromIntegral (ord '"')

backSlash :: Word8
backSlash = fromIntegral (ord '\\')

openBrace :: Word8
openBrace = fromIntegral (ord '{')

closeBrace :: Word8
closeBrace = fromIntegral (ord '}')

openBracket :: Word8
openBracket = fromIntegral (ord '[')

closeBracket :: Word8
closeBracket = fromIntegral (ord ']')

comma :: Word8
comma = fromIntegral (ord ',')

colon :: Word8
colon = fromIntegral (ord ':')

isPeriod :: Word8 -> Bool
isPeriod w = w == 46

isMinus :: Word8 -> Bool
isMinus w = w == 45

isPlus :: Word8 -> Bool
isPlus w = w == 43
