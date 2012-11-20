From: Marc Ferland <ferlandm@sonatest.com>
Date: Tue, 20 Nov 2012 14:26:12 +0000
Subject: [lm-sensors] fancontrol configuration with absolute paths
Message-Id: <87fw444agr.fsf@sonatest.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The fancontrol man page states that you can use both relative (from
/sys/bus/i2c/devices or /sys/class/hwmon) or absolute paths in
fancontrol configuration files but from what I've tested (and from the
fancontrol code) it seems like this is currently broken.

For example, I get:
Configuration is too old, please run pwmconfig again

when running a configuration that uses absolute paths.

Regards,

Marc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
