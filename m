From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jan 2010 20:11:54 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <20100114211154.37e650b3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100113153747.1dab14c5@hyperion.delvare>
In-Reply-To: <20100113153747.1dab14c5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Jan 2010 19:24:53 +0100, Manuel Lamotte-Schubert wrote:
> Hi Jean,
> > I'm surprised. For one thing, "patch" is smart and can apply patches
> > even when line numbers don't match. For another, my patch was generated
> > exactly on top of 2.6.33-rc4, so it should have applied perfectly.
> 
> The response from the patch program was something like "Patch failed" and
> it created the rejected files lm90.c.rej and KConfig.rej.

I don't know what you did, but I just double-checked and my patch
applies just fine on top of 2.6.33-rc4.

> > Just load the lm90 driver then run "sensors", you should see an entry
> > for the W83L771 with two temperature. temp1 would be the board
> > temperature and temp2 the CPU temperature.
> 
> Thats what I have already did but I was confused about the messages.
> Here's the output:
> 
> # sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +52.0°C  (crit = +90.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +52.0°C  (crit = +90.0°C)
> 
> w83l771-i2c-0-4c
> Can't get adapter name
> temp1:       +51.0°C  (low  = -40.0°C, high = +70.0°C)
>                       (crit = +85.0°C, hyst = +75.0°C)
> temp2:       +68.5°C  (low  = -40.0°C, high = +70.0°C)
>                       (crit = +110.0°C, hyst = +100.0°C)
> 
> I guess, the values temp1 and temp2, respectively, below the
> w83l771-i2c-0-4c are the board and CPU temperature.
> But what are the other temperatures, core 0 and core 1?

Core 0 and Core 1 are reported by the digital thermal sensors that are
built into your CPU.

w83l771/temp1 is a temperature sensor integrated into the W83L771 chip,
so it basically gives you the temperature of the mainboard.

w83l771/temp2 is a remote sensor, it could be monitoring virtually
everything. The most common would be the CPU, but the difference
between temp2 and the values reported by coretemp are suspicious. Maybe
it's monitoring something else, like the GPU. You'd have to ask the
Zotac folks. Or maybe either coretemp or the W83L771's remote sensor is
horribly wrong.

> Yet another question: will the patch be automatically integrated into the
> next kernel version or was it something special for me?

It was special for you. I'll send you the bill tomorrow.



OK, just kidding. Of course I'll push the patch in the next kernel
version. In fact it's already queued [1].

[1] ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
