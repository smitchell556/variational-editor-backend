module VariationalCompiler.View where
import VariationalCompiler.Entities

getView :: [Selection] -> Program -> Program
getView cs (P p) = P $ view cs p

-- | Reduces a set of a program given a list of choices.
view :: [Selection] -> [Segment] -> [Segment] 
view cs = concatMap (viewSegment cs)

-- | Reduces a segment given a list of choices.
viewSegment :: [Selection] -> Segment -> [Segment]
viewSegment cs (Choice i l r) = case lookup i cs of
        Nothing          -> [Choice i (view cs l) (view cs r)]
        Just LeftBranch  -> view cs l
        Just RightBranch -> view cs r
-- It's assumed that anything besides a dimension will just be a text segment.
viewSegment _ js = [js]
