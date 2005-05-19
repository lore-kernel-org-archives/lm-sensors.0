From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: sensors on Acer TM427LC
Message-Id: <20031220141449.381bc88d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312170127.30400.enrico_tux@yahoo.it>
In-Reply-To: <200312170127.30400.enrico_tux@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> At least for 2.400 euros, i would like to know the model of mine
> winbond SD/MMC Memory Stick... but neither this... My last time with
> Acer... :-/

Other laptops manufacturers aren't necessarily better. I have a Sony and
they refused to help too. The grass isn't always greener on the other
side.

> My i2cdetect 0:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: 30 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

Very similar to what I have. 69 is a useless (from our point of view)
clock chip. 50 is your memory chip's eeprom, 30 is a shadow of it.
Nothing else (and so no hardware monitoring).

> At least u gotta it by acpi.. I can't.. heheh, i'm not so lucky... 

Give a try to the "relaxed AML" option (or something similar, I don't
remember exactly). Maybe it can help.

> I would like to be usefull for the project and for the people who has
> this laptop... so if i can do something, just tell me, ok?

Unfortunately there's nothing we can do. Your best chance is on the ACPI
side. Enable the debug mode, take a look at your logs and see if
something indicates that you do have a thermal sensor but it fails being
supported for some reason. In this case, report to the ACPI folks and
maybe they'll be able to help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
