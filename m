From: Manuel Knitza <manuel.knitza@uni-konstanz.de>
Date: Tue, 13 Oct 2009 14:27:08 +0000
Subject: Re: [lm-sensors] it87 / acpi / DSDT-dump (ASUS P5V2D-MX)
Message-Id: <4AD48E3C.2030900@uni-konstanz.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
In-Reply-To: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:
> On Tue, 13 Oct 2009 15:37:34 +0200, Luca Tettamanti wrote:
>> So my advise to you is to use asus_atk0110; if you need to directly
>> control the fans (not possible with the ACPI driver) then use
>> "acpi_enforce_resources=3Dlax" and load it87 (and do *not* load
>> asus_atk0110).
>=20
> I thought the asus_atk0110 driver was being automatically? If I'm
> correct then one needs to _blacklist_ the asus_atk0110 driver for it to
> not load.
>=20
i think in general, yes. but only if available. as a gentoo-user i=B4m=20
adjusting my kernel very often. so "blacklisting" for me is done=20
'automatically' by removing that module from my kernel-config to be=20
compiled as a module and then doing a "make modules && make=20
modules_install" (which suffices as only the modules i really need for=20
booting kernel are not compiled as modules, but into kernel)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
