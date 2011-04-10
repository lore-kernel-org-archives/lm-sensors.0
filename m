From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Apr 2011 07:08:48 +0000
Subject: Re: [lm-sensors] hwmon: (adm1021) Clarify documentation regarding
Message-Id: <20110410090848.773423a1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110409183156.215fa01e@endymion.delvare>
In-Reply-To: <20110409183156.215fa01e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darren,

On Sat, 09 Apr 2011 16:15:45 -0700, Darren Hart wrote:
> On 04/09/2011 01:39 PM, Guenter Roeck wrote:
> > On Sat, Apr 09, 2011 at 12:31:56PM -0400, Jean Delvare wrote:
> >> Recent Xeon processor thermal sensors are supported by the coretemp
> >> driver and not the adm1021 driver. Only one old generation of Xeon
> >> processors (the first Netburst ones) are supported by the adm1021
> >> driver.
> 
> In addition to changing the kernel config help, is there a way to avoid
> loading this driver for non netburst type CPUs? Someway to blacklist
> later CPUs from using this driver? Seems this would make sensors-detect
> and such behave better.

This is all the other way around. The adm1021 driver doesn't auto-load
on PC systems. The way it usually goes is that sensors-detect will
detect a compatible device, and it will set the adm1021 driver to be
loaded when the lm_sensors service is started. The adm1021 driver, in
turn, tries to detect compatible devices, and bind to them if found.

So the problem boils down to two related issues:
* The sensors-detect script seemingly misdetected a device on your
  system.
* The adm1021 got loaded and misdetected the same device.
Which is expected as in general sensors-detect has the same detection
code as hwmon drivers on the kernel side.

That being said, this can only be fixed if you provide the full output
of sensors-detect on your system after unloading all hwmon drivers
(stopping the lm_sensors service sometimes do, but not always, depends
on the distribution) and a dump of the misdetected device. This will
confirm the misdetection and hopefully offer a way to avoid it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
