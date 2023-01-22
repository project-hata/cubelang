
module Projects where

-- open import Hata.Conventions
open import Hata.Project.Prelude

open import Hata.Extern.TreeSitter.Syntax.Definition


data Non : 𝒰₀ where
  statement definition assignment
    type typeop2 typeop1 typeop0
    term termop2 termop1 termop0
    identifier
    : Non

instance
  IShow:Non : IShow Non
  IShow:Non = record { show = f }
    where
      f : Non -> Text
      f statement  = "statement"
      f definition = "definition"
      f assignment = "assignment"
      f type       = "type"
      f typeop2    = "typeop2"
      f typeop1    = "typeop1"
      f typeop0    = "typeop0"
      f term       = "term"
      f termop2    = "termop2"
      f termop1    = "termop1"
      f termop0    = "termop0"
      f identifier = "identifier"

tcrules : List (Rule Non)
tcrules =
  statement ↦ choice (next definition ∷ next assignment ∷ [])
  ∷ definition ↦ seq (next identifier ∷ lit " : " ∷ next type ∷ [])
  ∷ assignment ↦ seq (next identifier ∷ lit " = " ∷ next term ∷ [])
  ∷ identifier ↦ lit "^[a-zA-Z0-9_]*$"
  ∷ type ↦ next typeop0
  ∷ typeop0 ↦ next identifier
  ∷ term ↦ next termop0
  ∷ termop0 ↦ next identifier
  ∷ []

tcgrammar : Grammar
tcgrammar = record { Nonterminal = Non ; toplevel = statement ; rules = tcrules }


open import Hata.Project.Definition2

projects : Projects
projects =
  newTreesitterCargo "tinycube" := tcgrammar

open import Hata.Base.HIO.Translate.TC
open import Hata.Program.HataCmd.Common
open import Hata.Abstract.Path.Definition

root : (Abs , Dir)-Path
root = :: / "home" / "mxu" / "data" / "makuri.world" / "distributed" / "project" / "hata" / "CubeLang" / "Generated"




_ : ⊤ {ℓ₀}
_ = # (runTC (generateProjects root projects))


