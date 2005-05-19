From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: getting 2.8.7 or better for 2.6 kernel?
Message-Id: <hxy89AMt.1098776180.3880430.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4178A7BD.9070607@coplanar.net>
In-Reply-To: <4178A7BD.9070607@coplanar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jeremy,

>Well the BIOS has temp., voltage and fan readings, and there are no
>other sensor chips on the board.

Impossible. You said you had a PC87364 Super-I/O chip. This model has fan
monitoring and control, but no temperature nor voltage sensors. If the
BIOS provides these, then you got to have an additional chip somewhere.
As it goes, I wouldn't even be surprised that the fan monitoring and
control part of the PC87364 is not used at all on your system.

>> You may still want to try to manually enable it, and see if the driver
>> then reports anything useful. The commands to do that are (in order):
>>
>> isaset 0x2e 0x2f 7 9
>> isaset 0x2e 0x2f 0x30 1 1
>
>What is the last trailing one for?

Masking of the written value. It isn't strictly necessary since the
other bits at address 0x30 are supposedly unused, but it's good
practice to use the mask parameter when writing to a bitfield. This
requires isaset from CVS though.

Although note that the two commands are not independant. The first one
selects the logical device 9, the second write to a register in this
logical device.

>Now, the modprobe command gives:
>pc87360: Base address not set for device 0x09

Which further suggests that this logical device isn't meant to be used
on your system, IMHO.

[...next post...]

>Well I pulled out the data sheet for pc87364, seems the device 9 index
>0x60 and 0x61 are "base address". I'm not sure what those are... is
>that an ISA decode address? Any chance it will work if I set it to any
>random unused address?

Correct. Looks like you're more knowledged and curious than the average
user, which is a good thing :)

[...next post...]

>Well setting base address to 0x0380 lets the module load. Not much
>happens yet though, next i'll update the patch to the last one you sent.
>
>so i added
>
>isaset 0x2e 0x2f 0x60 0x03
>isaset 0x2e 0x2f 0x61 0x80

I'd suggest you set the logical device to 9 again before doing this. You
don't know if some other program (or the BIOS) could have changed the
logical device since you last selected it.

Now, what I expect is that you will get 0 RPM readings from the supposed
fans, and you won't be able to change the fans speed either, simply
because the PC87364 chip isn't the one you fans are wired to. I may be
wrong though...

Could also be that individual fan channels need to be enabled on an
per-channel basis. If you have the dahasheet handy, look at registers
0xF0-0xF2, you may want to change bits there. Be extremely careful
though, especially with polarity inversion bits. If fans are really
wired to the PC87364, you will want to keep you case open and have a
look at the fans so as to make sure you won't plain stop them.

You should enable I2C chip debugging in your kernel configuration, so
that the driver tells you more about how it thinks the chip is
configures.

Let us know if you get anywhere! I'd also be interested in a complete
output log of sensors-detect. I cannot believe you have no other
hardware monitoring chip on-board.

Jean
