From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 May 2011 13:52:15 +0000
Subject: Re: [lm-sensors] [PATCH v2] MAX6642: Better detection schema
Message-Id: <20110526135215.GB29291@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE50E5.5040902@appeartv.com>
In-Reply-To: <4DDE50E5.5040902@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, May 26, 2011 at 09:08:53AM -0400, Per Dal=E9n wrote:
> Changed according to the suggestions from Guenter Roeck:
>=20
> * Check the manufacturer ID directly. Fastens the test if it's not a
> Maxim chip.
> * Read the other non-existing registers after the manufacturer ID.
>=20
> ---
> Check for non-existing registers, registers 0x04, 0x06 and 0xff, which
> are supported by other Maxim chips. Reading such registers returns the
> previously read value.
>=20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>

Applied, with a couple of spelling errors fixed.

> ---

On a side note, your comments from above should go here. As written, the co=
mments
end up in the commit log, but the description and your signature don't.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
