From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Jun 2007 16:52:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <20070606185212.60b36554@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Jun 2007 17:47:36 +0200, Ivo Manca wrote:
> Yeah, it seems like this was the problem.
> Strange though, since it did work in my 2.6.19 kernel.

Depends on the order in which the modules are loaded, and a number of
different things can change that. The good news is that my patch seems
to work. Please try unloaded and reloading the sis5595 driver to make
sure (without i2c-sis5595 nor i2c-sis630 loaded, of course.)

The conflict between sis5595 and i2c-sis5595/i2c-sis630 is of the same
nature as the conflict between via686a/vt8231 and i2c-viapro. It _was_
solved for the VIA drivers (in 2.6.10), but seemingly not for the SiS
drivers. I'm surprised nobody ever reported it, I guess SiS hardware is
way less popular than VIA hardware. It's not too difficult to fix, I
could give it a try if you want.

> Loading them in the way sensors-detect suggest (first i2c-sis5595, then 
> sis5595), gives me the following output:
> 
> Jun  6 15:23:01 localhost kernel: i2c-dev: adapter [SMBus SIS5595 adapter at 
> 0438] registered as minor 0
> Jun  6 15:23:02 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x705, 
> arg=0xbf886b54
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x5401, 
> arg=0xbfa9e818
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: i2c ioctl, cmd: 0x5401, 
> arg: 0xbfa9e818
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x705, 
> arg=0x82ff3c0
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x703, 
> arg=0x09
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x720, 
> arg=0x82ff550
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: SMBus busy (0400). 
> Resetting...
> Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: Failed! (400)
> 
> Then it repeats:
> Jun  6 15:23:07 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x703, 
> arg=0x77
> Jun  6 15:23:07 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x720, 
> arg=0x82ff550
> Jun  6 15:23:07 localhost kernel: i2c-adapter i2c-0: SMBus busy (0400). 
> Resetting...
> Jun  6 15:23:08 localhost kernel: i2c-adapter i2c-0: Failed! (400)
> 
> Where it changes the 0x77 from 0x09 to 0x77
> Bug or feature?

You see these messages only because you have CONFIG_I2C_DEBUG_BUS=y.
I'm a bit surprised that the reset is said to have failed, but other
than that, these messages are caused by failed probes, which
sensors-detect and i2c-detect do a lot by design, so you can just
ignore them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
