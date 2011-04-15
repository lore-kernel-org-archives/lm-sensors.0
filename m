From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Apr 2011 07:32:15 +0000
Subject: Re: [lm-sensors] hwmon: (adm1021) Clarify documentation regarding
Message-Id: <20110415093215.01584a95@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110409183156.215fa01e@endymion.delvare>
In-Reply-To: <20110409183156.215fa01e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Apr 2011 21:57:11 -0700, Darren Hart wrote:
> On 04/10/2011 12:08 AM, Jean Delvare wrote:
> > This is all the other way around. The adm1021 driver doesn't auto-load
> > on PC systems. The way it usually goes is that sensors-detect will
> > detect a compatible device, and it will set the adm1021 driver to be
> > loaded when the lm_sensors service is started. The adm1021 driver, in
> > turn, tries to detect compatible devices, and bind to them if found.
> > 
> > So the problem boils down to two related issues:
> > * The sensors-detect script seemingly misdetected a device on your
> >   system.
> > * The adm1021 got loaded and misdetected the same device.
> > Which is expected as in general sensors-detect has the same detection
> > code as hwmon drivers on the kernel side.
> > 
> > That being said, this can only be fixed if you provide the full output
> > of sensors-detect on your system after unloading all hwmon drivers
> > (stopping the lm_sensors service sometimes do, but not always, depends
> > on the distribution) and a dump of the misdetected device. This will
> > confirm the misdetection and hopefully offer a way to avoid it.
> 
> This system is really throwing me for a loop. After returning from ELC I
> powered it back up and have been completely unable to get sensors to
> read anything from w83795 or ipmi-si even.

Try a complete power-off including removal from the mains power plug
for 1 minute.

> Running sensors-detect
> (without any hwmon modules loaded) finds only ipmi-si and w83627ehf, but
> sensors only reports on w83627ehf).
> 
> I have attached the typescript of the sensors-detect session, but it
> isn't very interesting. If I stumble across another odd set modules
> detected, I'll report back to the list.

From the sensors-detect log:
> FATAL: Module i2c_dev not found.
> Failed to load module i2c-dev.

You'll have to check where this module has gone. If this is a
self-built kernel, check that you have:
CONFIG_I2C_CHARDEV=m

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
