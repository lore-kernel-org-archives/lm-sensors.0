From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 12 Aug 2006 10:21:29 +0000
Subject: [lm-sensors] Lm92 fails to read temperature
Message-Id: <20060812122129.e62b434d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4be0d0b30608100501w67f6f43dy98b42e45daca06b5@mail.gmail.com>
In-Reply-To: <4be0d0b30608100501w67f6f43dy98b42e45daca06b5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,

> i2cdetect -l :
> i2c-3   smbus           SMBus I801 adapter at ccf0     Non-I2C SMBus adapter
> i2c-2   i2c             ivtv i2c driver #1             Algorithm unavailable
> i2c-1   i2c             ivtv i2c driver #0             Algorithm unavailable
> i2c-0   smbus           SMBus stub driver              Non-I2C SMBus adapter

Ah. The "SMBus stub driver" is a test driver solely meant to debug
SMBus chip drivers. This is what confused sensors-detect. Why did you
load that driver?

> i2cdetect 0 :
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
> 10: 10 11 12 13 14 15 16 17 18 19 1a UU 1c 1d 1e UU
> 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
> 40: 40 41 42 43 44 45 46 47 UU UU UU UU 4c 4d 4e 4f
> 50: UU UU UU UU UU UU UU UU 58 59 5a 5b 5c 5d 5e 5f
> 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
> 70: 70 71 72 73 74 75 76 77

The test driver (i2c-stub) responds to all addresses. It's confusing
and you don't need it! Unload i2c-stub.

> i2cdetect 1 :
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX UU UU XX XX XX XX XX XX XX XX XX XX XX
> 50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
> 
> i2cdetect 2 :
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX UU UU XX XX XX XX XX XX XX XX XX XX XX
> 50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

Some media/video adapter you must have in that machine. We don't really
care about that.

> i2cdetect 3 :
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX 61 XX XX 64 XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

Your mainboard SMBus. I see two memory module EEPROMs (SPD), unknown
chips at 0x61 and 0x64, but no hardware monitoring chips.

> A small snibit of dmesg :
> i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x02.
> i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x03.
> i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x04.
> i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x05.
> i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x00.
> i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x02.
> i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x03.
> i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x04.
> i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x05.
> i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x00.
> i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x02.
> i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x03.
> i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x04.
> i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x05.
> i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x00.
> i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x02.
> i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x03.
> i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x04.
> i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x05.

That's the i2c-stub driver helping you test and debug your code. As you
are only trying to get lm_sensors to run, it is completely irrelevant.
Just unload i2c-stub.

> The Dell Dimension 8250 is a desktop.  I can't find any information
> about it so I'm not sure it has a thermal sensor or not.  Is it
> possible to control the fan without it?

You can control the fan without a thermal sensor, these are two
separate things. However, you need a chip on your motherboard in either
case. You don't seem to have such a chip on your SMBus. Fan speed
control functions are sometimes integrated in Super-I/O chips (last
part of sensors-detect).

You may search for hardware monitoring information in the BIOS setup
screen. If you can't find any, it's usually a good indication that the
board doesn't have the feature. But better ask Dell for details if you
can.

-- 
Jean Delvare

