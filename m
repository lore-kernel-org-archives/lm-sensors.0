From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <20040702221534.GC6776@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-07-02 23:55:08 +0200]:
> OK, I reworked both the LM75 and the LM77 detection routines to take
> benefit of that singularity. It should make detection of these chips
> quite reliable now.
> 
> Andras, Mark, can you please test again? Confidence 6 is expected. Mark,
> please fake the LM77 address range again, so that the test is even more
> interesting.

Confidence 6 as expected on the lm75s, and lm77 was (correctly) not
detected.  I used this:

Index: sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.332
diff -u -r1.332 sensors-detect
--- sensors-detect      2 Jul 2004 22:01:17 -0000       1.332
+++ sensors-detect      2 Jul 2004 22:22:11 -0000
@@ -904,7 +904,7 @@
      {
        name => "National Semiconductor LM77",
        driver => "lm77",
-       i2c_addrs => [0x48..0x4b],
+       i2c_addrs => [0x48..0x4d],
        i2c_detect => sub { lm77_detect @_},
      },
      {

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
