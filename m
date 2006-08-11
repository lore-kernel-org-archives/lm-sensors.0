From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 11 Aug 2006 12:14:11 +0000
Subject: [lm-sensors] Lm92 fails to read temperature
Message-Id: <20060811141411.5d6902b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4be0d0b30608100501w67f6f43dy98b42e45daca06b5@mail.gmail.com>
In-Reply-To: <4be0d0b30608100501w67f6f43dy98b42e45daca06b5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi John,

> I've been having a problem with lm92 not reading the temperature of my
> cpu. This module was suggested by sensors-detect, but I tired
> modprobing all the lm* sensors ans still no temp. Lm92 loads fine as
> does lm_sensors, but reads a temperature of zero degrees. I know the
> problem does not lie with acpi because I've talked to devs on their
> mailing list and they explained the new way to build a dsdt file and
> that one compiled fine.
> 
> There are some missing modules, but before I spend time patching the
> kernel I want to find out why I can't get a temperature.
> 
> Code:
>  * Loading lm_sensors modules...
>  *   Loading i2c-i801 ...                                                 [ ok ]
>  *   Loading eeprom ...                                                   [ ok ]
>  *   Loading smbus-arp ...                                                [ !! ]
>  *   Loading smartbatt ...                                                [ !! ]
>  *   Loading saa1064 ...                                                  [ !! ]
>  *   Loading lm92 ...                                                     [ ok ]
>  *   Loading pca9540 ...                                                  [ !! ]
>  *   Loading max6650 ...                                                  [ ok ]

These are all the most difficult chips to detect, and as a consequence,
the most frequently misdetect chips. I am fairly certain you don't have
any of these chips.

>  * Initializing sensors ...                                               [ ok
> 
> Max6650 so far is the only module I've added by hand, but I've tried
> with pca9540 (pca954x) but the patch floating around isn't working.
> I've read through the documentation, but it's a little over my head.
> It seems like they are for nonthermal things.

It is, indeed, but you don't need any of these drivers anyway.

> Also, smbus seems to be going nuts in my dmesg:
> 
> Code:
> i2c_adapter i2c-0: smbus word data - addr 0x4f, read  0x0000 at 0x02.

I suspect that one of the i2c busses on your system is broken, causing
sensors-detect to misdetect lots of chips. Please provide the output of:
i2cdetect -l
And then for every bus listed,
i2cdetect N
where N is a bus number (0, 1, etc...)

> It reads alll of the sys bus files over and over again.  So whenever I
> access dmeg all I get is a page of these.

What is "it"?

> I've also tried editing the config file so that only those that
> succeed load, but that doesn't work either.

Your problem lies well before the configuration step.

> My computer is a Dell Dimension 8250.

What makes you think this model has a thermal sensor chip lm_sensors
can use? Most laptops don't.

-- 
Jean Delvare

