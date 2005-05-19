From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Ticket comments
Message-Id: <20030618044844.GF6532@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

So I took a look at the support tickets page and *wow* you guys
must be swamped.  Is there any way to route tickets to me for
i2c-sis645 only (for now)?  I have no idea what the backend
interface can do.

Anyway, here are some comments for tickets that I saw when I
searched on "sis645", "bach", and "asb100"...

#1293 - I'm sorry to say I don't believe this user's running
kernel config matches the one against which sensors were
built.  The two offending undefined symbols are clearly
wrapped with #ifdef CONFIG_HOTPLUG in the code.

#1237 - Looks like the same problem to me, at least w.r.t.
i2c-sis645.  I don't know about the rest though.

#1133, #1161 - I was able to confirm with sajmmiller@yahoo.com
that his suggested workaround - load i2c-sis645 *before* sis900 -
does indeed solve the problem.  I suspect that the real solution
is to move the magic PCI space bit-frobbing into pci/quirks.c
like I did for 2.5; I can't prove it because I don't have the
builtin network device and I haven't yet found someone who does
who is willing to boot 2.5.

#1108, 1124 - The Asus "BACH" chip aka asb100 is I2C bus only.
These two users either have a currently unsupported I2C bus
or (in the case of the P4PE user) an Intel chipset for which
Asus has lovingly hidden the I2C bus PCI device w/ broken BIOS.
A fix for this was mentioned here:

http://archives.andrew.net.au/lm-sensors/msg02724.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
