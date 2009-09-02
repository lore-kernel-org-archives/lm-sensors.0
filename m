From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 02 Sep 2009 15:26:08 +0000
Subject: Re: [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
Message-Id: <4A9E8E90.8090208@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090811185416.GB32002@intel.com>
In-Reply-To: <20090811185416.GB32002@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 13 Aug 2009 16:22:29 +0530, Trisal, Kalhan wrote:
>> This driver used Hwmon interface ,
> 
> No, it doesn't. It registers as a hwmon device but it doesn't implement
> _any_ feature listed in Documentation/hwmon/sysfs-interface. Which can
> be easily explained: your device is not a hardware monitoring device.
> 
>> I don't find the ils29003 registering with hwmon. I still believe
>> this should be part of hwmon group.
> 
> No, it shouldn't. hwmon is for hardware monitoring. Other sensor types
> must find a different home.
For info current options I know of:

1) drivers/misc (where the isl290003 is, previously intention was to possibly
move this to iio when / if that gets merged)

2) drivers/staging/iio/light (tsl2561) I'm happy with more light sensors
in there, though the interface might need some hammering out.  Currently none
of them are using any iio specific features so can certainly go elsewhere
if people would prefer. In my personal view a lot of the processing currently
in the various drivers ought not to be in the kernel, but that's a different
matter)  IIO is currently in Greg KH's tree.

3) drivers/als (acpi ambient light sensor - latest version posted to lkml a couple
of days ago - now in acpi-testing I think)  This one is a bit different, but perhaps
a conversation needs to be opened with them to see if the requirements overlap
sufficiently to use a shared framework.) I've copied in those most active in the
discussion on that. (sorry all if you aren't interested!)

Places that aren't an option.

drivers/i2c/chips as thats going aways shortly. tsl2550 driver will have to
move out of there.
Hwmon for the reasons Jean just stated.

Any others out there?

Worth starting a more detailed discussion on a unified framework / location
for these sort of sensors?  (lkml probably)

Cheers,

Jonathan





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
