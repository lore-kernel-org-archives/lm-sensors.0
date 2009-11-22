From: Allen Edwards <allen.p.edwards@gmail.com>
Date: Sun, 22 Nov 2009 21:47:24 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <39eba8470911221347v52cb7e3cvfa03c5fa6c563509@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4964976124053223992=="
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4964976124053223992==
Content-Type: multipart/alternative; boundary=0016364d309bb284210478fca8f4

--0016364d309bb284210478fca8f4
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Nov 22, 2009 at 10:52 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Sun, 22 Nov 2009 08:57:18 -0800, Allen Edwards wrote:
> > On Sun, Nov 22, 2009 at 8:35 AM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > > You forgot to install flex and bison, and our build system isn't
> > > exactly user-friendly. After you do, run "make clean" then "make"
> again.
> > >
> > > That being said... pwmconfig is a shell script, it doesn't need to be
> > > built.
> >
> > Actually, I did install both of these programs as the documentation is
> > pretty clear on that.
> >
> > dad@myth_desktop:~/lm_sensors-3.1.1$ bison --version
> > bison (GNU Bison) 2.3
> > Written by Robert Corbett and Richard Stallman.
> >
> > Copyright (C) 2006 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is
> NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.
> >
> > dad@myth_desktop:~/lm_sensors-3.1.1$ flex  --version
> > flex 2.5.34
>
> Did you run "make clean" before running "make" again after installing
> flex and bison? This is required.
>
> If you did and it did not help, please provide a full build log and
> I'll look at it.
>
>
With your help all is working and the fan noise cannot be heard from across
the room.  The "make clean" did the trick.  Thanks so much for your help.

I have a small follow-up question.  I searched for a long time looking for
how to start fancontrol automatically.  All I found was a rather elaborate
script here: http://ubuntuforums.org/showthread.php?t=42737 but it looked
old (2005) and the paths didn't look correct so I didn't use it.

I put a line in my rc.local file "/usr/local/sbin/fancontrol" and all seems
well.

Is this acceptable?

Allen

--0016364d309bb284210478fca8f4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sun, Nov 22, 2009 at 10:52 AM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im">On Sun, 22 Nov 2009 08:57:18 -0800, Allen Edwards wrote:<=
br>
&gt; On Sun, Nov 22, 2009 at 8:35 AM, Jean Delvare &lt;<a href=3D"mailto:kh=
ali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; You forgot to install flex and bison, and=
 our build system isn&#39;t<br>
&gt; &gt; exactly user-friendly. After you do, run &quot;make clean&quot; t=
hen &quot;make&quot; again.<br>
&gt; &gt;<br>
&gt; &gt; That being said... pwmconfig is a shell script, it doesn&#39;t ne=
ed to be<br>
&gt; &gt; built.<br>
&gt;<br>
</div><div class=3D"im">&gt; Actually, I did install both of these programs=
 as the documentation is<br>
&gt; pretty clear on that.<br>
&gt;<br>
&gt; dad@myth_desktop:~/lm_sensors-3.1.1$ bison --version<br>
&gt; bison (GNU Bison) 2.3<br>
&gt; Written by Robert Corbett and Richard Stallman.<br>
&gt;<br>
&gt; Copyright (C) 2006 Free Software Foundation, Inc.<br>
&gt; This is free software; see the source for copying conditions. =A0There=
 is NO<br>
&gt; warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE.<br>
&gt;<br>
&gt; dad@myth_desktop:~/lm_sensors-3.1.1$ flex =A0--version<br>
&gt; flex 2.5.34<br>
<br>
</div>Did you run &quot;make clean&quot; before running &quot;make&quot; ag=
ain after installing<br>
flex and bison? This is required.<br>
<br>
If you did and it did not help, please provide a full build log and<br>
I&#39;ll look at it.<br><font class=3D"Apple-style-span" color=3D"#888888">=
<br></font></blockquote><div><br></div><div>With your help all is working a=
nd the fan noise cannot be heard from across the room. =A0The &quot;make cl=
ean&quot; did the trick. =A0Thanks so much for your help.</div>

<div><br></div><div>I have a small follow-up question. =A0I searched for a =
long time looking for how to start fancontrol automatically. =A0All I found=
 was a rather elaborate script here:=A0<a href=3D"http://ubuntuforums.org/s=
howthread.php?t=3D42737">http://ubuntuforums.org/showthread.php?t=3D42737</=
a>=A0but it looked old (2005) and the paths didn&#39;t look correct so I di=
dn&#39;t use it.</div>

<div><br></div><div>I put a line in my rc.local file &quot;/usr/local/sbin/=
fancontrol&quot; and all seems well. =A0</div><div><br></div><div>Is this a=
cceptable?</div><div><br></div><div>Allen</div><div><br></div><div><br></di=
v>

<div>=A0</div></div>

--0016364d309bb284210478fca8f4--


--===============4964976124053223992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4964976124053223992==--
