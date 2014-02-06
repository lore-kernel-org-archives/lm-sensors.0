From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Feb 2014 16:53:05 +0000
Subject: Re: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <20140206175305.78379b55@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
In-Reply-To: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rune,

On Thu, 6 Feb 2014 15:54:33 +0100, Rune Kj=E6r Svendsen wrote:
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `it87':
>   * ISA bus, address 0x290
>  Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)
>=20
> Driver `fam15h_power' (autoloaded):
>   * Chip `AMD Family 15h power sensors' (confidence: 9)
>=20
> Driver `k10temp' (autoloaded):
>   * Chip `AMD Family 15h thermal sensors' (confidence: 9)

This pretty much rules out the theory of a second hardware monitoring
device to which the last fan would be connected.

> (...)
> [   16.382872] it87: Found IT8721F chip at 0x290, revision 3

I took a look at the datasheet for this chip and could not find
anything wrong with the driver.

However, if you provide a few register dumps, I can double check if the
chip is in an unexpected state.

# rmmod it87
# isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 0x07
# isadump 0x295 0x296
# modprobe it87

With these two register dumps I should be able to check if fan4_input
is supposed to be enabled or disabled.

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
