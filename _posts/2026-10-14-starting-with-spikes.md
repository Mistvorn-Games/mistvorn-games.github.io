---
title: Starting with spikes
project: dungeon-crawler
---

My latest game concept requires me to implement a number of game mechanics that I am inexperienced with. So, before working on the real game, I made a list of mechanics that I can spike to help me build understanding of how they work and prove they are viable on a phone. Each spike is one small throwaway prototype. This post covers the first three.

Dungeon Delve (a working title) is a top-down deck-building dungeon crawler for phones, built in Godot 4 with C#. It's played in portrait with taps: tap the ground to move, tap a mob to attack. You're a treasure hunter who takes quests at a tavern, delves, and comes back to upgrade a small loadout of cards.

## My rules for a spike

- **One question each**, or a couple of closely related ones. It's written at the top of the task before I start, and the spike is done when I can answer it.
- **Greybox only.** Capsules and cubes let me concentrate on the mechanic in question and turn the prototype around as fast as possible.
- **Throwaway.** Each spike has its own folder and scene and never becomes the game. What I keep is a written note: the answer, the values that felt right, and what went wrong.
- **Played on real phones.** An old Pixel 3 and a Pixel 6 Pro. The Mac tells me nothing about how a tap feels.
- **Tuneable on the phone.** Every spike has a panel of toggles and sliders, so I can quickly adjust the spike without a rebuild.
- **Incremental prototypes.** A spike can build on an earlier one, but it never changes it, so every spike stays playable as I go.

## Spike 1: tap to move

**Question:** Does tap-to-move feel responsive and readable on a phone, and what camera suits it?

**Answer:** Yes, after one fix (below). The camera is tilted 75° below the horizon, 25 m from the hero, and takes about 1.5 seconds to catch up with it. The hero itself responds to a tap at once.

<div class="shots">
  <video src="/assets/img/devlog/starting-with-spikes/tap-to-move.mp4" autoplay loop muted playsinline aria-label="The hero, an orange capsule, walking to wherever the screen is tapped in a grey room, then the tuning panel opened and the camera sliders dragged"></video>
  <img src="/assets/img/devlog/starting-with-spikes/tap-marker-under-finger.png" alt="A large green ring on the floor marking where the finger is held down">
  <img src="/assets/img/devlog/starting-with-spikes/tuning-panel.png" alt="A panel of sliders over the game for camera tilt, distance, lag, ring size, held-ring size and hero speed">
</div>

The thing I didn't expect: with the camera 25 m away, your finger covers both the spot you tapped and the ring that confirms it. The ring now grows to five times its size while your finger is down, so it shows around your fingertip, and shrinks when you lift.

Some Godot notes:

- `NavigationAgent3D` didn't work for me out of the box. The baked navigation mesh sat about half a metre above the floor and the agent measures its distance to a waypoint in 3D, so the hero never "arrived" at the first one and jittered in place. Instead I ask `NavigationServer3D.MapGetPath` for a path and follow it myself, measuring on the floor plane. If I want the agent back later, its `path_height_offset` needs setting to match the mesh.
- Camera follow is much easier to tune as "lag in seconds" than as a stiffness value. With stiffness, both ends of the slider felt rigid and the useful range was hidden near the bottom.
- I turned physics interpolation on. The hero moves on the 60 Hz physics tick and the camera moves every frame, so on a 120 Hz screen the hero would step at half the camera's rate.

## Spike 2: a procedural dungeon

**Question:** How do you build a procedural dungeon? Can navigation work across rooms assembled at runtime, and how long does generation take on a phone?

**Answer:** From six room pieces on an 8 m grid, with 4 m doors in the middle of a cell edge so the doors of any two neighbours line up. The generator starts from a dead end and grows by picking a random open door and putting a random piece that fits behind it. Then it closes every leftover door with a piece that fits, so every doorway leads somewhere. The end room is the one furthest from the start, counted in doorways.

Navigation works: I bake one navigation mesh over the whole dungeon after the rooms are placed. My fallbacks were pre-baked rooms and links at the doors, and I didn't need either.

It's fast: on the Pixel 3 a 100-room dungeon is generated, built and baked in about 140 ms, and it's walkable about a third of a second after generation starts. The gap is the navigation map catching up, which took 10 physics frames. The screenshots are from the Mac, so the timings shown in them are lower than the Pixel 3's.

<div class="shots">
  <img src="/assets/img/devlog/starting-with-spikes/room-pieces.png" alt="The six grey room pieces seen from above: dead end, corridor, corner, junction, crossing and a large room">
  <img src="/assets/img/devlog/starting-with-spikes/dungeon-100-rooms.png" alt="A 100-room dungeon seen from above with a yellow line marking the path from the start to the end">
  <img src="/assets/img/devlog/starting-with-spikes/walking-the-dungeon.png" alt="The hero following the yellow path line along a corridor of the generated dungeon">
</div>

Some Godot notes:

- The navigation map isn't ready straight after a bake. A path query returned nothing for the first 3–10 physics frames.
- After generating a new dungeon (a scene reload) the map still held the *previous* dungeon for a moment, and I got a path that ran through the new dungeon's walls. So a non-empty path doesn't prove the map is ready. I wait for the map's iteration id to change and for a path from the start room to reach the end room.

## Spike 3: tap to attack

**Question:** Can you control a fight with taps alone?

**Answer:** Yes. Tap-to-attack worked with a sword and a wand, and both phones held 60 fps. My first guesses at damage, attack speed and range were good enough that I left them alone.

<div class="shots">
  <video src="/assets/img/devlog/starting-with-spikes/tap-to-attack.mp4" autoplay loop muted playsinline aria-label="The hero fighting purple mobs in the grey room, first with a sword and then with a wand"></video>
  <img src="/assets/img/devlog/starting-with-spikes/sword-fight.png" alt="The hero hitting a mob with a sword, both flashing white from the hit, with a red ring under the target and damage numbers above both">
  <img src="/assets/img/devlog/starting-with-spikes/wand-shot.png" alt="A wand shot in flight towards a targeted mob, which shows a yellow exclamation mark">
</div>

Tap a mob once and the hero keeps attacking it until it's dead or you tap something else. A red ring marks your target, and a mob that notices the hero shows a yellow "!".

The hero needed a few rules of its own:

- A walking hero stops to fight a mob that comes within weapon range, then carries on.
- Tapping the ground while you have a target is a retreat, and the hero picks no fights on the way. Otherwise you couldn't walk away from a mob standing next to you.
- A hero standing idle hits back at whatever hits it.

The hero never reads input. A tap becomes a command (move here, attack that), and the hero carries out the last one it was given. That's been true since Spike 1, and it's what lets an autopilot issue the same commands later.

## What's next

The next three spikes: an autopilot that takes the hero through a dungeon by issuing those same commands; skill cards; and fog of war.
