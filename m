From: brylu <brylu@akron.net.pl>
Date: Wed, 12 Oct 2011 15:20:10 +0000
Subject: [lm-sensors] lm_sensors and static kernel
Message-Id: <4E970050.10209@akron.net.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello

I don't know if it's just me but, I don't have problem with lm_sensors
with kernel components compiled as modules everything works fine, but
when those components are compiled in statically and no module support
is enabled in the kernel I can't get it to work, sensors-detect detect
the correct drivers and stuff but sensors returns no modules found.

Did anyone succeeded in having it work with a static kernel, no modules
at all all compiled in?

Thanks...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
