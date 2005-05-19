From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] Add support for it8712 in sensord
Message-Id: <20050306220003.GA3694@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

The attached patch adds support for it8712 in sensord. Please apply.

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/sensord/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/chips.c,v
retrieving revision 1.15
diff -u -d -p -r1.15 chips.c
--- prog/sensord/chips.c	29 Jan 2005 22:33:18 -0000	1.15
+++ prog/sensord/chips.c	5 Mar 2005 14:26:00 -0000
@@ -546,7 +546,7 @@ static const ChipDescriptor lm80_chip = 
 /** IT87 (thanks to Mike Black) **/
 
 static const char *it87_names[] = {
-  SENSORS_IT87_PREFIX, NULL
+  SENSORS_IT87_PREFIX, SENSORS_IT8712_PREFIX, NULL
 };
 
 static const FeatureDescriptor it87_features[] = {
