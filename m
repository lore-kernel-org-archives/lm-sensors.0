From: bjorn@mork.no (=?iso-8859-1?q?Bj=F8rn_Mork?=)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: SOLVED: Ticket #1409
Message-Id: <hvd6dewr71.fsf@rasputin.ws.nextra.no>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

>> I wonder however, would it be possible to include a refined version of
>> the address detection code in the module?  I am willing to try to
>> write it myself, but I won't do it unless I know it has some remote
>> possibility of being included.
>
> Thanks a lot for reporting your findings. It will hopefully help some
> other folks someday.
>
> Here are the possibilities:
>
> 1* Add address 0x0d00 to sensors-detect.
> 2* Add address 0x0d00 to it87.
> 3* Add your code to it87.
> 4* Add what you found to the it87 doc.
> 5* Distribute your program into lm_sensors.

Maybe 4 or 1 is a good start?  I don't think 3 and 5 makes much sense
unless Asus or some other manufacturer really use other addresses than
0x290 and 0xd00. But that's of course difficult to detect without
providing 3 or 5...

> I'm not easy with ISA chips, since I only wrote I2C chip drivers so far.
> I know that ISA is typically a little bit more dangerous, but I don't
> know to which extent. I'd like to hear other people about that. 

I know linux-irda does similar things, but they kind of have to
because they must enable the irda function on the Super IO chips.
This doesn't seem to be necessary for enviroment control, probably
because it's enabled by the BIOS.

> I don't
> even understand what you code does (or, more precisely, how it does it)
> but it looks interesting. 

A Super IO chip typically uses two ports for configuration.  These
ports provide access to the internal registers on the chip.  On an
IT8712, these ports are fixed at 0x2e (address) and 0x2f (data) or
0x4e and 0x4f according to the data sheet.  The 0x2e address is
special since the magic key is always written to this port.

What the program does is
1) writes a magic key (0x87,0x01,0x55,0x55) to the IT8712 address port
   (0x2e).  This puts the chip in config mode (aka "MB PnP mode")
2) reads the chip id (0x8712) from registers 0x20 and 0x21.  This
   could be used to bail out if there isn't an IT8712F there, but then
   we've already written 0x87,0x01,0x55,0x55,0x20,0x21 to 0x2e, which
   I assume might be dangerous anyway...
3) changes to the "Environment Controller" Logical Device by writing 4
   to register 7.  This switches register bank for the next steps.
4) reads registers 0x60, 0x61 and 0x30, which contain i2c port address
   MSB and LSB, and Environment Controller Activate respectively
   (didn't really need the last one, but I wanted to make sure it was
   enabled).
5) sets bit 1 in register 2 to exit cleanly from config mode

> Is there a chance we could use it for
> something less specific than your own case? (in other words, how
> A7N8X-VM specific is it? how it8712F-specific?)

It is very IT8712F-specific.  I assume the other IT87-chips can be
handled by the same code, just with different chip ids in step 2, but
I would have to read the data sheets to be sure.

I also expect other Super IO chipsets to have the same detection
possibilities.  This is basically how they are detected by some (all?)
of the linux-irda drivers.  Take a look at the probe function in e.g.
linux/drivers/net/irda/smc-ircc.c.

> I really don't know wether it's better to just add the new address to
> the list, or include your detection code in some way.

I don't know either.  Maybe add a comment to the it87 docs first and
see if this is a common problem?  Something you could keep in mind if
users keep complaining that sensors-detect can't find the enviroment
controller and nothing shows up in the i2c scans.


Bj?rn
