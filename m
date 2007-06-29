From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 11:44:34 +0000
Subject: [lm-sensors] VRM value in libsensors/sensors
Message-Id: <20070629134434.66d96ab3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am thinking of removing SENSORS_FEATURE_VRM from the new libsensors.
A first reason for that is that the newer VRM codes as used in the 2.6
kernel are arbitrary numbers and don't match the Intel specification
numbers as the first ones did. So we may display things like "VRM
version 1.3" and that's confusing because it doesn't correspond to
anything real. A second reason is that Rudolf Marek added code to set
the VRM version automatically depending on the CPU model some times ago
already, and it works very well, so the users no longer have to care
about VRM versions.

I would even go as far as switching the vrm attribute of the hwmon
kernel drivers to read-only... or even remove them entirely.

Thoughts anyone?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
