From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Aug 2010 18:33:22 +0000
Subject: Re: [lm-sensors] Ambient temperature sensor driver
Message-Id: <20100825203322.5e4f2aa7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <A39D6EE762981A42A5E83744F71F8460087E0581@az33exm20>
In-Reply-To: <A39D6EE762981A42A5E83744F71F8460087E0581@az33exm20>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Danny,

On Wed, 25 Aug 2010 12:42:11 -0500, Nold Danny-R59715 wrote:
> Hello lm-sensors group,
> 
> I'm developing a Linux driver for a PMIC that includes an ambient
> temperature sensor.  In trying to determine where the temperature sensor
> driver piece should belong in the Linux driver hierarchy, I discovered
> this group and the temperature sensor drivers in the /hwmon directory.
> 
> My question: Does a driver for an ambient temperature sensor belong in
> hwmon, and is it consistent with the lm-sensors project?  I ask because
> the purpose of this driver is not "monitoring the hardware health of
> Linux systems containing hardware health monitoring hardware".

Yes, such a driver would belong to drivers/hwmon and will be supported
by lm-sensors. Just make sure your driver adheres to
Documentation/hwmon/sysfs-interface.

Despite its name, the hwmon subsystem handles any kind of temperature
sensor. The main reason is that the same thermal sensor chip type can
be used for both hardware monitoring and other uses.

> If this driver does not belong in hwmon, is there an obvious home for
> it?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
