From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 13:44:32 +0000
Subject: [lm-sensors] lm-sensors 3.0.0-rc3 has been released
Message-Id: <20071028144432.7d795d18@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

A third release candidate for lm-sensors 3.0.0 has just been released.
Changes from rc2:

* The default configuration file is now defined in libsensors, rather
than in applications using it. This makes it easier for a distribution
to use a different default if needed. It should also make applications
more simple: most applications no longer have to care about the
configuration file.

* libsensors supports an alternative default configuration file. It will
search for /etc/sensors3.conf first, and if that file doesn't exist, it
will fall back to /etc/sensors.conf. This is to make it possible to
install libsensors from lm-sensors 2 and libsensors from lm-sensors 3
in parallel: each version of the library needs its own configuration
file. Distributions will need this until all applications are migrated
to the new libsensors.

* sensors is again installed as "sensors" and not "sensors3".

The main goal of this release candidate is let distributions try to
package it and see how it goes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
