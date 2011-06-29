From: krunal patel <krunal_smiles@yahoo.com>
Date: Wed, 29 Jun 2011 08:17:56 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <1309334756.55292.YahooMailClassic@web95806.mail.in.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

--- On Mon, 27/6/11, Jean Delvare <khali@linux-fr.org> wrote:

> From: Jean Delvare <khali@linux-fr.org>
> Subject: Re: [lm-sensors] sensor details for W83627HG-AW
> To: "krunal patel" <krunal_smiles@yahoo.com>
> Cc: lm-sensors@lm-sensors.org, "Guenter Roeck" <guenter.roeck@ericsson.co=
m>
> Date: Monday, 27 June, 2011, 8:32 PM
> Hi Krunal,
>=20
> On Fri, 24 Jun 2011 16:49:13 +0530 (IST), krunal patel
> wrote:
> > after insmod hwmon-vid.ko and via-cputemp.ko output of
> sensors binary is
> > (...)
> > via_cputemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:=A0 =A0 =A0 +3892138.1 C=A0=20
> > cpu0_vid:=A0 =A0 +0.684 V
>=20
> Thanks for the report. cpu0_vid looks very good, so I'll
> push my
> patches upstream. I can credit you as a tester if you want,
> but beware
> that your e-mail address would then be published in the
> kernel
> repository, which could result in more spam.
I will left this on you. :). I will try that my name comes in developer lis=
t in future. :)
>=20
> Temperature looks plain wrong though. Does the number
> change over time?
>
Temperature values are constant in via_cputemp-isa-0000 output but it chang=
es in w83627hf-isa-0290 output when I run cpuburn like binary.
> Can you please provide the output of:
> # rdmsr -x 0x1169
> both when idle and under load?
>=20
# rdmsr -x 0x1169
ffff50
> Looking at the code, I don't even see how the temperature
> value could
> be a non-integer, so there must be an overflow somewhere.
>=20
> --=20
> Jean Delvare
>=20

Regards,
Krunal

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
