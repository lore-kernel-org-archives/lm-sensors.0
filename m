From: cat@zip.com.au (CaT)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Sensors whackyness under 2.6.x
Message-Id: <20030828022030.GB636@zip.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815110924.GC501@zip.com.au>
In-Reply-To: <20030815110924.GC501@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Aug 15, 2003 at 02:34:53PM +0200, Jean Delvare wrote:
> 
> > Well I just wanted to report a problem I'm having with the sensors
> > code. I've done some debugging work to track it down and this is
> > best found in the following threads:
> > 
> > http://marc.theaimsgroup.com/?t5826046600003&r=1&w=2
> > http://marc.theaimsgroup.com/?t5845678400003&r=1&w=2
> > 
> > There's a bit of info there so I hope noone minds me linking
> > to those threads rather then retyping everything. As always
> > I'm happy to answer questions or do any required debugging.
> 
> Oh. Now I remember you ;) The second thread made it to the list already.

Yaay! :)

> But nobody took the time to handle it. So you are well inspired to wake
> us up. Let's see what we can do for you now.

Thanks. My paologies though for taking so long to reply to you. Every
time I remembered I had to do sensors testing it was the wrong moment. I
was either nowhere near the laptop or doing something else that I could
not interrupt there and then. :/


> I don't get you. The adm1021 module is an i2c-only driver. It doesn't
> work with the isa bus. So, what do you mean with "If I compile ISA in
> and use it for the data"? I can't believe you get any result using only
> the i2c-core, i2c-proc, i2c-isa and adm1021 modules.

It gets whackier. I get the same results from both 2.4 and 2.6 now and
they're different to before! Joy.

Everything works fine at first under both. No immediate slowdown. No
dmesg being filled with whackyness. Nothing. I then put the system under
load by compiling the kernel and the slowdown hit.

Under 2.4 I'd lose the odd keystroke and things would go very slowly. A
subsecond beep would wind up taking multiple seconds. Under 2.6 I'd get
multiple char repeats and lost chars and things again would go slowly.

rmmoding the modules under either version did not help. The sensors data
was whacky too. here's one snapshot:

thmc10-i2c-0-4d
Adapter: SMBus PIIX4 adapter at 2180
Algorithm: Non-I2C SMBus adapter
Board:      -101?C  (min =  +20?C, max = -101?C)
CPU:        -101?C  (min =  +20?C, max = -101?C)ALARM (LOW,HIGH)

Before this one the CPU temp was 61degC but the laptop fan wasn't working
overtime and I was not burning my fingers on the kboard.

Running it again showed CPU at 64degC and the thmc line turned into max
something or other. I tried to get a snapshot but I had to turn my laptop
off to recover and the file did not make it out of the cache.

> What if you load i2c-piix4 first, and then adm1021? If the slowdowns
> appear before loading adm1021, then the i2c-piix4 driver is at fault,
> else either adm1021 or i2c-piix4 is at fault.

I did it in the order above. Slowdowns did not happen till I loaded
the system.

> I would like you to try with i2c-CVS and lm_sensors-CVS. We made a
> change to the i2c-piix4 driver recently that could influence your
> problem. Download instructions are to be found here:
> http://secure.netroedge.com/~lm78/download.html#cvs

Do you still want me to do this?

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
