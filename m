From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <20041104012743.GB4054@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Benjamin et. al.

* Benjamin Judas <beejay@gentoo.org> [2004-11-03 20:13:31 +0100]:
(snip)

> antares /home/benni # i2cdump 1 0x2b
> No size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>   I will probe file /dev/i2c-1, address 0x2b, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: fe 71 71 00 00 00 00 00 08 40 84 ff ff ff ff ff    ?qq.....?@?.....
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: 00 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10    .???????????????

Benjamin:

This mystery device on 0x2b is part of the problem.  As a workaround,
you could load the asb100 module with the option "ignore=1,0x2b".

I2C/sensors people:

The real problem is in i2c_detect():

(lines 153-159 of i2c-sensor-detect.c)

>                /* OK, so we really should examine this address. First check
>                   whether there is some client here at all! */
>                if (is_isa ||
>                    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
>                        if ((err = found_proc(adapter, addr, -1)))
>                                return err;
>        }

I.e. after the chip driver correctly decides that the device responding
to 0x2b is NOT an asb100, it never gets the chance to examine 0x2d.

I'm not sure that replacing "return err;" with "continue;" is good enough.
Also note that if it loops through the whole range but finds nothing, it
returns 0 instead of e.g. -ENODEV.  The whole function seems to want a
re-write... would it break otherwise working configs if I cleaned this
thing up?

0	=> detected one or more clients
-ENODEV	=> nothing responded to SMBUS_QUICK (or)
-E[...]	=> return from most recent client detect attempt

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
