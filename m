From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 30 Jun 2011 23:44:21 +0000
Subject: [lm-sensors] [RFC 0/2] add new hwmon core interface
Message-Id: <1309477462.18912.26.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, Guenter and others,

quite some time ago we talked about adding a new hwmon core interface to
make the attributes of the drivers easily accessible to other kernel
modules. The following patch does this. It is a heavy WIP and does not
reflect the full potential of this interface, but i would like to hear
some opinions before I spend more time on this.

A short functional summary to make it more easy for you to grok this:
basically every driver that wants to provide this interface allocates a
hwmon_device_instance, fills out the cap values to reflect the
capabilities of the driver/hardware and links this struct as driverdata
the hwmon_device returned by hwmon_device_register.

hwmon_create_sysfs creates sysfs accessors according to the specified
caps and routes accesses through the attribute get and set functions of
the hwmon_device_instance.

The second patch is only a hackish dummy driver to showcase the new
interface.

Missing from this interface is a clean way to get/set trip points and
the alarm sysfs accessors are currently unimplemented.

Could you please give me some feedback? Is this the right direction or
am I doing something obviously wrong? Please CC me as I'm not on the
list.

Thanks,
Lucas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
