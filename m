From: aurelien@ap2c.com (=?iso-8859-15?q?Aur=E9lien?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Some informations about issues with the VIA Chipsets
Message-Id: <200301211738.34926.aurelien@ap2c.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Good morning, 
I have since few day a new motherboard made by VIA (MS9107C+ series) : VIA 
P4X266A. It's composed with VT8753A Northbridge and VT8233A Southbridge and 
VT 8233. In a website about my mainboard, i learn that the sensors are linked 
to a built-in ITE 8705F chipset.
When i launche sensors-detect, your program found that :

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0500' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x52
    Chip `Serial EEPROM' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

But after that, when i launche the program sensors, it says me that it doesn't 
found any sensors. I don't understand anything.
It is because these sensors are not implemented or it is a bug in your program 
?
I'm waiting your answer as soon as possible
Regards, 

- -- 
Aur?lien <aurelien@ap2c.com>
Projet AP?C - http://www.ap2c.com
?tudiant ? la Facult? des sciences de Paris
Universit? Pierre et Marie Curie - Paris VI 
Jussieu -- http://www.upmc.fr
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+LXeJ0CRROIJEtFwRAp1OAJj5MHdQ70iU+Bp26OSUI7iDq/rnAJ4o443u
i+gxlmxERhQGP9xbcXkF6Q=
=+PgL
-----END PGP SIGNATURE-----
