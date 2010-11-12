From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 12 Nov 2010 20:33:45 +0000
Subject: [lm-sensors] Location for thermal drivers
Message-Id: <1289594026.22931.388.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lm-sensors@lm-sensors.org

Hi all,

We have a review for a thermal driver for the Intel MID platform pending
against the hwmon subsystem. See
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-November/030471.html for details.

I think a better location for the driver would be drivers/thermal.
drivers/hwmon is not really a good fit, since hwmon support for thermal
drivers is optional. Potential problem with drivers/thermal is that
there are no thermal drivers in there (yet), and there does not seem to
be a maintainer. Another alternative would be to put it into platform
code, similar to the existing thermal drivers.

Thought, anyone ? Is there a preferred location for thermal drivers ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
