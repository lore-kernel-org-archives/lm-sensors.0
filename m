From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Mar 2010 21:38:06 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100308223806.50602c6d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 8 Mar 2010 13:28:55 -0800, Phillip Pi wrote:
> > > Nothing interesting in the DSDT; the hwmon chip is used only for
> > > reading a temperature (TZ).
> > > I think you can use "acpi_enforce_resources=lax", there not other ways
> > > to access the sensor data.
> > 
> > If you do, please make sure to blacklist the ACPI "thermal" driver.
>
> Where do I set blacklist it?

Depends on the distribution. Sometimes it's enough to add:

blacklist thermal

to /etc/modprobe.d/*.conf, but sometimes init scripts actively load the
thermal driver, so you have to hack them or at least edit
distro-specific config files.

> What is bad about "thermal" driver? 
> Conflict?

Yes. The thermal driver will access the same I/O ports as the w83627ehf
driver, without any synchronization between them, so very bad things
can happen.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
