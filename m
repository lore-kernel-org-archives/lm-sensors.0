From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[Please CC: the mailing list on reply]

Hi Andrew,

>I'm using a Soekris net4801 board with the built in pc87366 along with the
>driver from yesterday's CVS snapshot, and I'm seeing some strange readings.
>I've looked over some mailing list posts, and have attached the output of 
>some of the commands you have recommended in the past. Any insight would be
>greatly appreciated. Thanks.
>
>Here's a link describing this board:
>http://www.soekris.com/net4801.htm

OK, just took a look. You have a Super-I/O for sure, it actually has the
ID of a PC87366, so I guess it has to be a PC87366, but I admit that the
readings look dead broken.

The fans logical device isn't enable at all, so this is no surprise that
you don't have fan readings. The driver cannot handle a device which
has been disabled by hardware/bios. For now, I invite you do ignore all
fan readings through /etc/sensors.conf. We may try to (manually)
forcibly enable this logical device later, but most likely the chip
isn't wired properly to support fans so it won't help.

Most voltage channels seem to be disabled. You should try passing init=2
or init=3 to the module as you load it, so that it forcibly enables
them. Maybe you'll get readings after that. Still, internal channels
seem to read twice as high as they should. I suspect that the chip is
using an external Vref with a non-standard value. Please recompile the
driver with DEBUG enable, and then watch dmesg or /var/log/* as you load
the driver. It should dump a number of valuable information.

As for temperatures, I'm definitely surprised that temp3 isn't correct,
since it is the internal temperature of the PC87366, so it has to be
present and valid. That's definitely strange.

One possibility that could explain it all would be that the chip is
configured to use an external Vref but that Vref wouldn't actually
exist. In that case, forcing the chip to use the internal Vref instead
could help.

The last three dumps you provided (with 0xff everywhere) are not
relevant. The addresses used by the chip are system-dependant, so you
dumped addresses that do not match your chip.

Please provide the output of the following dumps:

isadump -f 0x6620
isadump -f 0x6640

These, together with what will show in the logs when the driver has DEBUG
enabled, will hopefully this will enlighten us on what the problem is,
and how it can be solved.

Thanks,
Jean Delvare
