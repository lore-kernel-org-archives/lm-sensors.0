From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 26 Jun 2011 20:20:00 +0000
Subject: Re: [lm-sensors] [PATCH v3] Add support for the Philips SA56004
Message-Id: <20110626202000.GA9067@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
 <BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
In-Reply-To: <BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Fubo Chen <fubo.chen@gmail.com>
Cc: "sdevrien@cisco.com" <sdevrien@cisco.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jun 26, 2011 at 03:54:37PM -0400, Fubo Chen wrote:
> On Mon, Jun 6, 2011 at 12:40 PM,  <sdevrien@cisco.com> wrote:
> > + =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 if (man_id =3D 0xA1) { /* =A0NXP Semiconductor/Philips */
>=20
> No kernel coder writes like this. Has this ever been run through checkpat=
ch ?
>=20
What a nice comment. Quite obviously _you_ did not run the patch through ch=
eckpatch
to back up yout claim. I did:

total: 0 errors, 0 warnings, 151 lines checked

The code format is in line with other if/else constructs in the same functi=
on,
which coincidentially also pass through checkpatch. Which you did not bother
checking either (neither the format of the code in lm90.c nor the results
of checkpatch over it).

Before making statements like this, you might want to consider spending som=
e time
with the actual code - amongst others to see if the new code fits into the =
structure
of existing code.

If you want to improve code formatting in this or in other files, I would s=
uggest=20
to submit patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
