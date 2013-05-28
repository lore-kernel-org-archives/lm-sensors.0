From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2013 13:25:55 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon fixes for 3.10-rc2
Message-Id: <CAADWXX-LBwadvbDjPv2sN50BzcGjeewQGCYuz1Cy1-vadWznNg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2754539847812446482=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130515133311.GA14411@roeck-us.net>
In-Reply-To: <20130515133311.GA14411@roeck-us.net>
To: lm-sensors@vger.kernel.org

--===============2754539847812446482==
Content-Type: multipart/alternative; boundary=089e0141aa8a75bdb104ddc7341a

--089e0141aa8a75bdb104ddc7341a
Content-Type: text/plain; charset=UTF-8

I'm going through my spam-box, and find this. Guenter, I don't know what
you've done to piss off gmail, but you should take a look at your email
setup, because if gmail thinks you send spam, I'll have a hard time ever
seeing your messages (and I don't go through spam very often)

          Linus


On Fri, May 17, 2013 at 4:56 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Linus,
>
> I noticed that you did not pull this series of patches.
>
> Did it get lost, is something wrong with it, or am I just impatient ?
>
> Thanks,
> Guenter
>
> On Wed, May 15, 2013 at 06:33:11AM -0700, Guenter Roeck wrote:
> > Hi Linus,
> >
> > Please pull hwmon fixes for Linux 3.10-rc2 from signed tag:
> >
> >     git://
> git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.githwmon-for-linus
> >
> > Thanks,
> > Guenter
> > ------
> >
> > The following changes since commit
> f722406faae2d073cc1d01063d1123c35425939e:
> >
> >   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.gittags/hwmon-for-linus
> >
> > for you to fetch changes up to ecacb0b17c08fae89f65468727f0e4b8e91da4e1:
> >
> >   hwmon: fix error return code in abituguru_probe() (2013-05-13 08:07:13
> -0700)
> >
> > ----------------------------------------------------------------
> > Error path fixes for abituguru and iio_hwmon drivers.
> > Drop erroneously created attributes from nct6775 driver.
> >
> > ----------------------------------------------------------------
> > Axel Lin (2):
> >       hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if
> devm_kzalloc fail
> >       hwmon: (iio_hwmon) Fix null pointer dereference
> >
> > Guenter Roeck (1):
> >       hwmon: (nct6775) Do not create non-existing attributes
> >
> > Wei Yongjun (1):
> >       hwmon: fix error return code in abituguru_probe()
> >
> >  drivers/hwmon/abituguru.c |   16 ++++++++++------
> >  drivers/hwmon/iio_hwmon.c |    8 +++++---
> >  drivers/hwmon/nct6775.c   |    6 ++++--
> >  3 files changed, 19 insertions(+), 11 deletions(-)
>
>
>
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>

--089e0141aa8a75bdb104ddc7341a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m going through my spam-box, and find this. Guenter,=
 I don&#39;t know what you&#39;ve done to piss off gmail, but you should ta=
ke a look at your email setup, because if gmail thinks you send spam, I&#39=
;ll have a hard time ever seeing your messages (and I don&#39;t go through =
spam very often)<div>
<br></div><div style>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Linus</div></div><d=
iv class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, May 17,=
 2013 at 4:56 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:lin=
ux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:=
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Linus,<br>
<br>
I noticed that you did not pull this series of patches.<br>
<br>
Did it get lost, is something wrong with it, or am I just impatient ?<br>
<br>
Thanks,<br>
Guenter<br>
<div><div class=3D"h5"><br>
On Wed, May 15, 2013 at 06:33:11AM -0700, Guenter Roeck wrote:<br>
&gt; Hi Linus,<br>
&gt;<br>
&gt; Please pull hwmon fixes for Linux 3.10-rc2 from signed tag:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/ker=
nel/git/groeck/linux-staging.git" target=3D"_blank">git.kernel.org/pub/scm/=
linux/kernel/git/groeck/linux-staging.git</a> hwmon-for-linus<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Guenter<br>
&gt; ------<br>
&gt;<br>
&gt; The following changes since commit f722406faae2d073cc1d01063d1123c3542=
5939e:<br>
&gt;<br>
&gt; =C2=A0 Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)<br>
&gt;<br>
&gt; are available in the git repository at:<br>
&gt;<br>
&gt; =C2=A0 git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git=
/groeck/linux-staging.git" target=3D"_blank">git.kernel.org/pub/scm/linux/k=
ernel/git/groeck/linux-staging.git</a> tags/hwmon-for-linus<br>
&gt;<br>
&gt; for you to fetch changes up to ecacb0b17c08fae89f65468727f0e4b8e91da4e=
1:<br>
&gt;<br>
&gt; =C2=A0 hwmon: fix error return code in abituguru_probe() (2013-05-13 0=
8:07:13 -0700)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Error path fixes for abituguru and iio_hwmon drivers.<br>
&gt; Drop erroneously created attributes from nct6775 driver.<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Axel Lin (2):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 hwmon: (iio_hwmon) Fix missing iio_channel_releas=
e_all call if devm_kzalloc fail<br>
&gt; =C2=A0 =C2=A0 =C2=A0 hwmon: (iio_hwmon) Fix null pointer dereference<b=
r>
&gt;<br>
&gt; Guenter Roeck (1):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 hwmon: (nct6775) Do not create non-existing attri=
butes<br>
&gt;<br>
&gt; Wei Yongjun (1):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 hwmon: fix error return code in abituguru_probe()=
<br>
&gt;<br>
&gt; =C2=A0drivers/hwmon/abituguru.c | =C2=A0 16 ++++++++++------<br>
&gt; =C2=A0drivers/hwmon/iio_hwmon.c | =C2=A0 =C2=A08 +++++---<br>
&gt; =C2=A0drivers/hwmon/nct6775.c =C2=A0 | =C2=A0 =C2=A06 ++++--<br>
&gt; =C2=A03 files changed, 19 insertions(+), 11 deletions(-)<br>
<br>
<br>
<br>
</div></div>&gt; _______________________________________________<br>
&gt; lm-sensors mailing list<br>
&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org=
</a><br>
&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" ta=
rget=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>=
<br>
<br>
</blockquote></div><br></div>

--089e0141aa8a75bdb104ddc7341a--


--===============2754539847812446482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2754539847812446482==--
