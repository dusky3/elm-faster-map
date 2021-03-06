module Fast.List6 exposing (foldr, map)


map : (a -> b) -> List a -> List b
map op list =
    chunkAndMap op list []


chunkAndMap : (a -> b) -> List a -> List (List a) -> List b
chunkAndMap op list chunks =
    case list of
        a :: b :: c :: d :: e :: f :: [] ->
            mapChunks op chunks [ op a, op b, op c, op d, op e, op f ]

        a :: b :: c :: d :: e :: [] ->
            mapChunks op chunks [ op a, op b, op c, op d, op e ]

        a :: b :: c :: d :: [] ->
            mapChunks op chunks [ op a, op b, op c, op d ]

        a :: b :: c :: [] ->
            mapChunks op chunks [ op a, op b, op c ]

        a :: b :: [] ->
            mapChunks op chunks [ op a, op b ]

        a :: [] ->
            mapChunks op chunks [ op a ]

        [] ->
            mapChunks op chunks []

        _ :: _ :: _ :: _ :: _ :: _ :: xs ->
            chunkAndMap op xs (list :: chunks)


mapChunks : (a -> b) -> List (List a) -> List b -> List b
mapChunks op chunks acc =
    case chunks of
        (a :: b :: c :: d :: e :: f :: _) :: xs ->
            mapChunks op xs (op a :: op b :: op c :: op d :: op e :: op f :: acc)

        _ ->
            acc


foldr : (a -> b -> b) -> b -> List a -> b
foldr op acc list =
    chunkAndFoldr op acc list []


chunkAndFoldr : (a -> b -> b) -> b -> List a -> List (List a) -> b
chunkAndFoldr op acc list chunks =
    case list of
        a :: b :: c :: d :: e :: f :: [] ->
            foldChunks op chunks (op a (op b (op c (op d (op e (op f acc))))))

        a :: b :: c :: d :: e :: [] ->
            foldChunks op chunks (op a (op b (op c (op d (op e acc)))))

        a :: b :: c :: d :: [] ->
            foldChunks op chunks (op a (op b (op c (op d acc))))

        a :: b :: c :: [] ->
            foldChunks op chunks (op a (op b (op c acc)))

        a :: b :: [] ->
            foldChunks op chunks (op a (op b acc))

        a :: [] ->
            foldChunks op chunks (op a acc)

        [] ->
            foldChunks op chunks acc

        _ :: _ :: _ :: _ :: _ :: _ :: xs ->
            chunkAndFoldr op acc xs (list :: chunks)


foldChunks : (a -> b -> b) -> List (List a) -> b -> b
foldChunks op chunks acc =
    case chunks of
        (a :: b :: c :: d :: e :: f :: _) :: xs ->
            foldChunks op xs (op a (op b (op c (op d (op e (op f acc))))))

        _ ->
            acc
