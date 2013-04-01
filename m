From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Mon, 01 Apr 2013 11:21:50 +0000
Subject: Re: [lm-sensors] [PATCH v7 0/5] Add ST-Ericsson AB8500 HWMON driver
Message-Id: <CAJLyvQy96sJqBoG_KqAUb1kUMXw82kx3Ni2Lkv9ssSBpwRAgtA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0172868691090127837=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1364368412-12810-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364368412-12810-1-git-send-email-hongbo.zhang@linaro.org>
To: lm-sensors@vger.kernel.org

--===============0172868691090127837==
Content-Type: multipart/alternative; boundary=f46d042ef753bf1aaf04d94ad330

--f46d042ef753bf1aaf04d94ad330
Content-Type: text/plain; charset=ISO-8859-1

On 31 March 2013 07:13, Anton Vorontsov <anton@enomsg.org> wrote:

> Hi Hongbo,
>
> On Wed, Mar 27, 2013 at 03:13:27PM +0800, Hongbo Zhang wrote:
> [...]
> > Hongbo Zhang (5):
> >   ab8500_btemp: make ab8500_btemp_get* interfaces public
> >   ab8500: power: eliminate CamelCase warning of some variables
> >   ab8500: power: add const attributes to some data arrays
> >   ab8500: power: export abx500_res_to_temp tables for hwmon
> >   hwmon: add ST-Ericsson ABX500 hwmon driver
> >
> >  Documentation/hwmon/ab8500           |  22 ++
> >  Documentation/hwmon/abx500           |  28 ++
> >  drivers/hwmon/Kconfig                |  13 +
> >  drivers/hwmon/Makefile               |   1 +
> >  drivers/hwmon/ab8500.c               | 206 +++++++++++++++
> >  drivers/hwmon/abx500.c               | 491
> +++++++++++++++++++++++++++++++++++
> >  drivers/hwmon/abx500.h               |  69 +++++
> >  drivers/power/ab8500_bmdata.c        |  42 +--
> >  drivers/power/ab8500_btemp.c         |   5 +-
> >  drivers/power/ab8500_fg.c            |   4 +-
> >  include/linux/mfd/abx500.h           |   6 +-
> >  include/linux/mfd/abx500/ab8500-bm.h |   5 +
> >  include/linux/power/ab8500.h         |  16 ++
> >  13 files changed, 885 insertions(+), 23 deletions(-)
>
> The patches look good to me, but I wonder how would you like to proceed
> with them? The thing is, it touches ab8500 code quite a lot, and since
> battery-2.6 tree already has a lot of ab8500 changes, your patches
> conflict quite badly.
>
> Personally, I would like to take them all via battery-2.6.git tree to
> avoid the conflicts, but for this I will need you to rebase the patches
> onto it.
>
> Thanks!
>
> Anton
>
> p.s. I couldn't apply the patches neither on v3.8, nor v3.9-rc4 nor on my
> current battery-2.6.git tree... :-/
>

Yes the ab8500 codes are changed frequently.
As I said in another thread I'd like to rebase my patches to your
 battery-2.6.git.
Thanks.

--f46d042ef753bf1aaf04d94ad330
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On 31 March 2013 07:13, Anton Vorontsov <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:anton@enomsg.org" target=3D"_blank">anton@enomsg.org</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hi Hongbo,<br>
<br>
On Wed, Mar 27, 2013 at 03:13:27PM +0800, Hongbo Zhang wrote:<br>
[...]<br>
<div class=3D"im">&gt; Hongbo Zhang (5):<br>
&gt; =A0 ab8500_btemp: make ab8500_btemp_get* interfaces public<br>
&gt; =A0 ab8500: power: eliminate CamelCase warning of some variables<br>
&gt; =A0 ab8500: power: add const attributes to some data arrays<br>
&gt; =A0 ab8500: power: export abx500_res_to_temp tables for hwmon<br>
&gt; =A0 hwmon: add ST-Ericsson ABX500 hwmon driver<br>
&gt;<br>
&gt; =A0Documentation/hwmon/ab8500 =A0 =A0 =A0 =A0 =A0 | =A022 ++<br>
&gt; =A0Documentation/hwmon/abx500 =A0 =A0 =A0 =A0 =A0 | =A028 ++<br>
&gt; =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A013 +<br>
&gt; =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 1 +<br>
&gt; =A0drivers/hwmon/ab8500.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 206 ++++++++++=
+++++<br>
&gt; =A0drivers/hwmon/abx500.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 491 ++++++++++=
+++++++++++++++++++++++++<br>
&gt; =A0drivers/hwmon/abx500.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A069 +++++<br=
>
&gt; =A0drivers/power/ab8500_bmdata.c =A0 =A0 =A0 =A0| =A042 +--<br>
&gt; =A0drivers/power/ab8500_btemp.c =A0 =A0 =A0 =A0 | =A0 5 +-<br>
&gt; =A0drivers/power/ab8500_fg.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 4 +-<br>
&gt; =A0include/linux/mfd/abx500.h =A0 =A0 =A0 =A0 =A0 | =A0 6 +-<br>
&gt; =A0include/linux/mfd/abx500/ab8500-bm.h | =A0 5 +<br>
&gt; =A0include/linux/power/ab8500.h =A0 =A0 =A0 =A0 | =A016 ++<br>
&gt; =A013 files changed, 885 insertions(+), 23 deletions(-)<br>
<br>
</div>The patches look good to me, but I wonder how would you like to proce=
ed<br>
with them? The thing is, it touches ab8500 code quite a lot, and since<br>
battery-2.6 tree already has a lot of ab8500 changes, your patches<br>
conflict quite badly.<br>
<br>
Personally, I would like to take them all via battery-2.6.git tree to<br>
avoid the conflicts, but for this I will need you to rebase the patches<br>
onto it.<br>
<br>
Thanks!<br>
<span class=3D""><font color=3D"#888888"><br>
Anton<br>
</font></span><br>
p.s. I couldn&#39;t apply the patches neither on v3.8, nor v3.9-rc4 nor on =
my<br>
current battery-2.6.git tree... :-/<br>
</blockquote></div><div class=3D"gmail_extra"><br></div>Yes the ab8500 code=
s are changed frequently.</div><div class=3D"gmail_extra" style>As I said i=
n another thread I&#39;d like to rebase my patches to your =A0battery-2.6.g=
it.</div>
<div class=3D"gmail_extra" style>Thanks.</div><div class=3D"gmail_extra" st=
yle><br></div></div>

--f46d042ef753bf1aaf04d94ad330--


--===============0172868691090127837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0172868691090127837==--
