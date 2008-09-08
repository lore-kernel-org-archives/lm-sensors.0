From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Sep 2008 21:19:07 +0000
Subject: Re: [lm-sensors] EVGA nForce 750i motherboard
Message-Id: <20080908231907.26cc69a3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C49CDE.7090800@gmail.com>
In-Reply-To: <48C49CDE.7090800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Mon, 08 Sep 2008 06:58:02 -0700, Dean Loros wrote:
> Updated info below----
> 
> Jean Delvare wrote:
> > i2cdump is no longer part of lm-sensors and is now part of a separate
> > package named i2c-tools. Please install that package first and then you
> > should have i2cdump. When you have it, please run the isadump command
> > as well, it's better to have both dumps done at the same time for
> > comparison purposes.
> 
> dean@linux:~/Desktop$ sudo i2cdump 1 0x2d b
> [sudo] password for dean:
> Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or
> directory
> dean@linux:~/Desktop$ sudo isadump
> Syntax for I2C-like access:
>   isadump [-y] [-k V1,V2...] ADDRREG DATAREG [BANK [BANKREG]]
> Syntax for flat address space:
>   isadump [-y] -f ADDRESS [RANGE [BANK [BANKREG]]]
> 
> Still problems there---please tell me the range you need

Sorry, I forgot to mention that you need to load the i2c-dev kernel
module before running i2cdump. So, the correct sequence now that you
have all the tools installed would be:

rmmod lm78
rmmod w83627ehf
modprobe i2c-dev
isadump 0x295 0x296
i2cdump 1 0x2d b

> > (...)
> > Could be that temp1 isn't wired at all. Does it change in a consistent
> > way depending in the system load?
> 
> Not really--only seems to vary about 10c

Well, 10 degrees C is a reasonable temperature change, especially if
the direction of the change correlates with the system load. Maybe an
offset needs to be applied to get the correct temperature. That would
be unusual for a thermistor on a W83627DHG, but we can't rule it out
completely.

> > (...)
> > Is the BIOS displaying it? How many wires does this fan have?
> 
> Yes--it is a three-wire connector
> > 
> > Remember that the default labels in sensors3.conf may not match your
> > motherboard.
> Understood
> > 
> > Also, the w83627ehf driver is adjusting the fan clock divisors
> > automatically, so it may take a couple runs of "sensors" before fan
> > speeds show.
> 
> Understood--as you can see, there are two speeds not showing--I would
> guess that it "should" be one of those, but they do not have speed
> outputs still. The Northbridge speed is around 2000 in the BIOS.

In your original post, fan3 was displayed at 1240 with a clock divider
of 8.

How many fan speeds does the BIOS show, and can you match some of the
values with what "sensors" displays? The W83627DHG has 5 fan inputs,
which should be enough for most motherboards, so it would be really
surprising if your northbridge fan is connected to another chip.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
