From: Fubo Chen <fubo.chen@gmail.com>
Date: Sun, 26 Jun 2011 19:54:37 +0000
Subject: Re: [lm-sensors] [PATCH v3] Add support for the Philips SA56004
Message-Id: <BANLkTi=gAqpDNBjCXzvNEhSuzm=3Mg9rVg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
In-Reply-To: <1307356845-10095-1-git-send-email-sdevrien@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sdevrien@cisco.com
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com

On Mon, Jun 6, 2011 at 12:40 PM,  <sdevrien@cisco.com> wrote:
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 if (man_id =3D 0xA1) { /* =A0NXP Semiconductor/Philips */

No kernel coder writes like this. Has this ever been run through checkpatch=
 ?

Fubo.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
