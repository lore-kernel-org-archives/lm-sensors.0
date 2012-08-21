From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 21 Aug 2012 13:33:08 +0000
Subject: Re: [lm-sensors] Chassis fan is reported incorrectly with M5A78L motherboard
Message-Id: <20120821133308.GA6827@growl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20531.32769.603792.771925@freddi.uddeborg>
In-Reply-To: <20531.32769.603792.771925@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Aug 21, 2012 at 02:33:05PM +0200, G=F6ran Uddeborg wrote:
> When I run "sensors" on a host with a M5A78L motherboard, it reports a
> single value, a speed which seems to be the CPU fan, twice.  Both as
> CPU and chassis fan.
[...]
> Then I lowered to just one sha1sum.  I thought it might give a reading
> in-between.  At that load, the fan ran at a bit above 2100 r/m.  And
> the chassis fan always exactly the same as the CPU fan.

Hum, this is likely a bug in ACPI code, please send me a copy of
/sys/firmware/acpi/tables/DSDT

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
