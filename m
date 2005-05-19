From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Possible bug in i2c_register_entry ?
Message-Id: <20040929140356.M36886@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
In-Reply-To: <6C25030C55C5D84FBEFD632E96673065310998@mtlmail1.Co.Corp.VerintSystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You see, the PCA9555 chip is NOT a sensor chip. Hence, I find it 
> rather inapropriate that its sysctl entries end up in /proc/sys/dev/sensors.
> In fact, I think this choice should be left to the module writer.
> 
> The root of this problem is, I think, that i2c-proc.o contains the 
> sensor code. IMHO, i2c-proc should contain only the generic I2C 
> services that are common to all I2C devices. We should come up with 
> a new module, say, i2c-proc-sensors.o to hold everything related 
> strictly to sensors.
> 
> The hardware I'm working on right now has 4 I2C devices, with only 
> one being a temp sensor... I'm stuck rewriting quite a bit of code 
> because i2c-proc is too much sensor-specific (for my needs at least).
> 
> I understand the i2c kernel development originates for lmsensors. 
> However, there is much more to I2C devices than temp sensors; 
> shouldn't the kernel code reflect that ?

100% agreed.

> Things might already be better in 2.6, I honestly haven't looked at 
> it yet. We only use 2.4 for the time being.

True, things are better in 2.6. For one thing, i2c-proc has been renamed to
i2c_sensor, so the name really reflects what it is meant for. And the sysfs
interface files do not have "sensors" in their name anymore, so it's more
neutral. It might not be perfect yet but it moved toward the right direction
for sure.

OTOH you have to understand that such changes are too big to be ported back to
the 2.4 kernel now. It's simply too late.

> I will do my best to provide as much as possible. It may take a 
> little while, though. Spare time is a scarce resource!

Take your time. We are in no hurry, and I prefer a clean patch in a few
months, requiring little to no work from me, to something quick and dirty
right now ;)

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
