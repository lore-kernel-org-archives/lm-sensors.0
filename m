From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Jun 2011 09:31:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Further relax
Message-Id: <20110608113127.1e348c9b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
In-Reply-To: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 6 Jun 2011 07:48:15 -0700, Guenter Roeck wrote:
> On Mon, Jun 06, 2011 at 09:57:53AM -0400, Jean Delvare wrote:
> > While we're here, I don't quite get the rationale for having separate
> > functions get_tjmax() and get_pkg_tjmax(). They do pretty much the
> > same, don't they? Except that get_pkg_tjmax defaults to 100=B0C when
> > get_tjmax calls adjust_tjmax(). This seems wrong, even though I guess
> > it makes no difference in practice as adjust_tjmax() should only be
> > needed for older CPU models without the package temperature sensor.
>
> That was my assumption as well.

For now I'll submit a patch dropping get_pkg_tjmax, as this seems
desirable regardless of the rest.

> > Going one step further, if MSR_IA32_TEMPERATURE_TARGET is the right MSR
> > for the package TjMax, then this pretty much means that this MSR (or at
> > least bits 23:16 in it) is not per-core but per-package (it will return
> > the same value on every core.) Then why are we calling get_tjmax (and
> > then adjust_tjmax) on every core if the result will always be the same?
> > This seems conceptually wrong and expensive.
>
> I have not really thought about it myself, but that seems to be likely.
>=20
> > So I would suggest that we move tjmax to struct pdev_entry, and only
> > fetch it once from MSR_IA32_TEMPERATURE_TARGET. This would also solve a
>=20
> Makes sense to me, though I'd like to get input from Fenghua if your anal=
ysis
> is correct.

I have investigated this a little further, and have questions / action
items for Fenghua and Durgadoss (or anyone else at Intel...)

The Software Developer's Manual says that MSR 1A2h has scope "Thread"
for Nehalem, but scope "Unique" for Sandy Bridge.

1* "Unique" isn't a valid scope value for a Sandy Bridge MSR. It should
   be one of "Package", "Core" or "Thread". "Unique" is only used for
   Pentium 4 and Atom models. This should be fixed by whoever is
   responsible for the document at Intel.

2* "Thread" seems wrong for Nehalem. Experience shows that thermal
   sensors are per-core [1], so I would expect scope "Core" for
   MSR_TEMPERATURE_TARGET. I would love to have confirmation from
   someone at Intel, and documentation fixed if needs be.

[1] See commit d883b9f0977269d519469da72faec6a7f72cb489,
    "hwmon: (coretemp) Skip duplicate CPU entries".

3* Assuming that "Unique" becomes "Package" for Sandy Bridge, this can
   mean two things: either the MSR was actually changed from
   per-thread/core to per-package when Sandy Bridge was developed, or
   it was already per-package in Nehalem and documentation is wrong. I
   would love to have someone at Intel clarify this point, and
   documentation fixed if needs be.

4* Regardless of the technically correct answer to point 3 above, I
   have never seen any multi-core CPU supported by the coretemp driver
   report different tjmax values for different cores. Did anyone ever
   see this? If not, I would feel comfortable reading tjmax from
   MSR_TEMPERATURE_TARGET only once per package for all models. This
   would make driver initialization faster.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
