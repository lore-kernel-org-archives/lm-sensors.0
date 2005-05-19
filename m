From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: RFC PATCH Trivial: Query :- is sysfs vrm supposed to be read/write?
Message-Id: <ekmf31hdtifbqdb04lhustt5aab3o0ufuj@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I've looped this loop a couple times and something doesn't fit,
go on with something else then want to finalise this little thing.

Reported read-only VID depends on VRM, also marked read-only.

Doesn't seem right to me, where does VRM type value come from?
If it is a driver constant, okay.
If it is outside the driver, where do I get it from?
If it is a documentation mistake, someone please let me know, 
this just an extra irritant I forget to resolve every couple days :)

Cheers,
Grant.




--- linux-2.6.11-mm3-p2x/Documentation/i2c/sysfs-interface.orig	2004-12-25 08:34:01.000000000 +1100
+++ linux-2.6.11-mm3-p2x/Documentation/i2c/sysfs-interface	2005-03-16 18:02:27.000000000 +1100
@@ -110,7 +110,7 @@
 		Not always correct.
 
 vrm		Voltage Regulator Module version number. 
-		Read only.
+		Read/Write
 		Two digit number, first is major version, second is
 		minor version.
 		Affects the way the driver calculates the CPU core reference
