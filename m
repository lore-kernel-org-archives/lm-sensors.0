From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 21 Aug 2012 14:02:32 +0000
Subject: Re: [lm-sensors] Chassis fan is reported incorrectly with M5A78L motherboard
Message-Id: <20120821140232.GB6827@growl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20531.32769.603792.771925@freddi.uddeborg>
In-Reply-To: <20531.32769.603792.771925@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Aug 21, 2012 at 03:43:24PM +0200, G=F6ran Uddeborg wrote:
> Luca Tettamanti:
> > Hum, this is likely a bug in ACPI code, please send me a copy of
> > /sys/firmware/acpi/tables/DSDT
>=20
> Sent off list.  In case anyone else also would be interested, I placed
> it at ftp://ftp.uddeborg.se/pub/DSDT too.

Yep, broken BIOS:

Method (FGET, 1, NotSerialized)
{
    If (LEqual (Arg0, Zero))
    {
        Return (^^SIOR.HWF1 ())
    }

    If (LEqual (Arg0, One))
    {
        Return (^^SIOR.HWF1 ())
    }
}

It always reads the same sensor. The other ("new") monitoring interface
seems fine though. Unload the module and try reloading it with
"new_if=3D1", like this:

modprobe asus_atk0110 new_if=3D1

And see if everything looks good.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
