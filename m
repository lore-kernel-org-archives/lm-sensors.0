From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Apr 2007 15:20:52 +0000
Subject: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <461A59D4.2050409@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've committed everything my students had written + some fixes done by me after 
some initial testing to the 3.0.0 sensors branch.

I claim in no way that this code is perfect, I did things this way to properly 
document / atrribute who wrote what, and to give us a starting point as I think 
the code in general is ok. It needs testing and cleanups, but its not a bad 
starting point perse.

So please test this:
1) checkout the 3.0.0 branch:
    svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
2) comment the entries for your chips int he table at the end of lib/chips.c
    and in the table near the end of progs/sensors/main.c
3) compile and install as usual
4) run sensors and let me/us know how it works

Regards,

Hans


p.s.

I'm planning on doing several cleanups of the code as submitted the coming few 
days, as time permits. Plans so far:
-cleanup the regex used to see if a sysfs entry actual is a sysfs sensor file,
  so that it doesn't match everything (including entries like: uevent, modalias,
  etc), but only matches the actual known / document sysfs sensor files
-cleanup the new sensors_feature_get_type to be much more robust / do much
  exacter matching

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
