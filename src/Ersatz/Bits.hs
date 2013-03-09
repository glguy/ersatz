{-# LANGUAGE TypeFamilies, DeriveDataTypeable, DeriveGeneric #-}
--------------------------------------------------------------------
-- |
-- Copyright :  (c) Edward Kmett 2010-2013, Johan Kiviniemi 2013
-- License   :  BSD3
-- Maintainer:  Edward Kmett <ekmett@gmail.com>
-- Stability :  experimental
-- Portability: non-portable
--
--------------------------------------------------------------------
module Ersatz.Bits
  ( Bit1(..), Bit2(..), Bit3(..), Bit4(..), Bit5(..), Bit6(..), Bit7(..), Bit8(..)
  ) where

import Prelude hiding ((&&), (||), and, or, not)

import Control.Applicative
import Data.Bits (Bits, (.&.), (.|.), shiftL, shiftR)
import Data.List (foldl')
import Data.Typeable
import Data.Word (Word8)
import Ersatz.Bit
import Ersatz.Decoding
import Ersatz.Equatable
import Ersatz.Encoding
import Ersatz.Variable
import GHC.Generics

newtype Bit1 = Bit1 Bit deriving (Show,Typeable,Generic)
data Bit2 = Bit2 Bit Bit deriving (Show,Typeable,Generic)
data Bit3 = Bit3 Bit Bit Bit deriving (Show,Typeable,Generic)
data Bit4 = Bit4 Bit Bit Bit Bit deriving (Show,Typeable,Generic)
data Bit5 = Bit5 Bit Bit Bit Bit Bit deriving (Show,Typeable,Generic)
data Bit6 = Bit6 Bit Bit Bit Bit Bit Bit deriving (Show,Typeable,Generic)
data Bit7 = Bit7 Bit Bit Bit Bit Bit Bit Bit deriving (Show,Typeable,Generic)
data Bit8 = Bit8 Bit Bit Bit Bit Bit Bit Bit Bit deriving (Show,Typeable,Generic)

instance Boolean Bit1
instance Boolean Bit2
instance Boolean Bit3
instance Boolean Bit4
instance Boolean Bit5
instance Boolean Bit6
instance Boolean Bit7
instance Boolean Bit8

instance Equatable Bit1
instance Equatable Bit2
instance Equatable Bit3
instance Equatable Bit4
instance Equatable Bit5
instance Equatable Bit6
instance Equatable Bit7
instance Equatable Bit8

instance Variable Bit1 where
  exists = Bit1 <$> exists
  forall = Bit1 <$> forall

instance Variable Bit2 where
  exists = Bit2 <$> exists <*> exists
  forall = Bit2 <$> forall <*> forall

instance Variable Bit3 where
  exists = Bit3 <$> exists <*> exists <*> exists
  forall = Bit3 <$> forall <*> forall <*> forall

instance Variable Bit4 where
  exists = Bit4 <$> exists <*> exists <*> exists <*> exists
  forall = Bit4 <$> forall <*> forall <*> forall <*> forall

instance Variable Bit5 where
  exists = Bit5 <$> exists <*> exists <*> exists <*> exists <*> exists
  forall = Bit5 <$> forall <*> forall <*> forall <*> forall <*> forall

instance Variable Bit6 where
  exists = Bit6 <$> exists <*> exists <*> exists <*> exists <*> exists <*> exists
  forall = Bit6 <$> forall <*> forall <*> forall <*> forall <*> forall <*> forall

instance Variable Bit7 where
  exists = Bit7 <$> exists <*> exists <*> exists <*> exists <*> exists <*> exists <*> exists
  forall = Bit7 <$> forall <*> forall <*> forall <*> forall <*> forall <*> forall <*> forall

instance Variable Bit8 where
  exists = Bit8 <$> exists <*> exists <*> exists <*> exists <*> exists <*> exists <*> exists <*> exists
  forall = Bit8 <$> forall <*> forall <*> forall <*> forall <*> forall <*> forall <*> forall <*> forall

instance Decoding Bit1 where
  type Decoded Bit1 = Word8
  decode s (Bit1 a) = boolsToNum1 <$> decode s a

instance Decoding Bit2 where
  type Decoded Bit2 = Word8
  decode s (Bit2 a b) = boolsToNum2 <$> decode s a <*> decode s b

instance Decoding Bit3 where
  type Decoded Bit3 = Word8
  decode s (Bit3 a b c) = boolsToNum3 <$> decode s a <*> decode s b <*> decode s c

instance Decoding Bit4 where
  type Decoded Bit4 = Word8
  decode s (Bit4 a b c d) = boolsToNum4 <$> decode s a <*> decode s b <*> decode s c <*> decode s d

instance Decoding Bit5 where
  type Decoded Bit5 = Word8
  decode s (Bit5 a b c d e) = boolsToNum5 <$> decode s a <*> decode s b <*> decode s c <*> decode s d <*> decode s e

instance Decoding Bit6 where
  type Decoded Bit6 = Word8
  decode s (Bit6 a b c d e f) = boolsToNum6 <$> decode s a <*> decode s b <*> decode s c <*> decode s d <*> decode s e <*> decode s f

instance Decoding Bit7 where
  type Decoded Bit7 = Word8
  decode s (Bit7 a b c d e f g) = boolsToNum7 <$> decode s a <*> decode s b <*> decode s c <*> decode s d <*> decode s e <*> decode s f <*> decode s g

instance Decoding Bit8 where
  type Decoded Bit8 = Word8
  decode s (Bit8 a b c d e f g h) = boolsToNum8 <$> decode s a <*> decode s b <*> decode s c <*> decode s d <*> decode s e <*> decode s f <*> decode s g <*> decode s h

instance Encoding Bit1 where
  type Encoded Bit1 = Word8
  encode = encodeBit1

instance Encoding Bit2 where
  type Encoded Bit2 = Word8
  encode = encodeBit2

instance Encoding Bit3 where
  type Encoded Bit3 = Word8
  encode = encodeBit3

instance Encoding Bit4 where
  type Encoded Bit4 = Word8
  encode = encodeBit4

instance Encoding Bit5 where
  type Encoded Bit5 = Word8
  encode = encodeBit5

instance Encoding Bit6 where
  type Encoded Bit6 = Word8
  encode = encodeBit6

instance Encoding Bit7 where
  type Encoded Bit7 = Word8
  encode = encodeBit7

instance Encoding Bit8 where
  type Encoded Bit8 = Word8
  encode = encodeBit8

encodeBit1 :: Word8 -> Bit1
encodeBit1 i = Bit1 a where (a:_) = bitsOf i

encodeBit2 :: Word8 -> Bit2
encodeBit2 i = Bit2 a b where (b:a:_) = bitsOf i

encodeBit3 :: Word8 -> Bit3
encodeBit3 i = Bit3 a b c where (c:b:a:_) = bitsOf i

encodeBit4 :: Word8 -> Bit4
encodeBit4 i = Bit4 a b c d where (d:c:b:a:_) = bitsOf i

encodeBit5 :: Word8 -> Bit5
encodeBit5 i = Bit5 a b c d e where (e:d:c:b:a:_) = bitsOf i

encodeBit6 :: Word8 -> Bit6
encodeBit6 i = Bit6 a b c d e f where (f:e:d:c:b:a:_) = bitsOf i

encodeBit7 :: Word8 -> Bit7
encodeBit7 i = Bit7 a b c d e f g where (g:f:e:d:c:b:a:_) = bitsOf i

encodeBit8 :: Word8 -> Bit8
encodeBit8 i = Bit8 a b c d e f g h where (h:g:f:e:d:c:b:a:_) = bitsOf i

boolsToNum1 :: Bool -> Word8
boolsToNum1 a = boolToNum a

boolsToNum2 :: Bool -> Bool -> Word8
boolsToNum2 a b = boolsToNum [a,b]

boolsToNum3 :: Bool -> Bool -> Bool -> Word8
boolsToNum3 a b c = boolsToNum [a,b,c]

boolsToNum4 :: Bool -> Bool -> Bool -> Bool -> Word8
boolsToNum4 a b c d = boolsToNum [a,b,c,d]

boolsToNum5 :: Bool -> Bool -> Bool -> Bool -> Bool -> Word8
boolsToNum5 a b c d e = boolsToNum [a,b,c,d,e]

boolsToNum6 :: Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Word8
boolsToNum6 a b c d e f = boolsToNum [a,b,c,d,e,f]

boolsToNum7 :: Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Word8
boolsToNum7 a b c d e f g = boolsToNum [a,b,c,d,e,f,g]

boolsToNum8 :: Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Bool -> Word8
boolsToNum8 a b c d e f g h = boolsToNum [a,b,c,d,e,f,g,h]

bitsOf :: (Num a, Bits a) => a -> [Bit]
bitsOf n = bool (numToBool (n .&. 1)) : bitsOf (n `shiftR` 1)
{-# INLINE bitsOf #-}

numToBool :: (Eq a, Num a) => a -> Bool
numToBool 0 = False
numToBool _ = True
{-# INLINE numToBool #-}

boolsToNum :: (Num a, Bits a) => [Bool] -> a
boolsToNum = foldl' (\n a -> (n `shiftL` 1) .|. boolToNum a) 0
{-# INLINE boolsToNum #-}

boolToNum :: Num a => Bool -> a
boolToNum False = 0
boolToNum True  = 1
{-# INLINE boolToNum #-}