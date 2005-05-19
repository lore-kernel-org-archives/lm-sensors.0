From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: update_lock
Message-Id: <1080722747.406a853b2ca2f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Mark M. Hoffman:

> In my opinion, the "cached update" scheme serves only one purpose,
> and it's not speed.  Internally, some of these sensor chips actually
> pause the sampling and conversion in order to answer an i2c/smbus
> request.

You're correct, that's something I tend to forget.

> If we didn't have this scheme in place and some user did this:
> 
> 	while [ true ]; do
> 		cat /sys/bus/i2c/devices/xyz/temp1_in > /dev/null
> 	done
> 
> ... the value would in fact never change.  But worse, it could also
> halt the alarms, QFAN, smartfan, or whatever - i.e. a DOS attack
> against the hardware.  Keep in mind that the proc/sysfs files are
> world readable.

That's right. BTW, Aurelien Jarno and I decided to get rid of the
caching mechanism in the pcf8574 and pcf8591 drivers as we ported them
to 2.6. It seemed to be a problem not being able to get the values in
real-time for such devices, since they are used in very particular
conditions. I don't think it is a problem because such devices are not
present on motherboards and I don't expect many people to use these
drivers. And these devices don't seem to stop when you read from them
(actually it's the contrary, they sample the inputs as you read them.

Aurelien, can you confirm this?

That said there's still a problem. The pcf* drivers accept all chips
within their address ranges, because the chips are plain undetectable.
So if someone was to load them and they actually try to drive a
hardware monitoring chip instead, continuous readings from the sysfs
files could prevent the chip from working (left apart the fact that the
driver is likely to confuse the chip even without continuously reading,
but there's nothing we can do there).

Maybe we could add a security warning in the kernel configuration help
text for these two drivers? (something like "This driver is potentially
dangerous if used on inappropriate hardware.  Including it into the
kernel is discouraged, module is prefered.  Do not load this module
unless you know you need it.")

> All that said, I think that any further optimization of the update
> routine for speed is just added complexity for little or no gain.
> The data being reported by these drivers are not real-time critical
> w.r.t. their present application as PC hardware monitors. And in my
> experience, the precision of PC hardware sensors is questionable at
> best anyway.

I have to agree here too (this becomes anoying, can't you stop being
right? ;)). I like simple things too, especially since "our" code is
likely to be maintained by others in the future. But I have one
objection though.

Philip Pokorny's approach of splitting the registers in two sets doesn't
add much complexity IMHO. One more jiffies-value member in the data
structure, and two ifs instead of one in the update function, that's
not a high price to pay. OTOH it tends to clarify the different nature
of these registers. Not only it speeds up the update, but it also
limits the race conditions we are discussing these days, and, more
importantly, it reduces the usage of the i2c bus (this obviously
doesn't matter for ISA-only chips). I am much more sensible to this
problem since I wrote the w83l785ts driver, since in various cases,
reading from its registers collides with the BIOS doing the same. I had
to implement some tweaks in this driver to workaround the problem. We
are lucky that this chip only has two registers, and read-only. For
this chip driver at least, I want to limit accesses to the i2c bus (so
I plan to apply Philip Pokorny's method).

More on that in another answer.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
