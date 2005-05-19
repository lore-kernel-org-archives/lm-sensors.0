From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040127075231.2181c498.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well, looking at the conversion formula again, this idea is not 100 %
> perfect, because it doesn't care to scale the offset value. Currently,
> the offset is 0 but there is no guarantee, that it will always be 0.

This isn't a problem. The formulae are applied *after* libsensors (or
any other program such as gkrellm) reads the value from sysfs or procfs.
For example, if you have a raw reading of 1.8V, in 2.4 it'll be stored
internally as 180, and read through procfs as 1.80. In 2.6 it'll be
stored internally as 1800 and exported through sysfs as 1800 too. But
libsensors knows about magnitudes in both cases and will read the value
as 1.80. And any formula in sensors.conf will be applied to *this*
value.

So, as you can see, it is safe to have a single formula for both
versions.

> What do you think about some further RW files
> 
> 	in_refvoltage	= 0x21
> 	in_offset0	= 0x00
> 	in_offset1	= 0x00
> 	in_offset2	= 0x00
> 	in_multiplier0	= 0x31
> 	in_multiplier1	= 0x14
> 	in_multiplier2	= 0x0a
> 
> that initally have the values of the first driver release, which were
> taken from dmidecode. The driver would then use those values and
> supply scaled values for in0, in1 and in2.

I find it more confusing than helpful. All drivers have their formula in
sensors.conf and I believe we should stick to that model. Making
something different for one driver will make third-party apps unable to
handle it correctly unless they know the trick and add chip-specific
code. Remember that our aim with 2.6 and sysfs is to be able to live
without any specific code. Readings from sysfs and sensors.conf should
be sufficent to read temperatures, voltages and fans values and
configure limits and such, with no additional details given. It's still
not perfect since a few things are not well standardized (think to
alarms for example) but that's the idea.

So I suggest you go with your formulas in sensors.conf.eg, they look
just fine to me.

> BTW: was the multiplier for temperatures changed from 100 to 1000
> around 2.6.0-test5, because gkrellm-2.1.25 uses 100 instead of 1000?

I can't remember exactly when the change was made. I remember it was
discussed and we opted for something standard enough so that it would be
OK for everyone. More likely, gkrellm changed to accomodate our
decision.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
