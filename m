From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Sep 2009 12:23:49 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090905142349.673a86b1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karl,

On Fri, 04 Sep 2009 16:40:13 -0500, Karl Schmidt wrote:
> Jean Delvare wrote:
> > Hi Karl,
> > 
> > 
> > Alarms are computed by the chips in hardware. "sensors" merely reports
> > what the driver tells it to, and the driver in turn merely reports the
> > hardware state.
> 
> Let me make sure I have this correct - lm-sensor would then have to put a value
> into a register in the hardware-sensor-chip and then the chip creates the alarm?

Yes, this is the idea. The chip's limits are programmed using "set"
statements in /etc/sensors3.conf, which are written to the chip using
"sensors -s". After that, the comparisons and alarm raising is done by
the chip itself.

> > It is interesting that you have two full-featured hardware monitoring
> > chips in your system. I'm rather surprised, I admit.
> 
> I'm wondering if it is really just one chip - I tried commenting out one at a time to see if somehow 
> appearing twice was the problem. I think it may be a host image due to incomplete hard ware encoding.
> 
> 
> This is a Tyan S2865
> 
> In case there is something being misidentified I have the spec sheet link here:
> 
> ftp://ftp.tyan.com/datasheets/d_s2865_100.pdf
> 
> 
> The lm-config from tyan has:
> 
> #To your etc/modules.conf file, add the lines:
> # 	alias char-major-89 i2c-dev
> #
> # To your /etc/rc.xxx files, add the lines:
> # 	modprobe i2c-nforce2
> # 	modprobe lm85 force_emc6d100=0,0x2e
> # sensors -s #
> # Edited by: Raphael Deng <raphaeld@tyan.com> 03.28.05
> #
> # As LM-Sensors not support the SMSC DME1737 Chip, I use the SMSC
> # EMC6D100 chip to instead of it and the sensor 3.3V StandBy and
> # Battery Volt cannot be monitored.
> 
> They then use
> chip "emc6d100-*"
> 
> But this was from 2005.. I don't think it is right for todays version??

Correct, we now do have support for the DME1737, which is definitely
present on that board.

I pretty much doubt, OTOH, that the board also has an LM85 chip. The
configuration file provided by Tyan themselves doesn't mention it, nor
does the datasheet. And the almost identical readings between both
chips make me believe this is actually the same chip. So apparently
Tyan wired the same chip on the 2 SMBus channels, which isn't exactly
smart.

Now, one thing I would like to understand is how the lm85 driver was
loaded in the first place. In the dump you sent, the chip is clearly
identified as an SMSC chip, with the device ID of the DME1737. So, if
the lm85 driver identifies this chip as a different device, it must
have been told to, by the means of a module parameter.

Please provide the output of:

modprobe -c | grep lm85

I bet you have a force_lm85b module parameter there. If so, please
remove it.

I would also be curious to see the full output sensors-detect after
unloading both the lm85 and the dme1737 drivers.

If I am correct then you should add "options dme1737 ignore=1,0x2e"
to /etc/modprobe.conf or some such. Then do not load the lm85 driver,
only the dme1737 driver, and then you should have a single chip showing
up in the output of "sensors" (except for k8temp of course) and things
should be somewhat clearer. Only then we can go on with the missing
alarms problem, if it is still present.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
