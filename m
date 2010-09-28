From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Sep 2010 01:12:06 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if
Message-Id: <20100928011206.GA5159@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
 <20100927125946.GB2862@elte.hu>
 <AANLkTinPHP8WhoAZQqcmhotEfFa6=mG_Acy+xCBQ0_5+@mail.gmail.com>
 <20100927232716.GB4744@ericsson.com>
 <AANLkTinDkJu2MSJM6bUpWJoB2XOD4LLf6GTPBX39wteD@mail.gmail.com>
 <20100928002634.GA5030@ericsson.com>
 <AANLkTi=m5ZtWhQ6Z69WPUkyvcqhmL1ewG1gZ0HUQB3LE@mail.gmail.com>
In-Reply-To: <AANLkTi=m5ZtWhQ6Z69WPUkyvcqhmL1ewG1gZ0HUQB3LE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

On Mon, Sep 27, 2010 at 09:00:59PM -0400, Linus Torvalds wrote:
> On Mon, Sep 27, 2010 at 5:26 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> >
> > Not that simple. cpu_sibling_mask() =A0is defined in asm/smp.h, which i=
s only
> > included from linux/smp.h if SMP is defined. But many other files do in=
clude
> > asm/smp.h directly. This causes the following error all over the place
> > if CONFIG_SMP is not defined.
>=20
> Yeah, that's broken.  Seriously broken.
>=20
> And I guess that if you had happened to include <asm/smp.h> in
> coretemp.c you would magically have gotten that cpu_sibling_map()
> thing, and it would just work - by mistake.
>=20
Figured.

> And maybe that's the correct (and really hacky) fix right now. Rather

Yes, that is actually what I am testing right now.

> than introduce an UP-only cpu_sibling_mask(), get the SMP version, and
> get it ignored.
>=20
> Seriously broken, but there it is.
>=20
> In the long run, I guess we should either
>  - disallow naked '<asm/smp.h>' includes
> OR
>  - just make '<linux/smp.h>' unconditionally include <asm/smp.h>
>=20
> to at least not have that insane "some things exist in CONFIG_SMP or
> not depending on how you include files".
>

Guess so.

You should get another patch in a few minutes, after my next set of compile=
s is done.
I'll wait for some feedback before pushing it into my integration branch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
