From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 27 Oct 2007 08:44:04 +0000
Subject: [lm-sensors] HP maxilife chips have a '-' in their prefix
Message-Id: <4722FA54.4080503@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

While working on a new driver I wanted to use a '-' or '_' in the driver name / 
prefix. Since I thought a '-' wasn't allowed I checked lib/chips.h in trunk.

And there are already chips with a - in the prefix, the HP maxilife family.

This will work with the 2.10.x variant of sensors_parse_chip_name() but not 
with the 3.0.0 variant of sensors_parse_chip_name().

Now I don;t see a 2.6 driver for the hp maxilife chips, so this probably isn't 
a problem, still I wanted people to know.

Regards,

Hans


p.s.

While checking prefixes I also found a copy and paste error in the fschmd and 
fschrc support, meaning that these won't work with 2.10.5 :( (already fixed in 
trunk).


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
