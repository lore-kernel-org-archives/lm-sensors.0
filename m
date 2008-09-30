From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Sep 2008 13:59:55 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (w83791d) fan 4/5 pins can also
Message-Id: <20080930155955.1bb56a93@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808060029.31190.m.hulsman@tudelft.nl>
In-Reply-To: <200808060029.31190.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marc, Hans,

On Wed, 06 Aug 2008 09:46:05 +0200, Hans de Goede wrote:
> Marc Hulsman wrote:
> > Fan 4/5 and PWM 4/5 pins can be used for GPIO. If the bios initializes these 
> > pins as in use for GPIO we keep it that way and do not construct the 
> > sysfs-interface for them.  I left the code for reading the corresponding 
> > registers during update_device unchanged as adding conditional terms would 
> > only complicate the code. 
> 
> Looks good:
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Patch applied, thanks.

> One note though (for a future patch) you say you keep reading the unused regs 
> to keep the code clean. I understand this, but please keep in mind that i2c is 
> pretty slow, so you might want todo another patch changing this.

I second that. Every I2C register access we can avoid (without loss of
functionality, of course) is welcome.

> Or even better write a patch where you stop re-reading never changing registers 
> completely, iow read config / min / max registers only once on probe and then 
> only read registers which actually measure things (and thus can change without 
> a write) in update_device (Yes there is the potential problem of acpi code 
> writing to the device underneath us but we aren't checking for that now anyways).

This could be done too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
