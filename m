From: arvidjaar@newmail.ru (Andrey Borzenkov)
Date: Fri, 27 Jan 2006 04:15:16 +0000
Subject: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Message-Id: <200601270715.16881.arvidjaar@newmail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200601142223.35838.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru> <43CAB1B7.6020903@sh.cvut.cz>
In-Reply-To: <43CAB1B7.6020903@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 23:33, Rudolf Marek wrote:
> Hello all,
>
> > this appears simply a probing for non-existent i2c ports (correct me if=
 I
> > am wrong) presumably by eeprom driver.
>
> yes I think you are right. (ADD/2 is the address of chip, that it tries to
> access)
>
> > Second block are errors from lm90 for different registers:
> >
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre):
> > STS=04, TYP=10, CMD=01, ADD=99, DAT0=A0, DAT1=10
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post):
> > STS=14, TYP=10, CMD=01, ADD=99, DAT0), DAT1=10
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre):
> > STS=04, TYP=10, CMD=08, ADD=98, DAT0), DAT1=10
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Error: command never
> > completed
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post):
> > STS=04, TYP=10, CMD=08, ADD=98, DAT0), DAT1=10
> > Jan 15 22:24:02 cooker kernel: lm90 0-004c: Register 0x8 read failed (-=
1)

I still did not have much time to spend on it but booting today I suddenly =
got

i2c_adapter i2c-0: Unsupported chip (man_id=3D0x41, chip_id=3D0x42).

I begin to suspect that it is still lm90 (at least partly). Transacton did =
not=20
fail (otherwise we were not here) but returned some strange value. Anyone=20
knows if such chip really exits?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD2Z5UR6LMutpd94wRAmaYAKCAdwCutdUWK+RFbQu9nMiLuIl6jACdGgj9
IHiDsWm37Xr4UWmQYbvwIOk=A1Ao
-----END PGP SIGNATURE-----

