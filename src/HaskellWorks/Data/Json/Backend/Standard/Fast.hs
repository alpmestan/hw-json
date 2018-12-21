{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE TypeSynonymInstances #-}

module HaskellWorks.Data.Json.Backend.Standard.Fast
  ( makeCursor
  ) where

import Data.Word
import Foreign.ForeignPtr
import HaskellWorks.Data.FromForeignRegion
import HaskellWorks.Data.Json.Backend.Standard.Cursor
import HaskellWorks.Data.Json.Internal.Vector
import HaskellWorks.Data.RankSelect.Poppy512

import qualified Data.ByteString                                       as BS
import qualified Data.ByteString.Char8                                 as BSC
import qualified Data.ByteString.Internal                              as BSI
import qualified Data.ByteString.Lazy                                  as LBS
import qualified Data.Vector.Storable                                  as DVS
import qualified HaskellWorks.Data.BalancedParens                      as BP
import qualified HaskellWorks.Data.Json.Internal.Backend.Standard.IbBp as J

class MakeCursor a where
  makeCursor :: a -> JsonCursor BS.ByteString Poppy512 (BP.SimpleBalancedParens (DVS.Vector Word64))

instance MakeCursor BS.ByteString where
  makeCursor bs = JsonCursor
    { cursorText      = bs
    , interests       = makePoppy512 ib
    , balancedParens  = BP.SimpleBalancedParens bp
    , cursorRank      = 1
    }
    where J.IbBp ib bp = J.toIbBp bs

instance MakeCursor String where
  makeCursor = makeCursor . BSC.pack

instance MakeCursor ForeignRegion where
  makeCursor (fptr, offset, size) = makeCursor (BSI.fromForeignPtr (castForeignPtr fptr) offset size)

instance MakeCursor [(BS.ByteString, BS.ByteString)] where
  makeCursor ((ib, bp):as) = unroll2 ib
