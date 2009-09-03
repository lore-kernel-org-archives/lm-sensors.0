From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Sep 2009 10:51:15 +0000
Subject: Re: [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
Message-Id: <20090903125115.01b66f97@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090811185416.GB32002@intel.com>
In-Reply-To: <20090811185416.GB32002@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rui,

On Thu, 03 Sep 2009 11:35:39 +0800, Zhang Rui wrote:
> On Wed, 2009-09-02 at 23:26 +0800, Jonathan Cameron wrote:
> > 3) drivers/als (acpi ambient light sensor - latest version posted to lkml a couple
> > of days ago - now in acpi-testing I think) 
> 
> it's not ACPI ambient light sensor.
> drivers/als/als.c is a new sysfs class (als_class) which provides a
> generic sysfs I/F for all the ALS devices.
> ACPI ALS device driver is just the first user of this class.

Excellent. Thanks a lot for doing this! The old tls2550 driver should
probably be moved to this directory and interface. If the interface
documented somewhere?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
