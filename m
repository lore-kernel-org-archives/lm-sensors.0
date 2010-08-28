From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Aug 2010 08:20:15 +0000
Subject: Re: [lm-sensors] Disabling fan control under Linux
Message-Id: <20100828102015.30fb7853@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C74AD95.8030505@gmail.com>
In-Reply-To: <4C74AD95.8030505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Aug 2010 02:53:20 -0300, ICMP Request wrote:
>   On 8/25/2010 2:43 AM, ICMP Request wrote:
> >  Hello! I'm planning to install lm_sensors in my Linux platform using 
> > Gentoo, but I've got a little worried when I've read the following 
> > about lm_sensors on Gentoo Wiki:
> >
> > "Warning: Be careful when activating sensors, like i2c, in the kernel. 
> > On some systems this might stop the fans from working and can disable 
> > the ACPI system-overheat shutdown as well. This will cause your 
> > computer to freeze at best, or may even cause serious hardware damage.

This point was addressed in kernel 2.6.32. If ACPI requested the I/O
ports of your hardware monitoring device (or SMBus controller, for
I2C/SMBus hardware monitoring devices), then native Linux drivers won't
touch it.

> >     * See the lm_sensors website for a problematic hardware list.

I am not aware of any such list on our website.

> >     * Using lm_sensors on IBM ThinkPads is especially not advised"

This last item is way outdated and should be removed. I'm running
lm-sensors on my own ThinkPad laptop and it works just fine.

> >
> > Well, I believe my hardware is in the supported list, but to avoid any 
> > problems, I would like to disable fan control under 
> > Linux/acpi/lm_sensors and any application using sensors, so they 
> > cannot turn my fan off. Fan would be purely controlled by hardware.
> >
> > Can it be done by simply disabling the "fan" as built-in or module 
> > under ACPI?
> >
> > Under Linux 2.6 Kernel:
> >
> > Power management and ACPI options -> ACPI (Advanced Configuration and 
> > Power Interface) Support -> Fan =n
> >
> > Or do I have to do something more complex?

I'm not sure what exactly loading the acpi "fan" driver does, but
probably not much. I think it is simply responsible for stopping the
fan when you suspend the machine.

> 
> Oh sorry, I've forgot to mention that I wish to disable turning my fan 
> off but I still want to enable full acpi/lm_sensors to check my cpu 
> temp/status, battery state, cpu freq scaling, etc. So is this possible 
> to by doing what I mentioned above disable this single option but enable 
> all the rest?

I don't think it makes much sense to disable the ACPI fan driver. If
anything is actually changing the fan's speed, it's not the ACPI fan
driver. If you don't want software-based fan speed control, then just
don't run pwmconfig, and you'll be safe.

Anyway, I can't add much as long as you don't tell us what your
hardware is, and how you believe the fan speed control (if there is
any) is achieved. Some machines have setting for this in the BIOS, some
don't. Some machines have ACPI-based control, some have monitoring
chips which can be programmed for automatic fan speed control.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
