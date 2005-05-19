From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <20020204094249.K1871@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Yeah, at a glance, the 0x57 doesn't look like a valid SPD DIMM.  The
0x50-0x57 range is almost always for eeproms connected to the I2C bus,
so it doesn't have to be a DIMM. Like I said, some processors, like
Xeons have an eepom on them which show up on the system's I2C/SMBus.

BTW- Have you tried running eeprom-decode.pl?  It's in
lm-sensors/prog/eeprom, I think.  It can help decode the values of
your valid SPD DIMM (timing and such).  There is also a checksum value
which it computes and compared with what is stored on the chip.  If
the checksum isn't valid, then it is almost certainly evidence that
the chip isn't on a DIMM (or is corrupted).


Phil

On Mon, Feb 04, 2002 at 06:31:46PM +0100, Jean Delvare wrote:
> 
> > The print_eeprom() code in prog/sensors/chips.c will only
> > print out the SDRAM information if the chip is
> > coded as an SDRAM, that is, location 0x02 contains 0x04.
> 
> Which is the case for 0x50 but not for 0x57 (in my case) so it works as
> expected.
> 
> > If you send the output of either i2cdump or cat
> > /proc/sys/dev/sensors/*eeprom*/*
> > we can look at it.
> 
> root@arrakis:~# cat `ls -v /proc/sys/dev/sensors/eeprom-i2c-0-50/*`
> 128 8 4 12 9 2 64 0 1 117 84 0 128 16 0 1
> 15 4 6 1 1 0 14 160 96 255 255 20 15 20 45 16
> 21 8 21 8 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 18 11
> 193 73 78 70 73 78 69 79 69 72 89 83 54 52 86 49
> 54 50 50 48 71 68 76 45 55 46 53 3 201 1 56 3
> 59 173 177 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 100 199
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 
> root@arrakis:~# cat `ls -v /proc/sys/dev/sensors/eeprom-i2c-0-57/*`
> 0 0 0 0 0 0 0 255 255 255 255 255 255 255 255 255
> 17 67 101 64 75 102 17 198 130 218 8 0 70 67 209 98
> 69 85 48 54 48 51 0 0 0 0 0 0 0 0 0 0
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255 255
> 80 67 71 45 71 82 50 49 52 69 80 40 70 82 41 0
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 48 49 0 0 0 0 0 0 0 0 56 56 52 77 27 81
> 80 80 134 0 0 0 0 0 0 0 0 0 1 5 117 0
> 50 56 51 51 51 51 53 52 45 53 52 54 49 52 49 48
> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 49 49 47 49 53 47 48 49 32 49 51 58 50 54 58 51
> 55 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 
> (Note that I modified the eeprom driver to show 256 bytes instead of 128.)
> 
> The same with i2cdump, in case you prefer.
> 
> root@arrakis:/usr/src/lm_sensors-CVS/prog/dump# ./i2cdump 0 0x50
> Warning: no size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x50, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 80 08 04 0c 09 02 40 00 01 75 54 00 80 10 00 01
> 10: 0f 04 06 01 01 00 0e a0 60 ff ff 14 0f 14 2d 10
> 20: 15 08 15 08 ff ff ff ff ff ff ff ff ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 12 0b
> 40: c1 49 4e 46 49 4e 45 4f 45 48 59 53 36 34 56 31
> 50: 36 32 32 30 47 44 4c 2d 37 2e 35 03 c9 01 38 03
> 60: 3b ad b1 ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 64 c7
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> root@arrakis:/usr/src/lm_sensors-CVS/prog/dump# ./i2cdump 0 0x57
> Warning: no size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0, address 0x57, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
> 10: 11 43 65 40 4b 66 11 c6 82 da 08 00 46 43 d1 62
> 20: 45 55 30 36 30 33 00 00 00 00 00 00 00 00 00 00
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: 50 43 47 2d 47 52 32 31 34 45 50 28 46 52 29 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 30 31 00 00 00 00 00 00 00 00 38 38 34 4d 1b 51
> b0: 50 50 86 00 00 00 00 00 00 00 00 00 01 05 75 00
> c0: 32 38 33 33 33 33 35 34 2d 35 34 36 31 34 31 30
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 31 31 2f 31 35 2f 30 31 20 31 33 3a 32 36 3a 33
> f0: 37 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> I remind you that 0x50 is the first SO-DIMM slot, working as expected. The
> two questions that remain unsolved are :
> 1* Why is the second slot not available ?
> 2* What is showing at 0x57 ?
> 
> -- 
>        /~~       Jean "Khali" Delvare
>   -----\_                        mail: delvare@ensicaen.ismra.fr
>  --------\                http://www.ensicaen.ismra.fr/~delvare/
> ---=ISMRA/- ____________________________________________________

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
