From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 03 Sep 2009 03:35:39 +0000
Subject: Re: [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
Message-Id: <1251948939.3483.285.camel@rzhang-dt>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090811185416.GB32002@intel.com>
In-Reply-To: <20090811185416.GB32002@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2009-09-02 at 23:26 +0800, Jonathan Cameron wrote:
> Jean Delvare wrote:
> > On Thu, 13 Aug 2009 16:22:29 +0530, Trisal, Kalhan wrote:
> >> This driver used Hwmon interface ,
> > 
> > No, it doesn't. It registers as a hwmon device but it doesn't implement
> > _any_ feature listed in Documentation/hwmon/sysfs-interface. Which can
> > be easily explained: your device is not a hardware monitoring device.
> > 
I tried to bind the ACPI ALS device driver with the hwmon sysfs I/F at
the beginning, then stopped for the same reason.
that's why the generic ALS sysfs class is introduced.

> >> I don't find the ils29003 registering with hwmon. I still believe
> >> this should be part of hwmon group.
> > 
> > No, it shouldn't. hwmon is for hardware monitoring. Other sensor types
> > must find a different home.
> For info current options I know of:
> 
> 1) drivers/misc (where the isl290003 is, previously intention was to possibly
> move this to iio when / if that gets merged)
> 
> 2) drivers/staging/iio/light (tsl2561) I'm happy with more light sensors
> in there, though the interface might need some hammering out.  Currently none
> of them are using any iio specific features so can certainly go elsewhere
> if people would prefer. In my personal view a lot of the processing currently
> in the various drivers ought not to be in the kernel, but that's a different
> matter)  IIO is currently in Greg KH's tree.
> 
> 3) drivers/als (acpi ambient light sensor - latest version posted to lkml a couple
> of days ago - now in acpi-testing I think) 

it's not ACPI ambient light sensor.
drivers/als/als.c is a new sysfs class (als_class) which provides a
generic sysfs I/F for all the ALS devices.
ACPI ALS device driver is just the first user of this class.

>  This one is a bit different, but perhaps
> a conversation needs to be opened with them to see if the requirements overlap
> sufficiently to use a shared framework.)

right.
As I'm not familiar with other ALS devices, I just introduced two sysfs
I/F which IMO are needed for all the ALS devices.
We can add any attributes which are generic and useful. :)

thanks,
rui



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
