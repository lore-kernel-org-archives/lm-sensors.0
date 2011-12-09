From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 09 Dec 2011 21:47:34 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <20111209214734.GB19801@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
In-Reply-To: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Dec 09, 2011 at 03:12:50PM -0500, Bj=F6rn Gerhart wrote:
> Hi Guenter,
>=20
> 2011/12/8 Guenter Roeck <guenter.roeck@ericsson.com>:
> > Hi Bjoern,
> >=20
> > On Thu, Dec 08, 2011 at 05:04:54PM -0500, Bjoern Gerhart wrote:
> >> Hi Guenter,
> >>=20
> >> so for solving the other issues you mentioned, I'd first apply your
> >> set of 4 patches on the original f75375s. Then I'd implement my f75387
> >> related modifications within your latest review proposals, test the
> >> resulting binary module on my f75387 hardware and then create a fifth
> >> patch.
> >>=20
> >> Would that order lead to a valid set of patches?
> >>=20
> > Yes, that would be the best way to proceed, only it is 5 patches by now.
> > Did I copy you on the last one ?
> >=20
> Yes - today I noticed that I already had received your latest (fifth) f75=
375s related patch.
>=20
> > If you use git, it should be straightforward to merge your patch on top=
 of mine.
> > I would have done that, only I had trouble applying yours because it wa=
s somehow
> > corrupted.
> >=20
> I'm not quite familiar with using git yet, so up to now using the classic=
al diff / patch commands for creating and applying patches. It seems that t=
he googlemail web interface inserts line feeds after about 70 characters, w=
hich leads to the corrupted patch. I try another mail client for the next p=
atch to send...
>=20
> > Of course, it would also help tremendously if you would fine the time t=
o review
> > my patches :).
> >=20
> Yeah, I reviewed each of the f75375s related patches. Beside the function=
ality stuff and improved error handling I noticed some guideline related im=
provements also. But in fact I could not detect nonconformities or code fus=
siness, so there's no idea for improvements on my side.
>=20

Hi Bjoern,

things are a bit more formal in Linux land.

After you reviewed a patch, and you are happy with it, reply to it by adding

Acked-by: Your Name <your_email@somewhere>

or

Reviewed-by: Your Name <your_email@somewhere>

right under the Signed-off: line.

Before you do that, read Documentation/SubmittingPatches, chapter 13 (using=
 Acked-by)=20
and chapter 14 (using Reviewed-by) to understand what it means.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
