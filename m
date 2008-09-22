From: "Gerhart, Bjoern" <bjoern.gerhart@wincor-nixdorf.com>
Date: Mon, 22 Sep 2008 16:05:55 +0000
Subject: Re: [lm-sensors] No Alarm when values not within range
Message-Id: <5E5D87015BF8A54A93DAD6F808B1129ACB071D@DEEXVS13.wincor-nixdorf.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
In-Reply-To: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Just thinking about it now:
> what kernel version are you running? I assumed you were running
> something recent (2.6.25 or later) but maybe not?

Ah, this seems to be the missing part. We use Centos 5 with kernel 2.6.18, =
Therefore the missing alarm support is explained.

Maybe we would try backporting the missing functionality to kernel 2.6.18. =
For our different systems, in sum we use the following kernel modules relat=
ed to lm_sensors:

* it87 (you already said that this one is affected)
* pc87360
* i2c-i801
* i2c-isa
* eeprom

For backporting we'd need to know which kernel modules are affected. My gue=
ss is, beside of the it87 it's just the pc87360 - am I right?

Regards
Bj=F6rn

--=20
WINCOR NIXDORF International GmbH=20
Sitz der Gesellschaft: Paderborn=20
Registergericht Paderborn HRB 3507
Gesch=E4ftsf=FChrer: Eckard Heidloff (Vorsitzender), Stefan Auerbach, Dr. J=
=FCrgen Wunram
Vorsitzender des Aufsichtsrats: Karl-Heinz Stiller=20
Steuernummer: 339/5884/0020 - Ust-ID Nr.: DE812927716 - WEEE-Reg.-Nr. DE444=
77193

Diese E-Mail enth=E4lt vertrauliche Informationen. Wenn Sie nicht der richt=
ige Adressat sind oder diese E-Mail irrt=FCmlich erhalten haben, informiere=
n Sie bitte sofort den Absender und vernichten Sie diese E-Mail. Das unerla=
ubte Kopieren sowie die unbefugte Weitergabe dieser E-Mail ist nicht gestat=
tet.

This e-mail may contain confidential information. If you are not the intend=
ed recipient (or have received this e-mail in error) please notify the send=
er immediately and destroy this e-mail. Any unauthorised copying, disclosur=
e or distribution of the material in this e-mail is strictly forbidden.=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
