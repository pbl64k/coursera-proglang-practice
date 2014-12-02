(* Provided code for section 8 practice problem (Standard ML) *)

datatype character =
    knight of int * int (* a knight has hitpoints and armor points *)
  | wizard of int * int (* a wizard has hitpoints and mana points *)
    (* whenever a character's hitpoints reach zero -- or become negative --
       he expires and shuffles off this mortal coil *)

datatype encounter =
    floor_trap of int (* a floor trap hurts anyone walking over it, reducing their hitpoints *)
  | monster of int * int (* a monster has attack strength and hitpoints *)
  | potion of int * int (* potions may restore some hitpoints and some mana points (if applicable) *)
  | armor of int (* armor pieces may boost a characters armor points (if applicable) *)

fun is_dead character =
    case character of
        knight (hp, _) => hp <= 0
        (* this is something of a dirty hack, as it simplifies the encounter mechanics below
           at the cost of wizard state being slightly crazy after a lethal encounter with a
           monster *)
      | wizard (hp, mp) => hp <= 0 orelse mp <= 0

fun damage_knight dam (hp, ap) =
    case ap of
        0 => (hp - dam, 0)
      | _ => if dam > ap then damage_knight (dam - ap) (hp, 0) else (hp, ap - dam)

fun play_out_encounter character encounter =
    case (character, encounter) of
        (* knights just walk over traps, grimly accepting their fate *)
        (knight state, floor_trap dam) => knight (damage_knight dam state)
        (* knights take damage from monsters, as their armor hinders their mobility,
           but they are strong enough to take out any monster with a single blow afterwards *)
      | (knight state, monster (dam, _)) => knight (damage_knight dam state)
        (* knights can be healed by potions, but they have no use for mana *)
      | (knight (hp, ap), potion (hp', _)) => knight (hp + hp', ap)
        (* knights just love shiny armor, as it improves their survivability
           and makes them look cool! *)
      | (knight (hp, ap), armor ap') => knight (hp, ap + ap')
        (* wizards can levitate, so floor traps can't harm them... as long as they can spend a
           single mana point on the spell *)
      | (wizard (hp, mp), floor_trap dam) => if mp > 0 then wizard (hp, mp - 1) else wizard (hp - dam, mp)
        (* wizards can hurl powerful fireballs from great distances... unfortunately, they
           need mana points equal to the damage dealt to do that, and if a monster gets close,
           they're toast, as their martial skills are nonexistent *)
      | (wizard (hp, mp), monster (_, hp')) => wizard (hp, mp - hp')
        (* wizards love potions, as they help them all around! *)
      | (wizard (hp, mp), potion (hp', mp')) => wizard (hp + hp', mp + mp')
        (* wizards couldn't care less for armor, as it does them absolutely no good *)
      | (wizard state, armor _) => wizard state

fun resolve_encounter character encounter =
    if is_dead character
        then character (* dead characters have already done all their adventuring... *)
        else play_out_encounter character encounter

val sir_foldalot = knight (15, 3)
val knight_of_lambda_calculus = knight (10, 10)
val sir_pinin_for_the_fjords = knight (0, 15)
val alonzo_the_wise = wizard (3, 50)

val dungeon_of_mupl = [
    monster (1, 1),
    floor_trap 3,
    monster (5, 3),
    potion (5, 5),
    monster (1, 15),
    armor 10,
    floor_trap 5,
    monster (10, 10)
    ]

