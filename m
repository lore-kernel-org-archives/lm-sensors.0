From: per@computer.org (Per Jessen)
Date: Thu, 16 Jun 2005 09:10:01 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <d8r8ig$80k$1@saturn.local.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
In-Reply-To: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Burkart Lingner wrote:

> The new version can be found at http://www.bollchen.de/decode-dimms.pl. Of course
> the "ADDED" comments should be removed then, I just left them in for now and
> I can strip them later on demand. The new version does work with Kernel 2.6
> and it should as well work with older Kernels and their proc-fs. Since I
> only have a system running 2.6, could anyone with an older Kernel please do
> a test run? That would be greatly appreciated, to make sure I didn't mess
> anything up.

Hi Burkart,

I ran a comparison of the output on a 2.4.30 system - the diff is:

diff -aur listing1 listing2
--- listing1    2005-06-16 10:55:49.000000000 +0200
+++ listing2    2005-06-16 10:55:53.000000000 +0200
@@ -1,7 +1,7 @@


 PC DIMM Serial Presence Detect Tester/Decoder
-By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner and others
+By Philip Edelbrock, Christian Zuckschwerdt and others
 Version 2.6.6

 Decoding EEPROM         /proc/sys/dev/sensors/eeprom-i2c-0-50
@@ -86,4 +86,4 @@

 Number of SDRAM DIMMs detected and decoded     1

-Try './decode-dimms.pl --format' for html output.
+Try '/usr/bin/decode-dimms.pl --format' for html output.


Looks absolutely fine to me.


-- 
/Per Jessen, Z?rich
http://www.spamchek.ch/freetrial - ?berzeugen Sie sich - 30 Tage kostenlos und unverbindlich!

