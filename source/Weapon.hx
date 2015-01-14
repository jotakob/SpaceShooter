package ;

/**
 * ...
 * @author Luuk
 */
class Weapon
{
	private var  owner:Player;
	private var  firingRate:Float;
	private var  firingFrames:Int;
	private var  projectileSpeed:Int;
	private var  weaponImage: String;
	private var	 bulletImage: String;
	private var  damage:Int;
	private var  framesUntilShooting:Int = 0;
	
	
	public function new(player:Player, FiringRate:Float, ProjectileSpeed:Int, WeaponImage:String, BulletImage:String, Damage:Int) 
	{
		owner = player;
		firingRate = FiringRate;
		firingFrames = Math.round(1 / FiringRate);
		if (firingFrames < 1)
			firingFrames = 1;
		projectileSpeed = ProjectileSpeed;
		weaponImage = WeaponImage;
		bulletImage = BulletImage;
		damage = Damage;
	}
	
	public function tryShooting()
	{
		if (framesUntilShooting <= 0)
		{
			shoot();
			framesUntilShooting = firingFrames;
		}
	}
	
	private function shoot()
	{
		var tempBullet:Bullet = new Bullet(0, 0, owner.inputmanager.rightAngle, projectileSpeed, damage, bulletImage);
		tempBullet.x = owner.x + 16;
		tempBullet.y = owner.y + 16;
		Reg.currentState.add(tempBullet);
		Reg.bulletGroup.add(tempBullet);	
	}

	public function update()
	{
		framesUntilShooting--;
	}
}