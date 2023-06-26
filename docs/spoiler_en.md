# Spoilers(v1.0.1)

========================================
This text translated by DeepL, so Maybe there is a mistake.
If you find misses, Please tell me.
========================================

This is a spoilers section on d-wonders' spelling specifications that should be noted.
Please note that not everything is written in detail.
If you do not like spoilers, please do not look at it.

## Stack Bolts

For each shot fired, the player accumulates 1 counter (hereafter referred to as "stack value") that is saved by firing the stack bolt.
The stack value is reset after 100F.
The stack value is stored by the player, so the stack value is not stored by the enemy.

There are three levels of stacked volts. Stacked volts become stronger when they accumulate a certain amount of stack value.

1. 240 or lower
   - The color of the stack bolt is green and it is fired.
   - Damage Calculation Formula
     - 0.04 + (0.04 \* math.max(math.floor(stack_count / 60), 1))
2. 480 or less
   - Fired with yellow color
   - Damage formula
     - 0.04 + (0.04 \* math.max(math.floor(stack_count / 60), 1))
3. above 480
   - Fired red in color
   - The range is greatly extended
   - Damage formula
     - 0.08 + (0.04 \* math.floor(math.log(math.floor(stack_count - 550), 2) + 3.4))

As for the other performance, it is similar to the spark bolt.

### Simultaneous Chanting

Radiations chanted simultaneously with stacked bolts also increase the stack.
For example, firing the following sequence will increase the stack value by 3.

[3x chanting][stack bolt][spark bolt][spark bolt]

### Charge bolt

Charge four times and fire a fifth time.
Internally, there is a division between the radiation for charging up to 4 times and the radiation after the charge.
The charging radiant has a process that forcibly deletes the radiant itself after 1F.

The radiant after charging has root damage and area damage.
The root is 75dmg and the surrounding area is a 32x32 circle with 15dmg/1F.

## Ancient hammer

Chant delay and spread are randomly determined.
There is no extinction by collision, so there is 10dmg/1F of proximity damage.

## Scythe of the Grim Reaper

It is basically an ancient hammer with a longer ejection distance.
The differences are,

- Attribute has been changed to slice damage.
- The boomerang effect against the player is reduced.

The boomerang effect against the Player is thinned out. Be careful not to get too close, as it will homing.

## Balloons

Since the gravity is set very lightly, the balloons fly very fast when homing.
It also has the same Wet effect as the material type, so if you chant it at the same time as an attribute critical, you will get a definite critical.

### Red Blood Balloon

This balloon is special, and there is a 50% chance that a monster will emerge from inside the balloon.
The type of monster is further randomized.

- At 70% friendly monsters and weak enemies will appear.
- 10% of the time, a friendly monster and a healish enemy will appear.
- At 10% a friendly monster and a heishi type enemy and a strong heishi type enemy will appear
- Exploding deer appear at 5%.
- 5% of the time, a healing healer will appear.

If 1/1000000 is drawn in the lottery before the above drawing takes place, a dragon will appear from a balloon. Scary.

## Flask of deadly poison

The flask itself is made of acid, so it can dissolve a few substances that can be dissolved by acid.

## Hemokinesis

Each use reduces HP by 1, and when HP reaches 0, the victim bleeds to death. Unknown

## Shark Launcher

The shark has fresh gore (BLOOD_EXPLOSION) on it and will release a large amount of liquid when attacked.
The shark itself will release a small amount of water.

## Contracts

Up to 100 gold will be paid at the time of contract depending on the opponent's HP.
If you do not have gold, you will be paid 1/2 of the gold amount in HP.
If the player cannot pay in HP, the player dies.
If Player's unit is not found at the time of payment, you can contract for free.

## Liquid Shot

You can convert from one unmarked liquid shot to another.

### Liquid Shot [shake].

You can convert from another Liquid Shot to Liquid Shot [shake], and you can convert to Liquid Shot as well as unmarked.

### Liquid shot [tumble].

At the time of ejection and every 20F from ejection, it searches for an enemy in a radius of 85, and if found, it moves instantly to that enemy.

### Correspondence Table

- Acid
  - Acid
- Versakiam
  - Angry
- Blood (except worm)
  - Blood
- Pheromones, nourishing porridge
  - Charm
- Ominous liquid, liquid of emptiness
  - Dark
- Worm pheromones, worm blood
  - Insect
- lava
  - Hell
- Magic liquid, mana liquid, midas, invisibilium
  - Mana
- Oil
  - Oil
- Poison, Curse of Greed liquid (the liquid that comes out when you take the Greed perk from a large tree)
  - Toxic
- Slime type, peat
  - Soft
- Movement speed type
  - Speed
- Unstable teleport, teleport
  - Teleport
- Poisonous sludge system
  - Poison
