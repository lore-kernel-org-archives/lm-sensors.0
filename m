From: mbroemme@plusserver.de (Maik Broemme)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Question about address 0x69
Message-Id: <20030220095151.GC32725@lfs.plusserver.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219225521.GA32613@lfs.plusserver.de>
In-Reply-To: <20030219225521.GA32613@lfs.plusserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

thanks for the tips but if i try it with i2c block read (i2cdump 1 0x69 i) i get an error "Adapter for i2c bus 1 does not have i2c block read capability" The device is registered as

    i2c-1       smbus           SMBus I801 adapter at e800              Non-I2C SMBus adapter           

- -- 
Best regards

Maik Broemme
UNIX/Linux Developer

WOLK Kernel Developer - http://wolk.sourceforge.net/
TuxBox Developer - http://tuxbox.berlios.de/ 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+VKU2j7mZcU7rMfERAsPmAJ9Udkaw89olNVilYjtNRo1N+EZYzwCePjy8
Vcg3/3Lug8VWsuCbLjs475c=ZJwy
-----END PGP SIGNATURE-----
