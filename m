From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Jan 2011 08:50:53 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <20110119095053.0e4de6c1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 18 Jan 2011 21:51:23 -0800, Guenter Roeck wrote:
> On Wed, Jan 19, 2011 at 12:16:12AM -0500, Jerry Lin wrote:
> 
> Please don't top-post.
> 
> > Thanks for the quick response. As far as I know, max1617 was suggested
> > by sensors-detect (or something else suggested it -- I didn't type it
> > in myself).

This is entirely possible, the max1617 has very bad detection (no
device nor manufacturer ID) so false positives are frequent. We should
probably drop detection altogether.

> S5500HCV board spec shows a TMP75 sensor. Can you try to load the lm75 module instead?

Note that the lm75 driver only detects the original LM75 devices. Other
supported devices such as the TMP75 need to be instantiated explicitly.

> > Unfortunately, "sudo modprobe coretemp" yields "FATAL: Error inserting
> > coretemp (/lib/modules/2.6.32-27-generic/kernel/drivers/hwmon/coretemp.ko):
> > No such device"
> >
> "No such device" indicates that the driver failed to load, typically because 
> the core does not support built-in temperature sensors.
> Odd - I thought that all recent Intel CPUs support core temperature sensors.
> Looks like this one doesn't.

Universal detection was only added to the coretemp driver in kernel
2.6.35, while Jerry runs kernel 2.6.32.

Jerry, please try the stand-alone coretemp driver at:
  http://khali.linux-fr.org/devel/misc/coretemp/
This is basically the version from the latest kernel, with some
compatibility bits added so that it builds and runs on older kernels
too.

Installation instructions can be downloaded from:
  http://khali.linux-fr.org/devel/misc/INSTALL
This is a document I just wrote, let me know if it contains errors or
can be improved in any way.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
