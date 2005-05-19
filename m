From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <1088123812.4eat73bzgcqo@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

On Thu 24 Jun 2004 03:22:06 AM CDT Jean Delvare <khali@linux-fr.org> said:
> OK, just took a look. You have a Super-I/O for sure, it actually has the
> ID of a PC87366, so I guess it has to be a PC87366, but I admit that the
> readings look dead broken.
> The fans logical device isn't enable at all, so this is no surprise that
> you don't have fan readings. The driver cannot handle a device which
> has been disabled by hardware/bios. For now, I invite you do ignore all
> fan readings through /etc/sensors.conf. We may try to (manually)
> forcibly enable this logical device later, but most likely the chip
> isn't wired properly to support fans so it won't help.

There are no fan headers on the net4801 board at all, so this is not much of a
concern (for me, at least).

> Most voltage channels seem to be disabled. You should try passing init=2
> or init=3 to the module as you load it, so that it forcibly enables
> them. Maybe you'll get readings after that.

I seem to get the same results with init=2 or init=3.

> Still, internal channels
> seem to read twice as high as they should. I suspect that the chip is
> using an external Vref with a non-standard value. Please recompile the
> driver with DEBUG enable, and then watch dmesg or /var/log/* as you load
> the driver. It should dump a number of valuable information.

pc87360.o version 2.8.8-CVS (2004xxxx)
pc87360.o: device 0x09 not activated
Using external reference voltage

Should I see more than this?

> One possibility that could explain it all would be that the chip is
> configured to use an external Vref but that Vref wouldn't actually
> exist. In that case, forcing the chip to use the internal Vref instead
> could help.

Looking at the debug output, it does look like it's using the external vref...
how do I force it to use the internal?

> The last three dumps you provided (with 0xff everywhere) are not
> relevant. The addresses used by the chip are system-dependant, so you
> dumped addresses that do not match your chip.
>
> Please provide the output of the following dumps:
>
> isadump -f 0x6620
> isadump -f 0x6640

Sure (per your 2nd reply, I'm including the revised commands)...

# isadump -f 0x6620 16
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 1f 00 02 0d 00 00 ff 00 ff 00

# isadump -f 0x6640 16
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 1f 00 00 00 00 00 00 00 02 02 83 80 7f c9 7f 00

> Thanks,
> Jean Delvare

Thank you,

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
