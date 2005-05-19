From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1326
Message-Id: <20030716094816.3dc6ca45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C658B79.5020609@dipsy.dhs.org>
In-Reply-To: <3C658B79.5020609@dipsy.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> on rounding again...
> below /proc/sys/dev/sensors/(chip_id), there are values with two
> decimal positions only, which are already rounded down.
> I'm using the w83781d driver here, but I cannot find where those
> values are written (a search for '.2f' didn't yield anything
> useful - probably things are done lower-level).

Values are internally handled as integer values, expressed in
centivolts.

> Perhaps the general solution would be to write out full mV values
> (%.3f) so that sensors.c can round them itself.
> Do you think that can be done easily?

Well, this could be done, but the values would be wrong again (less
wrong, OK, but still not exact), because we would have a resolution of
1/1000 V in /proc values while the sensors themselves have a 1/160 V
resolution. So we won't really escape rounding problems that way.

To me, the real solution would be to export the native values in /proc,
and use sensors.conf for the conversion. I think I remember this was
already discussed, maybe even more than once, and it was decided that
all voltage values in /proc would have the same unit. I guess that this
is more important than having an "infinite precision" in the readings.
After all, who cares if the min value is 1.63V or 1.64V? Well... you ;)
but most people don't care at all.

Anyway you were right, there is a rounding problem in the w83781d driver
(and in 7 other drivers as well). I commited a fix for the w83781d,
attached to this mail. Please try it and tell me if it works for you.
The fix is trivial, I think you'll understand how it works at first
sight.

However, please understand that it won't necessary make all min-max
values symmetrical, because .5 is always rounded up (so 1.615-1.685
would show as 1.62-1.69, for example, and there's nothing wrong with
that.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: w83781d.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/w83781d.c,v
retrieving revision 1.102
diff -u -r1.102 w83781d.c
--- w83781d.c	10 Jun 2003 03:01:31 -0000	1.102
+++ w83781d.c	16 Jul 2003 07:41:52 -0000
@@ -178,7 +178,7 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
-#define IN_FROM_REG(val) (((val) * 16) / 10)
+#define IN_FROM_REG(val) (((val) * 16 + 5) / 10)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
