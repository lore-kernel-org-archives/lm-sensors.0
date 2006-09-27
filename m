From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Sep 2006 12:37:50 +0000
Subject: [lm-sensors] Short term plans for lm_sensors
Message-Id: <20060927143750.bb69a428.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Now that lm_sensors 2.10.1 is released, here are a few random changes I
have in mind for 2.10.2:

* Deprecate i2c algorithm names in libsensors, stop using them in
sensors. Algorithms are implementation details users just don't care
about, and the Linux 2.6 drivers no more export this information
anyway. We already dropped all references to algorithms from
sensors-detect one year ago, this is the next logical step. We might
even drop sensors_get_algorithm_name in a future version of libsensors.
I am not aware of any userspace tool using it, except for "sensors"
itself.

* Kill the icspll driver. It isn't built by default, and I am not aware
of anyone being interested in that driver for the past 3 years. In
fact, from the file history, it looks like the driver was written back
in 1999, committed half-finished, and never ever touched again. Let's
get rid of it.

* Have i2cdetect and friends attempt to load i2c-dev automatically.
The /etc/modules.conf trick to have i2c-dev to load automatically
when /dev/i2c-* nodes are accessed no more works with udev.
sensors-detect does load i2c-dev (after asking the user), our other
tools could do it as well. There is a security concern here, which we
might want to discuss, though.

* Add ICH5 support to hotplug/p4b_smbus.c. I need it to do Linux 2.4
testing on the motherboard Winbond sent to me.

* Initialize busses before chips in libsensors. Sounds more logical
that way, and the next point needs it.

* Simplify the code which detects i2c-isa-based hwmon drivers for 2.6
kernels up to 2.6.13. The current hack is ugly.

If anyone has thoughts or objections with regards to the points listed
above, please speak up. The planned release date for lm_sensors 2.10.2
is the end of December 2006.

Thanks,
-- 
Jean Delvare

