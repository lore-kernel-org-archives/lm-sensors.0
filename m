From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 May 2011 14:06:28 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add detection of MAX6642
Message-Id: <20110526160628.5736ce0c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 26 May 2011 06:55:02 -0700, Guenter Roeck wrote:
> On Thu, May 26, 2011 at 05:27:27AM -0400, Per Dal=E9n wrote:
> > Changed according to the suggestions from Guenter Roeck:
> >=20
> > * Check the manufacturer ID directly. Fastens the test if it's not a
> > Maxim chip.
> > * Read the other non-existing registers after the manufacturer ID.
> >=20
> > ---
> >=20
> > This patch adds detection of MAX6642 to sensors-detect.
> >=20
> > Signed-off-by: Per Dalen <per.dalen@appeartv.com>
>=20
> Looks good to me. Jean, any comments, especially regarding the detection =
strength ?
> If not I'll apply it.

Busy at work right now, will take a look in the evening.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