- Water-based
  - Water
- Unstable polymorphic, polymorphic, chaotic polymorphic
  - Chaos
- Flumoxium, rainbow, alcohol-based
  - Unstable

All of the above liquid shots can be converted to "Unstable". It is also possible to convert from "Unstable" to all liquid shots.

## Bolt of Dependency

When chanted at the same time as a type of adjustment board that adds an attribute to all spells (such as damage plus), a radiant based on the type of additional damage chanted at the same time will be fired.
If there is no damage type, it will search the spell name for a name that matches the attribute, and if found, will chant a radiant of that attribute.

### Correspondence Table

- Physical Damage
  - Above 0
    - Tentacles
- Radiant Damage
  - Above 0 but less than 10
    - Concentrated Light
  - Above 10
    - Chain bolt x2
  - Adjustment board that does not match the above and has "projectile" in the name
    - Chain Bolt x2
- Blitz Damage
  - Above 0 but less than 5
    - Lightning bolt
  - More than 5
    - Lightning bolt x2
  - There is a tuning board that does not match the above but includes the word "electric" in the name.
    - Lightning bolt
- Flame Damage
  - Above 0 but less than 5
    - Firebolt x2
  - Above 5
    - Meteorite
  - There are some tuning boards that do not match the above but have the word "fire" in the name.
    - Meteorite
- Blasting Damage
  - Above 0 but less than 5
    - TNT
  - More than 5 but less than 10
    - Bomb
  - More than 10 but less than 5 above 10
    - Sacred bomb
  - More than 15
    - Giga Sacred Bomb
  - There are some tuning boards that do not match the above but have "explosion" or "explode" in the name.
    - Sacred bomb
- Freezing damage
  - Above 0 and below 5
    - Sphere of ice
  - Above 5 and below 10
    - Freezing stare (12 lines, spread -10 degrees from original)
  - Above 10 and below 15
    - Freezing field
  - Above 15
    - Freezing area field
  - There are some adjustment boards that do not match the above but have "freeze", "frozen", or "ice" in the name.
    - Ice ball
- Slice damage
  - Above 0 but less than 5
    - Disk Radiant
  - Above 5 but less than 10
    - Giga disk
  - More than 10 but less than 5 above 10
    - Omega disc
  - There are regulating disks that do not match the above but have "slice" or "disc" in the name.
    - Disk Radiation
- Recovery Damage
  -5 above but below 0
  - Healing Bolt
    -5 or less
  - Field of Recovery
- Curse Damage
  - Above 0 and below 5
    - Cursed Orb x2
  - Above 5
    - Liquid Shot[Dark] x2
  - Adjusted boards that do not match the above and have "poison", "curse", or "toxic" in the name
    - Liquid Shot[Dark] x2
- Drill Damage
  - Above 0 but less than 5
    - Glowing spear
  - Above 5
    - Plasma Cutter

## Soul shot

A process is set on the radiating object that grants a process for storing souls to the opponent (process that puts them in a soul state).
The process to put the enemy into soul state is given to enemies that touch a circle twice the size of the radiant object.
When an enemy in the soul state is defeated, the maximum HP of the defeated enemy is saved to the player as a soul value.

When firing a soul shot again, the soul shot fired will refer to the soul value stored in the Player. Depending on the value of the soul value, the curse damage of the soul shot fired will be corrected by a multiplier. When a soul shot is fired, the soul value stored in the Player is reduced by -1.

The relationship between the soul stored in the Player and the multiplier is as follows

- Up to 20
  - Equal magnification (5 dmg)
- Up to 100
  - 1.5 times (7.5 dmg)
- Up to 500
  - 2 times (10 dmg)
- Up to 2000
  - 3 times (15 dmg)
- Up to 10000
  - 4 times (20dmg)
- Over 10000
  - 5 times (25 dmg)

If the soul shot is 0 or more, a white ghost will appear when the soul shot is fired.
If the soul shot is multiplied by 3 or more, a red ghost will appear when the soul shot is fired.

## Shooting star

Yellow for radiant damage
Red for flame damage
Blue for ice damage
Green for electricity damage

are set as area damage.

## Battery Light

If there is a spell with the name "spark_electric" in the same inventory as the battery light (or in the wand if it is a wand), it is considered to be rechargeable and the number of times it can be recharged is unlimited.
(Basically, if it is an electric spell, it will be unlimited.)

## Freezing damage reversal

Converts ice damage added before itself to negative recovery damage.
Whenever possible, removes freezing effects, etc. on freezing.

## Spell Vacuum

Works the same as adding a trigger, etc.
The "Damage," "Radiant Speed," "Radiant Life," "Blast Range," and "Area Damage" of the spell one behind the Spell Vacuum
and then adds the acquired values to the spells in the simultaneous chanting as an adjusted version.
