From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Sep 2009 08:00:34 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <20090915100034.4c53bd35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Martin,

Please keep the list in Cc or I am no longer replying.

On Tue, 15 Sep 2009 00:53:41 +0200, Martin MOKREJ=A6 wrote:
> Hi Jean,
>   yes, on 2.6.30.4 it "works" (probably in the broken way):

This is exactly the symptom described in the blog post I sent you to.
http://hansdegoede.livejournal.com/7932.html
Did you read it?

> $ dmesg
> [cut]
> i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKB] -> GSI 11 (level, low) -=
> IRQ 11
> [cut]
>=20
> $ sensors
> ds1621-i2c-4-4c
> Adapter: SMBus I801 adapter at e800
> temp:     +51.00=B0C  (low  =3D +51.0=B0C, high =3D +51.0=B0C)  ALARM (LO=
W)

You don't really have a DS162x chip on your system, do you? The output
above is rather suspicious. Does the temperature value ever changes?

This chip is very difficult to detect and misdetections are very
frequent. We should probably even disable it altogether. So if that's
all you had with kernel 2.6.30.4, it hardly qualifies as "worked".

> Maybe I got bitten due to the broken driver implementation with IRQ issue=
s?
> http://bugzilla.kernel.org/show_bug.cgi?id=14149
> What do you think?

I don't know anything about this specific issue, sorry.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
