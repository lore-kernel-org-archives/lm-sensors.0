From: Marcelo De Cicco <decicco10@gmail.com>
Date: Sat, 05 Feb 2011 13:09:06 +0000
Subject: Re: [lm-sensors] SUSE, 10.2
Message-Id: <AANLkTi=CEnycVVTOgHnQTaRbDkLMgBn0UvL5CZ3YrsY9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2515421975241055339=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikLRKrsr7M2C9+qJry6Qn-C5KHuSgv5mXmxOUj8@mail.gmail.com>
In-Reply-To: <AANLkTikLRKrsr7M2C9+qJry6Qn-C5KHuSgv5mXmxOUj8@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2515421975241055339==
Content-Type: multipart/alternative; boundary=0023547c9a1d17d8eb049b88b44a

--0023547c9a1d17d8eb049b88b44a
Content-Type: text/plain; charset=ISO-8859-1

Hi Jean,

I tryed sensor-detect, after a lot of "YES", and writing rc* file as
recommended,  I stopped at this point


"Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
insserv: script suse.pbs_mom: service pbs_mom already provided!
insserv: script suse.pbs_sched: service pbs_sched already provided!
insserv: script pbs_server: service pbs_server already provided!"



2011/2/5 Jean Delvare <khali@linux-fr.org>

> On Sat, 5 Feb 2011 10:04:13 -0200, Marcelo De Cicco wrote:
> > Hi people,
> >
> > How do I install de lms sensor? I have downloaded the package, but I do
> not
> > know how to install and configure it.  Our system is a cluster - SGI:
> > headnode -   XE 320, with 8 nodes (6 XE 320 and 2 XE 340), with MPI. OS
> SUSE
> > 10.2
>
> lm-sensors is already packaged for Suse distributions, install package
> "sensors", and optionally "sensord" if you need it, and you're done.
> Then run "sensors-detect" and follow the instructions.
>
> --
> Jean Delvare
>



-- 
Marcelo De Cicco

** "Antes de imprimir, pense no Meio Ambiente e nos Custos"
*
" THE MORE PROGRESS PHYSICAL SCIENCES MAKE, THE MORE THEY TEND TO ENTER
 THE DOMAIN OF MATHEMATICS, WHICH IS A KIND OF CENTRE TO WHICH THEY ALL
 CONVERGE.  WE MAY EVEN JUDGE THE DEGREE OF PERFECTION TO WHICH A
 SCIENCE HAS ARRIVED BY THE FACILITY WITH WHICH IT MAY BE SUBMITTED
 TO CALCULATION" . -- ADOLPHE QUETELET, 1796-1874

--0023547c9a1d17d8eb049b88b44a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jean,<br><br>I tryed sensor-detect, after a lot of &quot;YES&quot;, and =
writing rc* file as recommended,=A0 I stopped at this point<br><br><br>&quo=
t;Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES<br>insse=
rv: script suse.pbs_mom: service pbs_mom already provided!<br>
insserv: script suse.pbs_sched: service pbs_sched already provided!<br>inss=
erv: script pbs_server: service pbs_server already provided!&quot;<br><br><=
br><br><div class=3D"gmail_quote">2011/2/5 Jean Delvare <span dir=3D"ltr">&=
lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span><=
br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>On Sat, 5 Feb 2011 10:04:13 -0200, Marcelo De Cicco wrote:<br>
&gt; Hi people,<br>
&gt;<br>
&gt; How do I install de lms sensor? I have downloaded the package, but I d=
o not<br>
&gt; know how to install and configure it. =A0Our system is a cluster - SGI=
:<br>
&gt; headnode - =A0 XE 320, with 8 nodes (6 XE 320 and 2 XE 340), with MPI.=
 OS SUSE<br>
&gt; 10.2<br>
<br>
</div>lm-sensors is already packaged for Suse distributions, install packag=
e<br>
&quot;sensors&quot;, and optionally &quot;sensord&quot; if you need it, and=
 you&#39;re done.<br>
Then run &quot;sensors-detect&quot; and follow the instructions.<br>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Marcelo De Cicco=
<br><br><b><span style=3D"border-collapse: separate; color: rgb(0, 0, 0); f=
ont-family: &#39;Times New Roman&#39;; font-style: normal; font-variant: no=
rmal; font-weight: normal; letter-spacing: normal; line-height: normal; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; font-size: medium;">* &quot;Antes de imprimir, pense no Meio Ambiente e n=
os Custos<span>&quot;</span></span><br>
</b><br>&quot; THE MORE PROGRESS PHYSICAL SCIENCES MAKE, THE MORE THEY TEND=
 TO ENTER<br>=A0THE DOMAIN OF MATHEMATICS, WHICH IS A KIND OF CENTRE TO WHI=
CH THEY ALL<br>=A0CONVERGE.=A0 WE MAY EVEN JUDGE THE DEGREE OF PERFECTION T=
O WHICH A<br>
=A0SCIENCE HAS ARRIVED BY THE FACILITY WITH WHICH IT MAY BE SUBMITTED<br>=
=A0TO CALCULATION&quot; . -- ADOLPHE QUETELET, 1796-1874<br>

--0023547c9a1d17d8eb049b88b44a--


--===============2515421975241055339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2515421975241055339==--
