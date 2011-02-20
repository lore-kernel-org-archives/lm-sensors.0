From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Date: Sun, 20 Feb 2011 18:16:24 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] Move lis3lv02d and hp_accel out of
Message-Id: <4D615A78.3090206@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219141219.47aba4f8@endymion.delvare>
In-Reply-To: <20110219141219.47aba4f8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Op 19-02-11 14:12, Jean Delvare schreef:
> Hi all,
>
> Here is a patch set moving lis3lv02d and hp_accel out of drivers/hwmon.
> hp_accel goes where it belongs, i.e. drivers/platform/x86 (next to
> hdaps.) For lis3lv02d, I would have preferred a more specific home, but
> none seems to be suitable at the moment, so I went for drivers/misc. We
> might revisit this later.
>
> [PATCH 1/4] Let Kconfig handle lis3lv02d dependencies
> [PATCH 2/4] Move hp_accel to drivers/platform/x86
> [PATCH 3/4] Move lis3lv02d drivers to drivers/misc
> [PATCH 4/4] hp_accel: Fix driver name
>
> As with every patch moving files around, the patches look very large
> but most of them can be ignored, all you really have to look at are the
> Kconfig and Makefile changes.
>
> Note that I don't have supported hardware so I wasn't able to test the
> patches. So I would welcome testing as much as review.
>
Hello,
I'm completely fine with the move (it was in hwmon only because in the=20
first place there were other accelerometers there). So here is my:
Acked-by: =C9ric Piel <eric.piel@tremplin-utc.net>

I'll try to test the changes tomorrow (on an HP notebook), to confirm.

BTW, why do hp_accel has to be in a different directory than the rest?=20
To me it's just a different interface to the chip: ACPI/HP, instead of=20
SPI or I=B2C.

See you,
Eric


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
