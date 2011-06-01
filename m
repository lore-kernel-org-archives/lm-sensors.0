From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jun 2011 09:40:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Relax target temperature
Message-Id: <20110601114058.4845b563@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110531215051.663df5ef@endymion.delvare>
In-Reply-To: <20110531215051.663df5ef@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Fenghua,

On Tue, 31 May 2011 15:56:11 -0700, Yu, Fenghua wrote:
> > On Tue, 2011-05-31 at 17:39 -0400, Yu, Fenghua wrote:
> > > I check the SDM about the MSR_TEMPERATURE_TARGET register. My
> > > understanding is if the MSR is implemented, its bits 16..23 have the
> > > Temperature Target. Otherwise it's a hardware bug.

This doesn't seem to be the case in practice, see below.

> > > There is no spec for the Temperature Target range in SDM (can you
> > > find one?). Whatever range we put in coretemp is just speculation.
> > > Strictly speaking, we shouldn't have the range check.

I tend to agree.

> > I'd be somewhat hesitant to make such a change right away. Maybe we can
> > replace the check with a check against 0 and display a warning (or even
> > an error) if it reads 0. Would that make sense ?

Almost, except that I don't think we should complain about value 0, see
below.

> After a CPU model comes out, the number of Temperature Target is fixed fo=
r whatever value. If that value doesn't meet design spec, it could be:
> 1. a design issue which should be detected and fixed during internal desi=
gn validation;
> 2. a manufacture issue which should be detected and fixed during manufact=
ure process.
>=20
> There is no spec to claim 0 is wrong for bits 16..23. Check against 0 is =
still a speculation. If checking against 0, why not check against 1, 2, etc?

0 is different because it is what unused/unimplemented MSR bits return.
I have 3 supported CPUs here for my testing: family 6 model 0xe (Core
Duo) in a laptop, family 6 model 0xf (Core2 Duo) in a desktop and
family 6 model 0x1a in a workstation (Xeon).

On model 0xe, reading from MSR 0x1a2 return an I/O error. On model 0xf,
the MSR exists, but reading from it returns 0 for bits 23:16. On model
0x1a, it returns a valid temperature limit in bits 23:16 (97=B0C).

>=20
> Without any spec guidline, a sanity checking on the bits is trying to cap=
ture either a hardware design bug or a hardware manufacture bug. This is no=
t based on any spec. And the effort is very likely fruitless.
>=20
> A lot of similar places in kernel don't do sanity checking, e.g. bits 0..=
15 in MSR_IA32_PERF_STATUS.

I would be perfectly happy to not have any sanity check on the value,
but this requires that we know upfront which CPU models have bits 23:16
of MSR 0x1a2 implemented, and which do not. As my experiment above
shows, some models have the MSR implemented but not bits 23:16, and
checking for value 0 is the only way to handle them in a generic way.

According to the SDM, MSR 0x1a2 is supposed to only exist in Nehalem
(i.e. family 6 model 0x1a) and Sandy Bridge CPUs (family and model
unknown to me) but I guess it will also exist in future CPUs.

I see two possible implementations:

1* Go by the SDM. First check that we are on a model which supports
MSR_TEMPERATURE_TARGET before calling it, and always trust the result.
For other models, use the heuristic we had before (adjust_tjmax). The
major drawback is that we will have to update the list of CPU models
supporting MSR_TEMPERATURE_TARGET as they are released by Intel. We
just went away from having to continuously maintain a device list in
the coretemp driver and it seems wrong to go back to this situation
again.

2* Go by my experimental result. Read MSR_TEMPERATURE_TARGET
unconditionally, but only use the result if there was no I/O error and
the value isn't 0. In other cases, don't emit any warning message and
simply fallback to the heuristic we had before (adjust_tjmax). This is
closer to what we have at the moment, and has the advantage that it
won't require further updates.

Implementation 2 clearly has my favors.

For stable kernel series, I'd rather just apply the patch I submitted,
because it is the least intrusive option and we aren't aware of any
actual system requiring a more intrusive fix.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
