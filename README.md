# ShooterNBS

## Documentation
UML: https://yuml.me/studionbs/edit/shooternbs

## Structure
```
res
|- Items
.  |- ItemTemplate.gd
.  |- Shootables
.  .  |- ShootableTemplate.gd
.  .  |- Crossbow
.     .  |- ShootableCrossbow.gd
.     .  |- ShootableCrossbow.tscn
|- Projectiles
.  |- ProjectileTemplate.gd
.  |- ProjectileCrossbow
.     | ProjectileCrossbow.gd
.     | ProjectileCrossbow.tscn   
|- Crosshairs
.  |- CrosshairTemplate.gd
.  |- CrosshairCrossbow
.     |- CrosshairCrossbow.gd
.     |- CrosshairCrossbow.tscn
|- Entities
.  |- EntityTemplate.gd
.  |- EntityCharacter
.     |- EntityCharacter.gd
.     |- EntityCharacter.tscn
|- Scenes
.  |- TestScene.tscn
```