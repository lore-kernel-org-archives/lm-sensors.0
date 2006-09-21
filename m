From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 21 Sep 2006 10:53:59 +0000
Subject: [lm-sensors] Module(s) ALI15** not loading
Message-Id: <45126F47.8050600@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158188393.9914.5.camel@localhost.localdomain>
In-Reply-To: <1158188393.9914.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 0000:00:15.0 ISA bridge: ALi Corporation PCI to LPC Controller (rev 10)
> 00: b9 10 73 15 0f 00 00 02 10 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 73 15
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18
> 40: 00 00 00 00 3d 00 00 00 00 00 00 00 00 90 00 90
> 50: 33 00 00 fe 0d 21 01 00 00 00 00 00 80 00 00 05
> 60: d8 f8 f0 f3 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 01 73 15 00 0f 00 42 00 00 00 20 00 00 00 00
> 80: 03 50 00 00 21 0f 99 aa bb cc 00 00 ee dd 00 58
> 90: 00 00 00 00 00 00 00 00 ba 01 00 00 68 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 0e 00 02 00 00 00 de 05 00 00 00 00 00 00
> c0: 88 88 88 88 00 00 00 00 08 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 80 07 f0 00 f0 00 c7 0f 00 00 04 01 00 00

Maybe here is the answer?

What does the cat /proc/ioports say?
is there the region of 5000 ?


> 80: 03 50

Is base 5000, host enabled, iospace too. So I think it might work if
you can try following which is a bit dangerous and can lead to machine crash...

edit the i2c-ali1563.c

find this line:
       { PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1563) },
change to:
       { PCI_DEVICE(PCI_VENDOR_ID_AL, 0x1573) },

compile, install, modprobe, run sensors-detect, send us the output of
sensors-detect,

modprobe i2c-dev
i2cdetect -l
should list the busses - find one which will say ALI @ 5000, and write the
number instead of X

i2cdetect X

Send the dump to us too please.

Regards
Rudolf

