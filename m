From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Ticket #920
Message-Id: <3D14928C.3F77934B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206221117.33609.veso_vdd@mail.orbitel.bg>
In-Reply-To: <200206221117.33609.veso_vdd@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you want i2cdump 2 0x50, not 0 0x50 - you dumped your SDRAM EEPROM, not
your DDC one.

Vesselin Dimitrov wrote:
> 
> # prog/dump/i2cdump 0 0x50
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 04 0c 08 01 40 00 01 a0 60 00 80 10 00 01    ??????@.??`.??.?
> 10: 8f 04 04 01 01 00 0e 00 00 00 00 14 14 14 32 08    ?????.?....???2?
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 a2    ..............??
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 62 00    ..............b.
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 c4    ..............d?
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 
> I think that the problem is in fact in i2c-voodoo3.o
> because there was some scanlines offseted by 1 pixel
> to the left when the module was loaded and this was
> hard to be seen. When I removed the module and restarted
> the machine all came back to normal.
