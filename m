From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 17:01:52 +0000
Subject: Re: [lm-sensors] Zotac itx-f sensor i2cdump
Message-Id: <20091202180152.582f4687@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
In-Reply-To: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 2 Dec 2009 16:55:46 +0100, MC Matti wrote:
> I'm trying to use the sensors on my zotac ion itx-f.
> Currently without any luck.
> (sensor-detect does not configure the sensors)
> 
> Does anyone has an idea which sensor it can be?
> 
> root@localhost:~# uname -a
> Linux localhost 2.6.31-15-generic #50-Ubuntu SMP Tue Nov 10 14:54:29
> UTC 2009 i686 GNU/Linux
> 
> dpkg -s lm-sensors: Version: 1:3.1.1-4
> 
> 
> root@localhost:~# i2cdetect -l
> i2c-0   smbus           SMBus nForce2 adapter at 4d00           SMBus adapter
> i2c-1   smbus           SMBus nForce2 adapter at 4e00           SMBus adapter
> i2c-2   i2c             NVIDIA i2c adapter                      I2C adapter
> i2c-3   i2c             NVIDIA i2c adapter                      I2C adapter
> i2c-4   i2c             NVIDIA i2c adapter                      I2C adapter
> 
> root@localhost:~# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- 4e --
> 50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> (...)
> root@localhost:~# i2cdump 0 0x4c
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x4c, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 2e 3b 80 01 08 46 d8 46 d8 ff ff ff ff ff ff ff    .;???F?F?.......
> 10: 60 00 00 00 00 00 00 04 00 6e 6e 46 d8 00 00 ff    `......?.nnF?...
> 20: 55 0a ff ff 7f e0 ff ff ff ff ff ff ff ff ff ff    U?..??..........
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> <more ff>
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: 00 00 00 84 84 84 00 00 55 00 00 ff ff ff ff ff    ...???..U.......
> f0: 50 00 00 00 84 00 00 39 a0 00 00 83 00 ff 5c 11    P...?..9?..?..\?

I was discussing with someone from Zotac recently and he told me they
were using W83L771AWG/ASG. The above looks exactly like one. Please
give a try to the latest version of sensors-detect, it should confirm
it:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

We do not have support for this chip yet.

> root@localhost:~#i2cdump 0 0x4e
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x4e, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 80 00 a4 a4 00 00 00 00 00 00 00 00 00 00 00    .?.??...........
> 10: 00 00 ff 0f 00 00 00 00 00 00 00 00 00 00 00 00    ...?............
> 20: 00 00 00 00 00 00 03 00 83 12 12 28 00 00 00 00    ......?.???(....
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> <more 00>

No idea about that one, we probably better leave it alone.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
