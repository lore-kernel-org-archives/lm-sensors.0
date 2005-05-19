From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: 24rf08 update
Message-Id: <3D717733.227ED638@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

great news,
I reproduced the 24rf08 corruption on a PIIX4 and have a tentative fix.

The eeprom (which, as a refresher, looks like a standard 24c08 eeprom
at addresses 0x54 - 0x57 with an additional control bank at 0x5c)
is getting corrupted by sensors-detect.

After the detection with a quick write, it gets probed with the
detection routines 10 times (3 LM78 variants, 6 w83781d variants, and
eeprom).
The first one of these (LM78) reads location 0x48.

Unlike any other eeprom we've seen, a quick write is not benign
for these eeproms - it takes it as a start of a write.
So the following read of chip 0x54 at location 0x48 completes the write
-
and location 0xa8 (= 0x54 << 1) gets 0x48 written to it.

And so there are 4 corruptions total:
- at bank 0x54, 0x48 is written to location 0xa8;
- at bank 0x55, 0x48 is written to location 0xaa;
- at bank 0x56, 0x48 is written to location 0xac;
- at bank 0x57, 0x48 is written to location 0xae.

There is no corruption at bank 0x5c.

If I take out the LM78 and W83781D probes (these chips are most
unlikely to be at these locations anyway, should probably fix this)
then the eeprom probe corrupts the chip in the same locations, writing
0x00.
So any read (from any chip!) after a quick write corrupts the chip.

The fix is to change the quick write to "quick write" a 1 instead of a
0;
this works; it presumably makes the 24RF08 take it as the start of a
read instead of 
a write. I guess this should be safer in general. It still works
on the machines I've tried.

I did try putting a 2 second delay between the quick write and the
detection
routine - didn't help.

I also repeatedly tried the following things to see if they would
corrupt the chip,
nothing did - i2cdetect (which also uses quick write with a 0!),
i2cdump, 
eeprom, w83781d.

I'll check in the change to sensors-detect, would you please try it and
see if
it still works for your chips.

mds
