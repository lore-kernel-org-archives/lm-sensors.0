From: "Markus Rechberger" <mrechberger@gmail.com>
Date: Fri, 31 Oct 2008 22:15:13 +0000
Subject: Re: [lm-sensors] [Em28xx] ACPI reads wrong temperature after
Message-Id: <d9def9db0810311515n166f7ff2t6362d690a883de70@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Peter,

On Fri, Oct 31, 2008 at 11:08 PM, Peter Mahlknecht <mali100@gmx.net> wrote:
> Hi,
> I have here a strange problem:
> after loading the em28xx_cx25843 module in
> /proc/acpi/thermal_zone/THRM/temperature a wrong temperature (65535 C) wh=
ich
> forces a shutdown on my notebook ("Critical temperature reached (65535 C).
> Shutting down."). Same thing happens if I load the lm90 module (hwmon dri=
ver
> for the temperaturesensor used by lm-sensors). Both modules depend on
> i2c_core, so maybe its an I=B2C bug. Any suggestions?
>

I think the lmsensors mailinglist might be better for this! Jean
Delvare might now more about it.
added the lm-sensors ML.

also provide which kernel version you use.

Markus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
