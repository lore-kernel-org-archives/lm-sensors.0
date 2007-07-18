From: "Roger Lucas" <roger@planbit.co.uk>
Date: Wed, 18 Jul 2007 19:57:31 +0000
Subject: Re: [lm-sensors] No longer reviewing random hwmon patches
Message-Id: <006401c7c975$e02d99f0$8001a8c0@wolverine>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070718201409.1c1077d0@hyperion.delvare>
In-Reply-To: <20070718201409.1c1077d0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-sen=
sors.org] On Behalf Of
> Hans-J=FCrgen Koch
> Sent: 18 July 2007 20:27
> To: lm-sensors@lm-sensors.org
> Cc: Mark M. Hoffman
> Subject: Re: [lm-sensors] No longer reviewing random hwmon patches
>=20
> Am Mittwoch 18 Juli 2007 20:14 schrieb Jean Delvare:
> > Hi all,
> >
> > Twice in the past 2 weeks, I have been criticized for being too
> > demanding in my hwmon patch reviews. I have been told that I was
> > wasting developers' time and taking the fun away from them. Well, I am
> > also no longer having fun reviewing patches when I am "rewarded" this
> > way. Not that reviewing patches is really fun to start with, you
> > usually don't receive much thank nor praise, but receiving criticism is
> > going one step too far.
>=20
> I absolutely agree. And I don't think you're wasting anybodies time.
> I remember when you sent me back my max6650 patch 16 times. I still
> think that this was no waste of time. It is now clean code which follows
> a clean concept. A waste of time would have been to merge my first
> version. It would have wasted the time of an unknown number of unknown
> programmers in the future, who would have to deal with bad code
> and violations of the hwmon sysfs specifications.
>=20
> So, as I said before, I thank you for _your_ time and that you
> made it possible for me to contribute a piece of _good_ code so
> _my_ time was not wasted.
>=20

I absolutely agree.  If I am to run code on my systems, I want to be sure t=
hat it has been thoroughly reviewed by
whoever was responsible.  When I submitted my vt8231 driver, Jean was very =
thorough with his review, and I *appreciated*
this.

One of the problems with Linux's wider acceptance is that more and more peo=
ple want to get involved.  This isn't a bad
thing in itself, but just because someone wants to help doesn't mean that t=
heir contribution must automatically be
accepted.  The reason Linux is growing in popularity is because it is so re=
liable.  People who want to have their code
should recognise this and accept that the standards for acceptace of code a=
re high and are set by the reviewer, not the
submitter.

If you cannot take criticism of your code when you want to get it submitted=
 into a larger system then it is you that has
the issues, not the reviewer or the review process.  I don't want to run co=
de on my systems that has been through some
half-assed or incomplete review process.  I want to be confident that the c=
ode is written well and reviewed properly.

With Jean's attitude and dilligence, the review process was done properly. =
 He never criticised code for the sake of it
- every criticism was valid and relevant. =20

> >
> > It has been suggested that I should review patches differently and
> > accept more divergence from what I consider the right way. This isn't
> > going to happen, sorry. Given that I am not paid for the job, nobody
> > gets to tell me which patches I should review and how. But I also don't
> > want to cause contributors to leave the project.
>=20
> If a "contributor" wants to leave because his crappy code is rejected,
> I say: Good riddance! hwmon is a subsystem where most of the people
> don't have the hardware to test a driver, so bugs can stay there for
> a long time. That's why I find it especially important to have strict
> reviews before something gets merged.

Agreed.  If you are a prima donna with your code and either too arrogant or=
 stupid to accept valid criticism then I for
one don't want to run it  - I don't trust code written by someone with that=
 attitude!

>=20
> >
> > As a consequence, I have decided to change my behavior with regards to
> > the patches which are posted to the lm-sensors list. I will no longer
> > review random patches.
>=20
> I understand your point of view.
>=20
> > I will only review patches meeting any of the
> > following conditions:
> > * I asked for that patch.
> > * The patch is for a hwmon driver I am maintaining.
> > * The author explicitly asked me to review his/her work, and I feel
> >   like it.
> > * Mark asked me to review the patch.
> >
> > Hopefully this will prevent further tensions from arising.
> >
>=20
> Actually, I think this is a big loss for hwmon. I'd still be glad if
> you reviewed my patches (there will be more soon).
>=20
> Thanks,
> Hans
>=20

Jean, you have my support and my respect for your hard work and skills.  If=
 others around you don=92t realise what you
bring then it just shows how much they still have to learn.

I just hope that lm-sensors' code quality doesn't slowly degrade over time =
if the review process is relaxed.  Please
Mark H., follow Jean's prior practice at enforcing thorough reviews before =
accepting code into the kernel.

- Roger Lucas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
