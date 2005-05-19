From: jargon@hurg.org (Johannes =?utf-8?B?V2Vpw59s?=)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Ticket #1376
Message-Id: <20030824010645.GA8531@hurg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030817003245.GA12961@hurg.org>
In-Reply-To: <20030817003245.GA12961@hurg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2003-08-23 21:23:03, Jean Delvare wrote:
> > I don't have applied the GRSEC patch to my kernel (I've downloaded
> > the kernel source from kernel.org).
> > 
> > I upgraded to 2.8.0 (after removing ALL 2.7.0 remains), but the error
> > is still there.
> 
> OK, so the problem is still there :( I thought it was fixed.
> 
> Why do you have the adm1021 module loaded? Doesn't seem to be used. Has
> sensors-detect been suggesting you should load it? Likewise, I don't
> think i2c-viapro is used (unless you partly hid the output of sensors).
> Does unloading all (i2c-related) modules and reload only the ones you
> need solve your problem? (unlikely)

Yes, sensors-detect has suggested it ... here is my /etc/modules
(after running sensors-detect 2.8.0):

--- snip ---
# I2C adapter drivers
i2c-viapro
i2c-isa

# I2C chip drivers
adm1021
eeprom
w83781d
--- snip ---

I don't know if viapro is used, but it's in the "i2c-core" list

# lsmod | grep i2c
i2c-proc    6644 1 [w83781d eeprom adm1021]
i2c-isa      724 0 (unused)
i2c-viapro  3468 0 (unused)
i2c-core   15556 0 [w83781d eeprom adm1021 i2c-proc i2c-isa i2c-viapro]

> Could you try writing to the files by yourself? For example, move to
> /proc/sys/dev/sensors/w83697hf-isa-0290 and do:
> echo "50 60" > temp1
> Then read back the values from temp1. Does it work?

yes, it works!

# echo "30 40" > temp1
# cat temp1
30.0 40.0 32.0
# echo "50 60" > temp1
# cat temp1
50.0 60.0 32.0

> In your original ticket, you wrote:
> > cd /proc/sys/dev/sensors
> > cat chips
> 256     w83697hf-isa-029
> 
> Is it really "w83697hf-isa-029" or is the trailing "0" missing in your
> copy only?

yes, it's "w83697hf-isa-0290", I forgot the trailing "0" ... sorry

# cat /proc/sys/dev/sensors/chips
256     eeprom-i2c-0-50
257     w83697hf-isa-0290

> I hope we'll find a solution.

Thank you for your efforts!
(and sorry for my bad English :-) )

-- 
cu,
Johannes Wei?l
