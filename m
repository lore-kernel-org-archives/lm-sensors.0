From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Mar 2013 12:14:25 +0000
Subject: Re: [lm-sensors] Max6650 not working / no sysfs entries
Message-Id: <20130315131425.4aab3891@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1DE40A3D-6512-40E3-8281-F3F86A9C5432@terjung.net>
In-Reply-To: <1DE40A3D-6512-40E3-8281-F3F86A9C5432@terjung.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aike,

On Fri, 15 Mar 2013 12:08:50 +0100, Aike Kristian Terjung wrote:
> i have added a MAX6650 to the i2c-bus of my guruplug server to control a fan i would like to add to the system. Sensors-detect is able to find the device suggests the max6650 module. If i add max6650 module to the kernel nothing happens. sensors did not mention the max6650 and does not show the fan, no sysfs entries are visible under /sys/class/hwmon.
> I added some debug-output to the module to get closer, with the result that sensors_max6650_init is called, but not max6650_probe i would expect next.
> 
> The max6646 temperature-sensor i added additionally is working fine and is present in sysfs.
> 
> Could this be the result of a damaged max6650? I did some soldering-misstakes in my first attemp, but i am pretty shire that the wiring should be ok now because sensors-detect can find the chip. 

The MAX6650 is almost impossible to detect reliably, and for this
reason the max6650 kernel driver doesn't even try to detect the
devices (detection code was dropped in kernel v3.0), and relies on the
user to instantiate the device explicitly. See method 4 in
  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/i2c/instantiating-devices
for how this works.

Note that MAX6650 device detection was dropped from sensors-detect as
well by now, so this is consistent.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
