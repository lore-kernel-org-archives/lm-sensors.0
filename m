From: jim.cromie@gmail.com (jim.cromie@gmail.com)
Date: Wed, 31 Aug 2005 22:22:05 +0000
Subject: [lm-sensors] [patch 0/2] pc87360 SDA-Array - readme
Message-Id: <200508312020.j7VKK9uW008088@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch set applies on top of:

  2.6.13
  + http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c-2.6.13.patch
  + my previous i2c-pc87360-sda-* patchset


These 2 patches are the culmination of my previous patchset - but are
seen as more controversial -- insofar that they set a direction for
other work.  They therefore warrant a separate patchset, and extra
scrutiny to insure that they go someplace good.

To support my explicit array-declare+init approach, Ive dug up this
citation 

http://groups.google.com/group/linux.kernel/browse_frm/thread/fa10a47a3c843d08/2a1465afa2f83afe?q=dynamic+sysfs+callbacks&rnum&hl=en#2a1465afa2f83afe

(msg 9 in thread, from GregKH):

No, I hate HEAD and TAIL macros.  This really isn't buying you much code
savings, you could do it yourself with the __ATTR() macro yourself with
the same ammount of code I bet... 

(msg 11, also Greg)

Hm, which makes me want to go look at trying to convert those attributes
to an array right now...

So I went with it..



01.	i2c-pc87360-sda-array-01-hwmon-sysfs-array-init.patch

This patch refactors SENSOR_DEVICE_ATTR macro.  1st it creates a new
macro __SENSOR_DEVICE_ATTR() which expands to an initialization
expression, then it uses that in SENSOR_DEVICE_ATTR, which declares
and initializes a struct sensor_device_attribute.

The split allows use of the initialization expression separately, in
array declaration/initializations, as done in following patch.

__SENSOR_DEVICE_ATTR() imitates __ATTR in include/linux/device.h



02.	i2c-pc87360-sda-array-02-array-init-loop.patch

With __SENSOR_DEVICE_ATTR's defined by 05, we now use them to
initialize a whole array of struct sensor_device_attributes.  This
allows us to loop over the array, and call device_create_file() for
each element.

The 'skews' are now expressed in 2 of __SENSOR_DEVICE_ATTR's args; 1st
arg is sysfs-label, often starting at 1_, last arg is index, always 0
except for therm-units, which are using VLMs 11,12,13, and hence have
a +11 term in them.


[jimc@harpo pset-pc87360-sda-array]$ diffstat i2c-pc87360-sda-array-0*
 D-1/include/linux/hwmon-sysfs.h |   20 +-
 D-2/drivers/hwmon/pc87360.c     |  347 ++++++++++++++++++----------------------
 2 files changed, 175 insertions(+), 192 deletions(-)


and non-debug module sizes:

[jimc@harpo i2c-stuff]$ ll D-*/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 157856 Aug 31 13:04 D-1/drivers/hwmon/pc87360.ko
-rw-rw-r--  1 jimc jimc 143256 Aug 31 13:05 D-2/drivers/hwmon/pc87360.ko




The 2 patches each incrementally; apply and compile clean, and pass
this cursory test: 
	rmmod pc87360; 
	make modules_install; 
	modprobe pc87360;
	sensors -s; 
	sensors


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
