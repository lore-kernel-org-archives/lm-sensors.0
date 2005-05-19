From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <200406250807.i5P87vQk005063@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>There are no fan headers on the net4801 board at all, so this is not much
>of a concern (for me, at least).

OK, and this explains why the device is disabled.

>> Most voltage channels seem to be disabled. You should try passing init=2
>> or init=3 to the module as you load it, so that it forcibly enables
>> them. Maybe you'll get readings after that.
>
>I seem to get the same results with init=2 or init=3.

Strange. I'd have expected changes, such as voltage readings to come up,
or Vcore limits to show.

How did you pass the parameter?

>> Still, internal channels
>> seem to read twice as high as they should. I suspect that the chip is
>> using an external Vref with a non-standard value. Please recompile the
>> driver with DEBUG enable, and then watch dmesg or /var/log/* as you load
>> the driver. It should dump a number of valuable information.
>
>pc87360.o version 2.8.8-CVS (2004xxxx)
>pc87360.o: device 0x09 not activated
>Using external reference voltage
>
>Should I see more than this?

I'd have expected messages like "Forcibly enabling in0". Same for in2
and in3.

Other channels are admittedly already enabled (else limits would read 0).
Logical devices themselves are enabled too, according to the dumps below.

>> One possibility that could explain it all would be that the chip is
>> configured to use an external Vref but that Vref wouldn't actually
>> exist. In that case, forcing the chip to use the internal Vref instead
>> could help.
>
>Looking at the debug output, it does look like it's using the external
>vref... how do I force it to use the internal?

First unload the pc87360 driver.

isaset -f 0x6628 0x03
isaset -f 0x6648 0x03

The reload the driver. But read below before.

>> Please provide the output of the following dumps:
>>
>> isadump -f 0x6620
>> isadump -f 0x6640
>
>Sure (per your 2nd reply, I'm including the revised commands)...
>
># isadump -f 0x6620 16
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>00: 00 00 00 00 00 00 1f 00 02 0d 00 00 ff 00 ff 00
>
># isadump -f 0x6640 16
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>00: 1f 00 00 00 00 00 00 00 02 02 83 80 7f c9 7f 00

OK... I would like you to run (in an empty directory) the attached script
on that machine. I'll dump the whole chip contents (all channels on all
devices) and generate a tarball from all individual files.

Please do that *before* you force the chip to use an internal voltage
reference. And possibly a second time *after* doing so if you feel like
it.

Let me know if you have any change after switching to internal reference.

BTW, do you know whether your board is using thermistor-based or
thermal-diode-based temperature measurements?

Thanks,
Jean Delvare
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dump-pc87366.sh
Type: application/octet-stream
Size: 756 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040625/c3b9c108/dump-pc87366.obj
