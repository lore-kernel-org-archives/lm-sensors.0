From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Aug 2013 10:02:01 +0000
Subject: Re: [lm-sensors] Trouble with sensors-detect probing ASUS 1015E-DS03 laptop
Message-Id: <20130829120201.26c01289@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
In-Reply-To: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Larry,

On Sat, 24 Aug 2013 19:32:41 -0500, Larry Lade wrote:
> I wanted to report an alarming issue running sensors-detect on my new
> (Ubuntu 12.04 out of the box!) laptop.
> (...)
> At some point during one of these scans, there's a flash and SOMETHING
> happens to the built-in LCD screen. I noticed it's as though the gamma
> was all out of whack, the colors were washed out, and dithering
> becomes notable everywhere. (Bad even for an 18-bit LCD.) Display
> looks fine on an LCD connected by VGA port.
> 
> This change survived the re-install of the operating system.
> 
> I was getting desperate, thinking I had just zapped something and
> voided the hardware, so I ran sensors-detect again. Probing either of
> the two above adapters (they both seem to reference the same bit of
> hardware) seemed to toggle something, restoring or corrupting the
> screen quality.
> 
> Or at least it did. It seems to have it stuck in "ugly" mode again,
> and nothing on the display toggles any more when I run sensors-detect
> any more. Is anyone able to help?

I'm very sorry about this. As Guenter said, we have changed the code
meanwhile to skip graphics adapters by default, and I can only urge
Linux distributions to include that change.

You may try to ask the hardware vendor for help. After all they did
ship the software which broke the laptop, right? Even though they did
not write it. I am willing to help but the problem is that it will be
very difficult, if not impossible, to do so without intimate knowledge
of the hardware, which only the vendor can provide. I would be very
happy to cooperate with Asus on that matter if they want to. Only Asus
knows exactly which I2C chips are connected to the graphics chip, at
what address, and if any of them could be responsible for what you
observe.

Meanwhile, the first thing to try here is:
* Shut down the machine.
* Remove the battery.
* Unplug the AC adapter.
* Let the laptop rest that way for a moment, at least 10 minutes.
* Plug everything back and start the machine.

This has restored systems for me and others in the past, I can only
hope it helps for you as well.

If it does not, then if the laptop is new, I think I would just play
the support/warranty card.

You can also try changing the gamma setting with xrandr.

> The LCD seems to be an AUO B101XTN01 (as reported by the EDID)
> http://www.panelook.com/B101XTN01.0_AUO_10.1_LCM_parameter_19387.html
> 
> lm-sensors 1:3.3.1-2ubuntu1
> 
> linux 3.2.0-52-generic #78-Ubuntu SMP x86_64
> 
> 
> $ sudo get-edid | parse-edid:
> 
>     # EDID version 1 revision 4
> Section "Monitor"
>     # Block type: 2:0 3:f
>     # Block type: 2:0 3:fe
>     # Block type: 2:0 3:fe
>     Identifier "AUO:dc11"
>     VendorName "AUO"
>     ModelName "AUO:dc11"
>     # Block type: 2:0 3:f
>     # Block type: 2:0 3:fe
>     # Block type: 2:0 3:fe
>     # DPMS capabilities: Active off:no  Suspend:no  Standby:no
> 
>     Mode     "1366x768"    # vfreq 60.041Hz, hfreq 47.913kHz
>         DotClock    76.660000
>         HTimings    1366 1404 1426 1600
>         VTimings    768 771 777 798
>         Flags    "-HSync" "-VSync"
>     EndMode
>     # Block type: 2:0 3:f
>     # Block type: 2:0 3:fe
>     # Block type: 2:0 3:fe
> EndSection
> 
> 
> $ sudo i2cdetect 5
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-5.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4f
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> 
> $ sudo i2cdump 5 0x4f
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-5, address 0x4f, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

