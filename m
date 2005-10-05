From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Wed, 05 Oct 2005 16:05:08 +0000
Subject: [lm-sensors] [PATCH] I2C Documentation fix
Message-Id: <200510051404.AA01325@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The name which can be set to i2c_driver is up to 31 characters.

Index: doc/writing-clients
=================================RCS file: /home/cvs/i2c/doc/writing-clients,v
retrieving revision 1.22
diff -u -p -r1.22 writing-clients
--- doc/writing-clients	29 Jul 2005 17:33:49 -0000	1.22
+++ doc/writing-clients	5 Oct 2005 13:56:24 -0000
@@ -35,7 +35,7 @@ static struct i2c_driver foo_driver = {
 	.dec_use	= foo_dec_use, /* May be NULL */
 }
  
-The name can be chosen freely, and may be upto 40 characters long. Please
+The name can be chosen freely, and may be up to 31 characters long. Please
 use something descriptive here.
 
 If used, the id should be a unique ID. The range 0xf000 to 0xffff is

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
