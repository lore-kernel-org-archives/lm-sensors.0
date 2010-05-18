From: Dmitry Gromov <gromovd@gmail.com>
Date: Tue, 18 May 2010 06:45:03 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current
Message-Id: <AANLkTimQnaUvXs75rpTOcW7CODXWgUfzekY9FCDa5S8P@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3319913875925957719=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100517094136.094800562@osadl.org>
In-Reply-To: <20100517094136.094800562@osadl.org>
To: lm-sensors@vger.kernel.org

--===============3319913875925957719==
Content-Type: multipart/alternative; boundary=001636e907d49c21030486d8af8c

--001636e907d49c21030486d8af8c
Content-Type: text/plain; charset=ISO-8859-1

Hi!

On Tue, May 18, 2010 at 01:07, Wan, Huaxu <huaxu.wan@intel.com> wrote:

>  Hi,
>
> The TjMax of N270 is 90C, according the official documents [1][2].
>
> .
> [1]
> http://ark.intel.com/Product.aspx?id=36331&processor=N270&spec-codes=SLB73
> [2]http://download.intel.com/design/processor/datashts/319977.pdf
>
> Thanks
> Huaxu
>
> Thank you, this is exactly why I;m asking. I think, "guessing" values here
can be dangerous - who knows what critical apps they will relied upon.

And 90C seems to be good for N200 series of Atom CPUs only - I could not
find TjMax value published for N330 Dual Core  (quite popular one). Intel
only published Tcase for it:
http://ark.intel.com/Product.aspx?id=35641
So, if for N270 Tcase = TjMax = 90C, then, I'd suggest to use Tcase = 85.2C
for N330 TjMax value.


-- 
DG
NJ

--001636e907d49c21030486d8af8c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font color=3D"#3333ff"><font size=3D"2"><font face=3D"georgia,serif">Hi!<b=
r></font></font></font><br><div class=3D"gmail_quote">On Tue, May 18, 2010 =
at 01:07, Wan, Huaxu <span dir=3D"ltr">&lt;<a href=3D"mailto:huaxu.wan@inte=
l.com">huaxu.wan@intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">



<div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial">Hi,</font></div>
<div><font face=3D"Arial"></font>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial">The TjMax of N270 is 9=
0C, according the=20
official documents [1][2].</font></div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial"><br>.<br>[1]<a href=3D=
"http://ark.intel.com/Product.aspx?id=3D36331&amp;processor=3DN270&amp;spec=
-codes=3DSLB73" target=3D"_blank">http://ark.intel.com/Product.aspx?id=3D36=
331&amp;processor=3DN270&amp;spec-codes=3DSLB73</a><br>

[2]<a href=3D"http://download.intel.com/design/processor/datashts/319977.pd=
f" target=3D"_blank">http://download.intel.com/design/processor/datashts/31=
9977.pdf</a></font></div>
<div>=A0</div>
<div dir=3D"ltr" align=3D"left"><font face=3D"Arial">Thanks<br>Huaxu</font>=
</div><br></div></blockquote><div>Thank you, this is exactly why I;m asking=
. I think, &quot;guessing&quot; values here can be dangerous - who knows wh=
at critical apps they will relied upon.<br>

<br>And 90C seems to be good for N200 series of Atom CPUs only - I could no=
t find TjMax value published for N330 Dual Core=A0 (quite popular one). Int=
el only published Tcase for it:<br><a href=3D"http://ark.intel.com/Product.=
aspx?id=3D35641">http://ark.intel.com/Product.aspx?id=3D35641</a><br>

So, if for N270 Tcase =3D TjMax =3D 90C, then, I&#39;d suggest to use Tcase=
 =3D 85.2C for N330 TjMax value.<br><br>=A0<br></div></div>-- <br>DG<br>NJ<=
br><br>

--001636e907d49c21030486d8af8c--


--===============3319913875925957719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3319913875925957719==--
