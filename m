From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2012 08:40:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (coretemp) Drop dependency on PCI for TjMax detection on Atom CP
Message-Id: <20121012104032.039d4c5f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 10 Oct 2012 11:13:19 -0700, Guenter Roeck wrote:
> On Wed, Oct 10, 2012 at 07:00:39AM -0700, Guenter Roeck wrote:
> > On Wed, Oct 10, 2012 at 03:44:56PM +0200, Jean Delvare wrote:
> > [ ... ]
> > >=20
> > > Documentation/hwmon/coretemp says 125=B0C for Atom 230 and 330. N5xx
> > > aren't listed in this document BTW.
> > >=20
> > Reminds me ... we have a discrepancy in the code regarding the 230, and=
 use 100
> > degrees C instead of 125 for it. Any idea where this is documented ?

The 125=B0C TjMax for the Atom 230 was documented by Chen Gong in
f3cffe4d (August 2010.)

> > I wasn't
> > able to find definite numbers over the weekend, and I don't recall why =
I used
> > 100 for the 230 when I introduced tjmax_table.

I think we simply never bothered special-casing the Atom 230/330. I
suppose they can't be detected by CPUID so we would need string name
matching.

> Followup on this after some more digging. Datasheets actually claim Tjmax=
 for
> both 230 and 330 to be 90 degrees C. 125 degrees C is the shutdown temper=
ature,
> which is different (the N4xx/D4xx/D5xx also have a shutdown temperature o=
f 125
> degrees C). We do know that we have to use Tjmax of 125 C for the 330 for=
 somewhat
> reasonable temperature readings. So the big remaining question is which
> temperature is used as calibration point for the 230.

I don't know, sorry. My parents do have an Atom 230-based system
though, I can take a look next time I visit them if you want.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
