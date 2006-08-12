From: acocaracha@gmail.com (John Altobelli)
Date: Sat, 12 Aug 2006 00:41:56 +0000
Subject: [lm-sensors] Lm92 fails to read temperature
Message-Id: <4be0d0b30608111741s6a52bf61q36740f4f9c98eb25@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4be0d0b30608100501w67f6f43dy98b42e45daca06b5@mail.gmail.com>
In-Reply-To: <4be0d0b30608100501w67f6f43dy98b42e45daca06b5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2cdetect -l :
i2c-3   smbus           SMBus I801 adapter at ccf0
Non-I2C SMBus adapter
i2c-2   i2c             ivtv i2c driver #1
Algorithm unavailable
i2c-1   i2c             ivtv i2c driver #0
Algorithm unavailable
i2c-0   smbus           SMBus stub driver
Non-I2C SMBus adapter

i2cdetect 0 :
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
10: 10 11 12 13 14 15 16 17 18 19 1a UU 1c 1d 1e UU
20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
40: 40 41 42 43 44 45 46 47 UU UU UU UU 4c 4d 4e 4f
50: UU UU UU UU UU UU UU UU 58 59 5a 5b 5c 5d 5e 5f
60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
70: 70 71 72 73 74 75 76 77

i2cdetect 1 :
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX UU UU XX XX XX XX XX XX XX XX XX XX XX
50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

i2cdetect 2 :
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX UU UU XX XX XX XX XX XX XX XX XX XX XX
50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

i2cdetect 3 :
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX XX 64 XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

A small snibit of dmesg :
i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x02.
i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x03.
i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x04.
i2c_adapter i2c-0: smbus word data - addr 0x48, read  0x0000 at 0x05.
i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x00.
i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x02.
i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x03.
i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x04.
i2c_adapter i2c-0: smbus word data - addr 0x49, read  0x0000 at 0x05.
i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x00.
i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x02.
i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x03.
i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x04.
i2c_adapter i2c-0: smbus word data - addr 0x4a, read  0x0000 at 0x05.
i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x00.
i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x02.
i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x03.
i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x04.
i2c_adapter i2c-0: smbus word data - addr 0x4b, read  0x0000 at 0x05.

The Dell Dimension 8250 is a desktop.  I can't find any information
about it so I'm not sure it has a thermal sensor or not.  Is it
possible to control the fan without it?

Thanks for the help,
John

On 8/11/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi John,
>
> > I've been having a problem with lm92 not reading the temperature of my
> > cpu. This module was suggested by sensors-detect, but I tired
> > modprobing all the lm* sensors ans still no temp. Lm92 loads fine as
> > does lm_sensors, but reads a temperature of zero degrees. I know the
> > problem does not lie with acpi because I've talked to devs on their
> > mailing list and they explained the new way to build a dsdt file and
> > that one compiled fine.
> >
> > There are some missing modules, but before I spend time patching the
> > kernel I want to find out why I can't get a temperature.
> >
> > Code:
> >  * Loading lm_sensors modules...
> >  *   Loading i2c-i801 ...                                                 [ ok ]
> >  *   Loading eeprom ...                                                   [ ok ]
> >  *   Loading smbus-arp ...                                                [ !! ]
> >  *   Loading smartbatt ...                                                [ !! ]
> >  *   Loading saa1064 ...                                                  [ !! ]
> >  *   Loading lm92 ...                                                     [ ok ]
> >  *   Loading pca9540 ...                                                  [ !! ]
> >  *   Loading max6650 ...                                                  [ ok ]
>
> These are all the most difficult chips to detect, and as a consequence,
> the most frequently misdetect chips. I am fairly certain you don't have
> any of these chips.
>
> >  * Initializing sensors ...                                               [ ok
> >
> > Max6650 so far is the only module I've added by hand, but I've tried
> > with pca9540 (pca954x) but the patch floating around isn't working.
> > I've read through the documentation, but it's a little over my head.
> > It seems like they are for nonthermal things.
>
> It is, indeed, but you don't need any of these drivers anyway.
>
> > Also, smbus seems to be going nuts in my dmesg:
> >
> > Code:
> > i2c_adapter i2c-0: smbus word data - addr 0x4f, read  0x0000 at 0x02.
>
> I suspect that one of the i2c busses on your system is broken, causing
> sensors-detect to misdetect lots of chips. Please provide the output of:
> i2cdetect -l
> And then for every bus listed,
> i2cdetect N
> where N is a bus number (0, 1, etc...)
>
> > It reads alll of the sys bus files over and over again.  So whenever I
> > access dmeg all I get is a page of these.
>
> What is "it"?
>
> > I've also tried editing the config file so that only those that
> > succeed load, but that doesn't work either.
>
> Your problem lies well before the configuration step.
>
> > My computer is a Dell Dimension 8250.
>
> What makes you think this model has a thermal sensor chip lm_sensors
> can use? Most laptops don't.
>
> --
> Jean Delvare
>

