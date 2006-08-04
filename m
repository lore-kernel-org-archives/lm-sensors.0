From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 04 Aug 2006 14:53:53 +0000
Subject: [lm-sensors] Adding userspace support for ipmisensors
Message-Id: <20060804165353.87b4b1bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
In-Reply-To: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> I have a stablish working ipmisensors driver (the bmcsensors re-write
> for kernel 2.6/hwmon - see
> http://bmcsensors-26.sourceforge.net/ipmisensors/ for patches), and
> I'm tyring to add support to libsensors and sensors for testing. As
> far as I can tell the following patch should work,

We can obviously apply this, it's not very intrusive ;) However, may I
ask why you didn't simply keep the "bmc" prefix? You would have won
compatibility with a few previous releases of lm_sensors, and the name
change might also confuse the users.

You missed one bmc -> impi duplication in etc/sensors.conf.eg.

> however after
> applying it I still can't see the sensors (yet the entries do appear
> in /sys/class/hwmon/hwmon0/*). Any help would be appreciated (as you
> can tell I'm new to the userspace side ;)

If you are usins lm_sensors 2.10.0, it has a known bug that prevents
hardware monitoring chips from being properly detected if there isn't
at least one i2c chip with a driver loaded. This is fixed in SVN, so
you should use that.

Secondly, make sure you created a "name" attribute with the chip type
(that would be "ipmi" for you) for your device.

Lastly, libsensors has some bus-specific code to generate chip
"names" (like "adm1032-i2c-1-4c"). Depending on where in the sysfs tree
your device is, the code might fail to generate a proper name. The code
doing that is in lib/sysfs.c:sensors_read_sysfs_bus() if you want to
take a look.

strace might come in handy to diagnose the problem.

> I do have some other concerns/ideas on support ipmisensors would be
> looking for in libsensors, and considering a possible re-write I feel
> I should list these now.
> 
> - fixed number of sensors
> ipmisensors has a dynamic ("hotplug" sensors not supported at runtime
> at the moment) and unknown number of sensors. As far as I can tell
> libsensors needs to know a fixed number.

For now, yes. However there are plans floating around to have
libsensors probe for chip features (Linux 2.6 only) instead of using an
internal hard-coded list for every chip. That's what Mark M. Hoffman
and I had been discussing at the restaurant in Ottawa, if you remember.
I know Hans de Goede has interest in this too, unfortunately I'm a bit
too busy right now to go on.

> - labels given
> ipmisensors gives the BMC's labels for each sensors in a "label"
> entry. This should be easy to add support for (perhaps defaulting to
> these labels without user configured labels).

Yeah, that would be very convenient for the users. Indeed it shouldn't
be too hard to implement. Once again I think I read that Hans de Goede
has a similar need for his new uGuru2 driver.

> - binary sensors
> IPMI supports "non-threshold sensors" for things like power status,
> chassis intrusion, etc, which are basically binary valued.

You mean _booleans_?

> I plan to
> add support for these to the driver, but do these belong in lm-sensors
> and how hard would it be to add support for them to libsensors?

I see no problem here, booleans are simple integers after all, so this
is already support. Attributes like pwm1_enable were booleans too until
recently, and it works just fine.

The extra attributes (e.g. chassis intrusion) might lack proper
standardization at the moment, though.

-- 
Jean Delvare

