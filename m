From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Sep 2008 10:42:55 +0000
Subject: Re: [lm-sensors] New winbond chip: W83667HG
Message-Id: <20080912124255.000d1f5e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807072054.10321.phhusson@free.fr>
In-Reply-To: <200807072054.10321.phhusson@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marco,

On Fri, 12 Sep 2008 11:56:34 +0200, Marco Chiappero wrote:
> root@etna:~# isadump 0x295 0x296 0
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x295 and data register 0x296.
> Probing bank 0 using bank register 0x4e.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 7f 04 3d 30 00 32 20 01 9b 01 01 3c 3c 04 04
> 10: 04 ff 30 00 00 01 01 3c 43 17 00 00 2d ff ff c1
> 20: 87 d9 d3 d1 d6 ff 9d 2c c4 54 ff da 00 01 02 9a
> 30: c2 10 04 b0 61 89 21 00 32 00 40 08 80 01 37 bb
> 40: 03 de 00 ff ff 00 3f 35 2d 21 20 c0 10 95 00 a3
> 50: ff ff 00 ff ff ff 00 80 c1 7f ff ff 19 c5 04 05
> 60: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 1e
> 70: 3c 3c 3c 3c 3c 37 ff ff ff ff ff 4b 22 00 2c ff
> 80: 04 7f 04 3d 30 00 32 20 01 9b 01 01 3c 3c 04 04
> 90: 04 ff 30 00 00 01 01 3c 43 17 00 00 2d ff ff c1
> a0: 87 d9 d3 d1 d6 ff 9d 2c c4 54 ff da 00 01 02 9a
> b0: c2 10 04 b0 61 89 21 00 32 00 40 08 80 01 37 bb
> c0: 03 00 00 ff ff 00 3f 35 2d 21 20 c0 10 95 00 a3
> d0: ff ff 00 ff ff ff 00 80 c1 7f ff ff 19 c5 04 05
> e0: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 1e
> f0: 3c 3c 3c 3c 3c 37 ff ff ff ff ff 4b 22 00 2c ff
> 
> root@etna:~# isadump 0x2e 0x2f  -k 0x87,0x87
> Error: Invalid bank number!
> Syntax for I2C-like access:
>    isadump [-y] [-k V1,V2...] ADDRREG DATAREG [BANK [BANKREG]]
> Syntax for flat address space:
>    isadump [-y] -f ADDRESS [RANGE [BANK [BANKREG]]]

The correct syntax is:
isadump -k 0x87,0x87 0x2e 0x2f

(Cheap command line handling, options must go first.)

> The board it's an Asus Maximus II Formula.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
