From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Jan 2011 17:54:05 +0000
Subject: Re: [lm-sensors] f75375s detected but no temp output
Message-Id: <20110106185405.410fad84@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
In-Reply-To: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 25 Dec 2010 14:15:46 +0100, Pali Roh=E1r wrote:
> Where is the problem? And why is no f75375s temp detected by lm sensors?

Nvidia binary driver, right? It misses four lines of code that would let
hwmon drivers bind to its I2C adapters. The code exists for 4 or 5
years now, it's even included in Gentoo [1] but Nvidia never bothered
applying it. Complain to them.

[1] http://gentoo.zugaina.org/portage/x11-drivers/nvidia-drivers/files/NVID=
IA_i2c-hwmon.patch

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
