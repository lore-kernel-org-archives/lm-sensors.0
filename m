From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: Linux 2.6.3 i2c it87 sensor support
Message-Id: <20040228141127.226a3993.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF4B814-67DF-11D8-89D2-000393034272@polytechnique.org>
In-Reply-To: <CBF4B814-67DF-11D8-89D2-000393034272@polytechnique.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi, Thanks for submitting me this patch. Unfortunately, my Video
> Card has burnt tonight because of a badly mounted heatpipe cooler.

:(

> For this reason, I cannot test the patch right now, but I'll do
> ASAP.

OK.

> Once again, thks for such a nice program

You're welcome :)

> PS : BTW, is there any way to measure the core temperature of an
> nVidia  GeForce FX 5700 GPU thanks to lm-sensors ??

There is. I'd expect the rivatv module to work on it. I know it works
with the FX 5600. If you confirm that rivatv works for your card, I'll
add support to sensors-detect for it (easy).

Note that the rivatv driver will provide support for the I2C bus of the
card. What's on the bus depends on the card manufacturer. The bus can be
empty or host a hardware monitoring chip such as a Winbond W83782D (I
think I remember that's what I had on my GeForce 2 MX-400).

Please let us know how it goes.
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
