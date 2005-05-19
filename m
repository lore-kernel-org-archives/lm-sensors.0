From: louis-martin.cote@verint.com (cote, louis-martin)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Possible bug in i2c_register_entry ?
Message-Id: <6C25030C55C5D84FBEFD632E966730653109A7@mtlmail1.Co.Corp.VerintSystems.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
In-Reply-To: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rebonjour Jean,

> I remember we have been discussing about this chip some times 
> ago. A guy named
> MonMotha was working on a driver like one year ago.
> 
> Chosen mailing-list threads:
> http://archives.andrew.net.au/lm-sensors/msg03241.html
> http://archives.andrew.net.au/lm-sensors/msg06033.html
> 
> You will find driver code at the end of the second thread, in 
> case you want to
> compare with what you have.

It's funny how my code is similar to his, considering I started from scratch. :)

This leads me to a question that has been bugging me fow a little while.

You see, the PCA9555 chip is NOT a sensor chip. Hence, I find it rather inapropriate that its sysctl entries end up in /proc/sys/dev/sensors.
In fact, I think this choice should be left to the module writer.

The root of this problem is, I think, that i2c-proc.o contains the sensor code. IMHO, i2c-proc should contain only the generic I2C services that are common to all I2C devices. We should come up with a new module, say, i2c-proc-sensors.o to hold everything related strictly to sensors.

The hardware I'm working on right now has 4 I2C devices, with only one being a temp sensor... I'm stuck rewriting quite a bit of code because i2c-proc is too much sensor-specific (for my needs at least).

I understand the i2c kernel development originates for lmsensors. However, there is much more to I2C devices than temp sensors; shouldn't the kernel code reflect that ?

Things might already be better in 2.6, I honestly haven't looked at it yet. We only use 2.4 for the time being.

> I understand your point. I will be working with a PCA9556 
> myself pretty soon,
> and am facing the same problem. The chip could be used for completely
> different things in other systems, so writing a generic 
> driver doesn't seem to
> make much sense. Maybe I'll end up writing a driver though, 
> with a low-level
> interface only accessible to other kernel modules and not 
> user-space. I have
> to think about it a little more.
> The idea of having a driver for these chip is that we don't 
> want people to
> rewrite code which already exists.

I understand. It is a noble goal. I may revisit my PCA9555 module in the future (I'm a little too rushed right now) to give it a try as well! 

> Yes, we are interested. The prefered form is a patch against 
> the latest
> lm_sensors2 CVS tree. Note that we are in a feature freeze 
> state for now,
> until we release 2.8.8. This should happen within a week or 
> two. You can still
> provide a patch now and we'll apply it later.
> 
> Ideally the patch would contain a kernel driver in 
> kernel/chips, changes to
> kernel/chips/Module.mk for it to be recognized, updates to 
> libsensors, a new
> section in etc/sensors.conf.eg, updates to prog/sensors, an update to
> doc/chips/SUMMARY and documentation in doc/chips/lm77. If you 
> only provide
> part of this, this is welcome too.

I will do my best to provide as much as possible. It may take a little while, though.
Spare time is a scarce resource! 

Merci encore & bonne journ?e !


Louis-Martin
