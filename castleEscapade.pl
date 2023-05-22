/* Text Based Adventure game */
:- dynamic at/2, i_am_at/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).
/* This shows the current location */

i_am_at(entrance).


/* These paths show which rooms are connected in the castle and gives dialogue for when the user finishes the game */

path(atrium, w, greatHall).
path(atrium, n, entrance).
path(atrium, s, stairCase).
path(entrance, s, atrium).
path(stairCase, s, masterBedroom).
path(atrium, e, dungeon) :- at(oldMan, in_hand), at(statue, in_hand), at(painting, in_hand), write('The old man guides you through the dungeon to a set of doors'), nl,
                            write('each with its own corresponding statue, the old man is unsure which door'), nl,
                            write('to go through, you remember the statue you had looked at in the Atrium,'), nl,
                            write('you walk through the door with the Atrium statue next to it,'), nl,
                            write('the old man sees you are carrying a painting and advises'), nl,
                            write('you to turn the painting around revealing a map to a secret'), nl,
                            write('exit, with this you follow the route to the exit and greeted'), nl,
                            write('by a group of strolling adventurers.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.
path(atrium, e, dungeon) :- at(oldMan, in_hand), at(statue, in_hand), write('The old man guides you through the dungeon to a set of doors'), nl,
                            write('each with its own corresponding statue, the old man is unsure which door'), nl,
                            write('to go through, you remember the statue you had looked at in the Atrium,'), nl,
                            write('you walk through the door with the Atrium statue next to it,'), nl,
                            write('the old man guides you through to the exit after a couple minutes,'), nl,
                            write('you finally escape the castle although you and the old man are'), nl,
                            write('are left deserted in the forest unsure of your surroundings.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.
path(atrium, e, dungeon) :- at(oldMan, in_hand), at(painting, in_hand), write('The old man guides you through the dungeon to a set of doors'), nl,
                            write('each with its own corresponding statue, the old man is unsure which door'), nl,
                            write('to go through, he sees you are carrying a painting, he advises you'), nl,
                            write('to turn the painting around, the painting reveals a map of the dungeon,'), nl,
                            write('following the paintings path you end up at an exit, upon exiting, you'), nl,
                            write('find yourself deserted in a forest unsure of your surroundings.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.
path(atrium, e, dungeon) :- at(statue, in_hand), at(painting, in_hand), write('You decide to enter the dungeon, you find yourself'), nl,
                            write('lost after searching hours for an exit, however,'), nl,
                            write('you stumble across a set of doors, you remember'), nl,
                            write('seeing a familiar statue in the Atrium next to a'), nl,
                            write('door, you head through that door and find yourself'), nl,
                            write('in another part of the dungeon, you remember the painting on your'), nl,
                            write('back and begin investigating it. You flip the painting around to'), nl,
                            write('reveal a map of this part of the dungeon and head towards the exit'), nl,
                            write('you find yourself outside a forest path and greeted by a merchant.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.
path(atrium, e, dungeon) :- at(statue, in_hand), write('You decide to head to the dungeon, you find yourself'), nl,
                            write('lost after searching hours for an exit, however,'), nl,
                            write('you stumble across a set of doors, you remember'), nl,
                            write('seeing a familiar statue in the Atrium next to a'), nl,
                            write('door, you head through that door and find yourself'), nl,
                            write('in another part of the dungeon, tirelessly you search'), nl,
                            write('for an exit using the walls as your guide. After what'), nl,
                            write('felt like hours, you approach light and exit the dungeon'), nl,
                            write('you find yourself lost in a forest but outside.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.
path(atrium, e, dungeon) :- at(painting, in_hand), write('You decide to enter the dungeon, you find yourself'), nl,
                            write('lost after searching hours for an exit, however,'), nl,
                            write('you stumble across a set of doors, clueless you look'), nl,
                            write('for clues on where to head, you remember the painting'), nl,
                            write('and decide to flip it over, it reveals a map, using the'), nl,
                            write('map you walk forward into an unfamiliar part of the dungeon'), nl,
                            write('you choose a random exit to head towards and find yourself'), nl,
                            write('deserted in a forest outside.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.
path(atrium, e, dungeon) :- at(oldMan, in_hand), write('The old man guides you through the dungeon to a set of doors'), nl,
                            write('each with its own corresponding statue, the old man is unsure which door'), nl,
                            write('after hours of thinking, the old man picks a door, the door'), nl,
                            write('leads to a different division of the dungeon, the old man is'), nl,
                            write('familar with this place and guides you towards the exit, upon'), nl,
                            write('exiting, you find yourself lost in the forest.'), nl,
                            write(''), nl,
                            write('The end.'), nl, !, finish.

path(greatHall, e, atrium).
path(stairCase, n, atrium).
path(masterBedroom, n, stairCase).
path(atrium, e, dungeon) :- write('You head towards the dungeon without any equipment or guide.'), nl,
                            write('You get lost and head back.'), nl, !, fail.


/* These facts show the different locations of the items in the game */

at(statue, atrium).
at(oldMan, greatHall).
at(painting, masterBedroom).


/* These rules are used for interactating with something */

interact(X) :-
        at(X, in_hand),
        write('You have already interacted with the '(X)),
        nl, !.

interact(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(at(X, in_hand)),
        write('You have interacted with the '(X)),
        nl, !.

interact(_) :-
        write('This cannot be interacted with.'),
        nl.




/* These rules define the 4 cardinal directions to go to a location */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).




/* This rule is used to move in the inputted direction */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        lookAround, !.

go(_) :-
        write('You can''t go that way.').


/* This rule outputs the location and describes it */

lookAround :-
        i_am_at(Place),
        describe(Place),
        nl,
        show_objects(Place),
        nl.


/* This rule tells the current locations and describes it */

whereAmI :-
        i_am_at(Place),
        describe(Place),
        nl,
        show_objects(Place),
        nl.

/* This rule shows all the interactions in the castle */

show_objects(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

show_objects(_).


/* This rule shows the user how to end the game after finishing */

die :-
        !, finish.

finish :-
        nl,
        write('The game is over. Please enter the  halt.  command.'),
        nl, !.



/* This rule prints out the instructions for the game */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('intro.                   -- to give an introduction of the game'), nl,
        write('n.  s.  e.  w.           -- to go in the cardinal direction'), nl,
        write('interact(Object).        -- to interact with an object'), nl,    
        write('whereAmI.                -- to print out the current location'), nl, 
        write('lookAround.              -- to print out the location and connected rooms'), nl,
        write('instructions.            -- to see this message again'), nl,
        write('show_objects(Place).     -- to see all the interactions in the castle'), nl,
        write('halt.                    -- to end the game and quit'), nl,
        nl.



/* This rule prints out the introduction for the game and also gives the current location and goal */

intro :-
        nl,
        write('Castle Escapade Game'), nl,
        write(''), nl,
        lookAround.


/* These rules give a brief description of each room in the castle and what interactions are within them */


describe(entrance) :-
        write('You are at the entrance of the castle. Head towards the south'), nl,
        write('to enter the Atrium. Your goal is to escape'), nl,
        write('the castle through the dungeon located to'), nl,
        write('the east of the Atrium, however, you will need'), nl,
        write('equipment or a guide to get through the dungeon.'), nl,
        write('Interact with any object or person to help you escape.'), nl,
        write(''), nl,
        write('Type "instructions." to get instructions on how to navigate'), nl,
        write('through the castle.'), nl.

describe(greatHall) :-
        write('You are in the Great Hall. You spot an old man standing beside'), nl,
        write('a pillar.'), nl,

        write('Go to the west to head back to the Atrium.'), nl.

describe(masterBedroom) :-
        write('This is the Master Bedroom. You see a painting on the wall.'), nl,

        write('Head south to go back down the staircase.'), nl.

describe(stairCase) :-
        write('You head towards the staircase.'), nl,

        write('Head south to enter the Master Bedroom,'), nl,
        write('Head north to return to the Atrium.'), nl.

describe(dungeon) :-
        write(''), nl.

describe(atrium) :-
        
        write('You have entered the Atrium.'), nl,
        write(''), nl,
        write('Head towards the east to enter the dungeon.'), nl,
        write('Head towards the south to go to the staircase leading to the Master Bedroom'), nl,
        write('Head towards the west to enter the Great Hall'), nl, !.


