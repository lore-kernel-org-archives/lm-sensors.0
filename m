From: swl@ucs.co.za (stu)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <20040708184144.4554439e@pegasus.ucs.co.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everyone

I hope this is the correct forum to report bugs, and that this bug
hasn't been reported already. If it isn't the correct forum, please let
me know where I should report it.

Just downloaded and installed lm_sensors-2.8.7 from source. I've found a
small bug. When I run mkdev.sh, it creates devices named like so :

/dev/i2c-0
/dev/i2c-1
/dev/i2c-2

etc

However, sensors-detect looks for a device named /dev/i2c/0  and can't
find it. This causes sensors-detect to skip the probing of my SMBus Via
Pro adapter, and gives the error :

Can't open /dev/i2c/0

To get around this I hacked sensors-detect and changed the line :

   $dev_i2c = '/dev/i2c/';

to read

   $dev_i2c = '/dev/i2c-';

in subroutine 'initialize_conf' . This solved my problem.

I'll gladly provide more information if necessary. My apologies if this
bug has already been reported.


Regards and best wishes
- -- 
Stuart Logie
Programmer

UNIVERSAL COMPUTER SERVICES (PTY) LTD
   
Powered by Debian GNU/Linux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQCVAwUBQO15SOuEbVzzghHCAQIy7gQApF6xKKcooqhb5VTPDe44xqpI7+D7F+Ej
sJnwYq3eSiSMYMMBAkIKSuqXKUmpYFG0yDNz3V76FTXK04rNLO8rAbUGnKr+TyH+
UBm/nmKuNXNjcvGdikZ5PT7FBx4LMbE6hSG7tpr86/7KSlR25hHaBgSKO7Tt2p6j
OdBMfA0JNCk=wJjp
-----END PGP SIGNATURE-----
