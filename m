From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 02 Oct 2009 10:41:43 +0000
Subject: Re: [lm-sensors] ATK0110
Message-Id: <68676e00910020341g5a42ddd0w6cd215c25b96daec@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Oct 1, 2009 at 10:03 PM, Mark Altern <mark.altern@gmail.com> wrote:
> Hi,
>
> Sorry to send you this abrupt email. I just have a quick question about
> asus_atk0110. I am a little frustrated and don't know where else I can as=
k.

I'm the maintainer of the driver so I'm the right person ;-)
lm-sensors@lm-sensors.org is the appropriate ML.

> I have ASUS p6t with Core i7 920 system, the problem is that asus_atk0110
> report wrong CPU diode temperatures, 47C while in fact is is about 36C, t=
hus
> forcing the CPU fan running more than 1100 rmp during idling.=C2=A0To sol=
ve this
> problem I blacklist this module, while instead load w83667hg, which repor=
ts
> the right temperature. Then the CPU fan is working correctly. Do you think
> it is safe to do so?

Are you using fancontrol/pwmconfig to control the fan?

> I am just wondering why atk0110 is reporting the wrong values? do you thi=
nk
> this mis-behavior will be fixed in the future?

It's more likely that w83667hg is reporting the "wrong" value. The
ACPI drivers reports the temperature as reported by system firmware.
It's possible that the firmware is compensating the raw value to give
an estimate of the real CPU temperature (as opposed to the temperature
of a diode sittign somewhere under the socket). In just in case send a
copy of your DSDT (/sys/firmware/acpi/tables/DSDT).
Also take a look at the values reported by coretemp to have an idea of
the real core temperature.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
