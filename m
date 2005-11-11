From: hwang@circadiant.com (Howard Wang)
Date: Fri, 11 Nov 2005 00:43:30 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <24EB6743805F45478251E18DEBF3F6BE8133FA@csserver.circadiant.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I got the scx200_i2c driver working on the second i2c bus, which is acb1,
however, when I use i2cset and i2cdump, it seems that only 128 bytes is
accessible, it repeats after 128 bytes, while my device is:
microchip 24AA128 which is 128K bits (16K bytes). see attached log:
in fact, I just set the first 10 bytes and it repeats after 128 bytes.

any suggestions ?

thanks

howard


*** ***
/usr/test # i2cdump -y 0 0x57
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 43 69 72 ff 45 45 50 52 4f 4d ff ff ff ff ff 42    Cir.EEPROM.....B
10: ff ff ff ff ff ff 01 ff ff ff ff ff ff ff ff ff    ......?.........
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 43 69 72 ff 45 45 50 52 4f 4d ff ff ff ff ff 42    Cir.EEPROM.....B
90: ff ff ff ff ff ff 01 ff ff ff ff ff ff ff ff ff    ......?.........
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

*** ***



-----Original Message-----
From:	Rudolf Marek [mailto:r.marek@sh.cvut.cz]
Sent:	Tue 11/8/2005 10:47 AM
To:	Howard Wang
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] i2c -dev and i2c bus driver

> yes, that's what I loaded after booing and using i2c-dev driver to talk to
> our i2c device, for the devices connnected to the ACB 2 of superIO from the
> microporcessor, every thing works. however, for the device, connected to
> ACB 1 of superIO, I won't be able to talk to them.

Hmm bad is that I dont know the hardware.
But from the driver i can see:


         for (i = 0; i < MAX_DEVICES; ++i) {
                if (base[i] > 0)
                        rc = scx200_acb_create(base[i], i);
        }

And there are two base defined.
So this could create two busses.

When you modprobe i2c-dev and the scx driver you should see
in

i2cdump -l

Listed two ACB busses
Do you see them?

If so I would suggest:

1) plug your device to ACB 2 where it works
   do: i2cdetect (put acb2 bus number here)
       i2cdump (put acb2 bus number here) 0xyourdeviceaddr

2) repeat with plugged to ACB1

Please post results here. Also, please point me to some documenattion of ACCESS bus... I'm really very short with my time...

Thanks
Regards
Rudolf



