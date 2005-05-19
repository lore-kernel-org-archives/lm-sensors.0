From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: From Ticket 1972, Gigabyte 7dpxdw+, making it work correctly
Message-Id: <20050508140154.415f7a5e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504174827.11115a83.dcb@pa.net>
In-Reply-To: <20050504174827.11115a83.dcb@pa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Douglas,

> This is from Ticket #1972, Gigabyte 7dpxdw+, making it work correctly
> 
> > the lm90 chip, driver, and userspace supports two temperatures.  are
> > you saying that only one is reported or only one is correct?  If
> > only one is reported check that the other is not set to ignore in
> > /etc/sensors.conf. If incorrect you can try adjusting with a compute
> > line in sensors.conf. If you need more help follow up by email, ref.
> > your ticket number. MDS 5/4/05
> 
> Sorry, I should have been more precise.  This is a duallie board, so
> the LM90 needs to support TWO external temperatures, instead of the
> usual one, along with the usual on-the-chip sensor.  That is what is
> so special (or odd) about this board.

First, I invite you to read the following thread:
http://archives.andrew.net.au/lm-sensors/msg28081.html

Your board supposedly uses a Philips PCA9540 chip to switch from one
LM90 to the other one (there are two of these on the board). We have no
driver for it in Linux 2.6, only Linux 2.4 - and even there the driver
plain sucks. You may get some results with i2cset. First look for a chip
at 0x70 on the smbus (use i2cdetect), then use "i2cset N 0x70 4 4" or
"i2cset N 0x70 5 5" to select the first or second LM90 (where N is the
bus number, supposedly 1 in your case).

Blame Gigabyte for the poor design. They really could have come up with
a much simpler one.

> From the w83627hf: the voltage readings are OK, the fan RPM readings
> are OK as none of my fans have tach lines and the 3 temp. readings
> are a mystery. They have nothing to do with the CPU temps.

They may be thermal sensors anywhere on the board.

> Skipping down to the lm90, I assume the M/B Temp is the "on-the-chip"
> sensor and the CPU temp is the one external temp reading that works.

Correct.

> If I stall a CPU fan this reading will rise, so this one is good.  Of
> course, it's way too high, but that's the way it shows in the BIOS and
> that's easy enough to fix anyway.  
> 
> The problem is that the lm90 should have one more external temp for
> the 2nd CPU.

In fact this is done by a second LM90 chip, as explained above.

> The website to this Windows program:
> 
> http://mbm.livewiredev.com/
> 
> The motherboard list of the above website shows the GA7 DPXDW+ with a
> LM90-1 remote and a LM90-2 remote.  Alas, the program is closed source
> so it's not much help.  The author also quit supporting this program
> so I suppose emailing him and asking how he did it wouldn't be much
> help either.

Alex van Kaam, who wrote MBM, has been working with us on this actually,
he is the one who found how the board was wired and told us how we could
handle the multiplexing. We did not properly implement support for it
out of time and motivation, but Alex has been really helpful.

-- 
Jean Delvare
