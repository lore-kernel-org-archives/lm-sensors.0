From: Allen Edwards <allen.p.edwards@gmail.com>
Date: Sun, 22 Nov 2009 04:34:35 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <39eba8470911212034p3621f703pf3df8ae869e13538@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0214772811035802328=="
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0214772811035802328==
Content-Type: multipart/alternative; boundary=000325574fb20d5fbc0478ee3b9a

--000325574fb20d5fbc0478ee3b9a
Content-Type: text/plain; charset=ISO-8859-1

lm-sensors 3.0.0, kernel 2.6.24.23-generic  Pardon my stupidity but I do not
know hot to find a version of hwmon.

Allen


On Sat, Nov 21, 2009 at 7:49 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Sat, 21 Nov 2009 07:19:01 -0800, Allen Edwards wrote:
> > I searched back several months of your archives and can't find anything
> > relevant to my problem.  When I run pwmconfig it finds my fans and
> controls
> > the speeds. I can run a characterization of fan speeds vs settings and
> find
> > that 180 is a good speed noise wise.  It is definitely controlling the
> fan
> > speed.  But when it gets to the part about finding the min and max stall
> > speeds, it will not control the fan speed, the fan just stays at full
> speed.
> >  And, of course, fancontrol will not work.  This seems very strange to
> me.
> >  The fan is 3 wire and I have tried it in both a 3 and 4 wire
> controllable
> > header.
>
> And you are using lm-sensors version...? Kernel version...? Hwmon
> drivers...?
>
> --
> Jean Delvare
>

--000325574fb20d5fbc0478ee3b9a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

lm-sensors 3.0.0, kernel 2.6.24.23-generic =A0Pardon my stupidity but I do =
not know hot to find a version of hwmon.<div><br></div><div>Allen</div><div=
><br><br><div class=3D"gmail_quote">On Sat, Nov 21, 2009 at 7:49 AM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On Sat, 2=
1 Nov 2009 07:19:01 -0800, Allen Edwards wrote:<br>
&gt; I searched back several months of your archives and can&#39;t find any=
thing<br>
&gt; relevant to my problem. =A0When I run pwmconfig it finds my fans and c=
ontrols<br>
&gt; the speeds. I can run a characterization of fan speeds vs settings and=
 find<br>
&gt; that 180 is a good speed noise wise. =A0It is definitely controlling t=
he fan<br>
&gt; speed. =A0But when it gets to the part about finding the min and max s=
tall<br>
&gt; speeds, it will not control the fan speed, the fan just stays at full =
speed.<br>
&gt; =A0And, of course, fancontrol will not work. =A0This seems very strang=
e to me.<br>
&gt; =A0The fan is 3 wire and I have tried it in both a 3 and 4 wire contro=
llable<br>
&gt; header.<br>
<br>
</div></div>And you are using lm-sensors version...? Kernel version...? Hwm=
on<br>
drivers...?<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br></div>

--000325574fb20d5fbc0478ee3b9a--


--===============0214772811035802328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0214772811035802328==--