No idea what this is, it might as well be the "chip" which caused the
problem, or maybe it is completely unrelated.

> $ sudo i2cdump 5 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-5, address 0x50, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 ff ff ff ff ff ff 00 06 af dc 11 00 00 00 00    ........????....
> 10: 00 16 01 04 90 16 0d 78 02 bb f5 94 55 54 90 27    .??????x????UT?'
> 20: 23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01    #PT...??????????
> 30: 01 01 01 01 01 01 f2 1d 56 ea 50 00 1e 30 26 16    ????????V?P.?0&?
> 40: 36 00 de 7d 00 00 00 18 00 00 00 0f 00 00 00 00    6.?}...?...?....
> 50: 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41    ......... ...?.A
> 60: 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe    UO?         ...?
> 70: 00 42 31 30 31 58 54 4e 30 31 2e 31 20 0a 00 dd    .B101XTN01.1 ?.?
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

This is the EEPROM with the EDID monitor information. Should be read
only. If it was somehow corrupted then X should complain repeatedly
about it (it does complain every now and then on many systems due to
occasional I2C bus timeouts, but I would expect it to be much louder if
the EEPROM is corrupted.)

That being said the above dump does NOT look corrupted to me, at least
the checksum is correct and the available data looks good to me -
except for the claim that the display is monochrome and doesn't support
DPMS.

> dmesg currently dumping this during probe of 0x4f:
> [  783.847244] i2c i2c-6: sendbytes: NAK bailout.
> [  783.848321] i2c i2c-6: sendbytes: NAK bailout.
> [  783.849399] i2c i2c-6: sendbytes: NAK bailout.
> [  783.850497] i2c i2c-6: sendbytes: NAK bailout.
> [  783.851666] i2c i2c-6: sendbytes: NAK bailout.
> [  783.852746] i2c i2c-6: sendbytes: NAK bailout.
> [  783.853827] i2c i2c-6: sendbytes: NAK bailout.
> [  783.854908] i2c i2c-6: sendbytes: NAK bailout.
> [  783.855988] i2c i2c-6: sendbytes: NAK bailout.
> [  783.857065] i2c i2c-6: sendbytes: NAK bailout.
> [  783.858150] i2c i2c-6: sendbytes: NAK bailout.
> [  783.859230] i2c i2c-6: sendbytes: NAK bailout.
> [  783.860306] i2c i2c-6: sendbytes: NAK bailout.
> [  783.861383] i2c i2c-6: sendbytes: NAK bailout.

This suggests that the chip in question does not like the format of the
messages used by the probe / dump. This explains the XX's but is not
necessarily bad. I've seen a lot of these in the past on various
systems, without any hardware issue resulting from that.

Note that the messages are for i2c bus 6 while your dumps where on i2c
bus 5.

One thing which comes to my mind is DCC/CI: the ability to control the
monitor settings through the OS rather than by pressing physical
buttons on the screen. Your observations could be the result of
(uncontrolled) DCC/CI commands having been sent to the screen as part
of the sensors detection.

Unfortunately I am not aware of any recent Linux tool that can send
DCC/CI commands. The projects I found are old and look abandoned:
  http://jaffar.cs.msu.su/oleg/ddcci/
  http://ddccontrol.sourceforge.net/
You may still want to give them a try.

AFAIK DCC/CI operates on I2C address 0x37. Can you remember if you did
see anything respond to that address on one of the graphics chip I2C
buses during the initial run of sensors-detect?

http://www.boichat.ch/nicolas/ddcci/specs.html is a good read as well
but unfortunately most commands appear to be vendor specific, plus I
wouldn't even know what setting needs to be tweaked in your case, as we
don't know what the settings were before the problem happened.

But it is also possible that your problem has nothing to do with DCC/CI
and sensors-detect touched a completely different chip which is
controlling some voltages or clock frequencies and what you are seeing
is the result of this now incorrect voltage or frequency.

Good luck,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
