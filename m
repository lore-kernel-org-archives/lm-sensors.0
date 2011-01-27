From: Phillip Susi <psusi@cfl.rr.com>
Date: Thu, 27 Jan 2011 03:16:46 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <4D40E39E.4030406@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

( moved from linux-i2c to lm-sensors )

> No, the device isn't even listed on lm-sensors.org's wiki, I am not
> aware of anyone working on it.
>
> The datasheet isn't available for download from Nuvoton, but can
> probably be requested from them.

I signed up for an account and downloaded the datasheet today.  I'll 
take a look at some of the other drivers that are probably quite similar 
and see if I can modify one to work on this chip.

>> Then again, I wonder if it might be better to come up with an SSDT I can
>> dynamically load to define the ACPI FAN and TZ objects and let the
>> regular acpi driver manage it.
>
> What an horrid idea. The ACPI FAN and TZ interfaces are very limited.
> If the ACPI BIOS doesn't block access to the NCT6776F's I/O ports,
> you'll be much better with a native driver.

Why is this a horrid idea?  It seems like the idea is that ACPI systems 
are supposed to provide the TZ and FAN interfaces so that the OS can 
monitor the temperature and fan speed and get automatic fan speed 
control, or choose to override it, all without the bother of hardware 
specific drivers.  That seems good to me.

Also here is the DIMM SPD dump that decode-dimms does not like:

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 93 10 0b 02 02 11 00 09 03 52 01 08 0f 00 1e 00    ??????.??R???.?.
10: 69 78 69 3c 69 10 f0 8c 70 03 3c 3c 00 f0 03 04    ixi<i???p?<<.???
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 01    ..............??
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 84 b0 02 00 00 00 00 00 00 3f 58    .....???......?X
80: 4f 43 5a 33 50 31 36 30 30 43 36 4c 56 32 47 20    OCZ3P1600C6LV2G
90: 20 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00      ..............
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
