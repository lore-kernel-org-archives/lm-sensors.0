From: Justin Chudgar <justin@justinzane.com>
Date: Sun, 23 Aug 2009 00:35:22 +0000
Subject: Re: [lm-sensors] Harald's C7 temp driver
Message-Id: <200908221735.22457.justin@justinzane.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2596950322635316206=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200908220023.34028.justin@justinzane.com>
In-Reply-To: <200908220023.34028.justin@justinzane.com>
To: lm-sensors@vger.kernel.org

--===============2596950322635316206==
Content-Type: multipart/alternative; boundary="Boundary-01=_K7IkKO3EAsMRWHr"
Content-Transfer-Encoding: 7bit

--Boundary-01=_K7IkKO3EAsMRWHr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks, Lu! That worked as advertised.

With the addition of '* 1000', sensors is reporting seemingly accurate data.

Now, what remains is merging Harald's temperature algorithm with Juerg's=20
voltage algorithm. I was planning on creating a module called via_c7temp wi=
th=20
the working parts of both Harald's and Juerg's work. However, I do not know=
 if=20
that is the appropriate thing to do.

Since this was initially Juerg's baby, (and since Juerg is much better at t=
his=20
than I ;) ) would you like to handle it? Or direct me in making the needed=
=20
changes?
=20
=2D-=20

Justin Chudgar
Information Technology Consultant
5040 Saddlehorn Rd, Weed, CA 96084
530-938-9692 (Home Office)

On Saturday 22 August 2009 02:16:16 am you wrote:
> Dear Justin,
>
>          Harald had a updated version of via_cputemp,
>
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> index 1032355..2abe516 100644
> --- a/drivers/hwmon/via-cputemp.c
> +++ b/drivers/hwmon/via-cputemp.c
> @@ -37,7 +37,7 @@
>  #include <asm/msr.h>
>  #include <asm/processor.h>
>
> -#define DRVNAME        "via-cputemp"
> +#define DRVNAME        "via_cputemp"
>
>  typedef enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;
>
> @@ -81,7 +81,7 @@ static ssize_t show_temp(struct device *dev,
>        if (err)
>                return -EAGAIN;
>
> -       err =3D sprintf(buf, "%d\n", eax & 0xffffff);
> +       err =3D sprintf(buf, "%d\n", (eax & 0xffffff) * 1000);
>
>        return err;
>  }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>        Had you try it?
>        Just a remind.
>
> 2009/8/22 Justin Chudgar <justin@justinzane.com>:
> > I've been messing (clumsily, since I am learning C while doing this...
> > please be patient with me :) with Harald's via_cputemp.ko driver and ha=
ve
> > noticed that while I do not get readings using his driver as is, some
> > printk's added into his code show that there is a reading being obtaine=
d.
> >
> > Here is some sample output:
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1: +57.0=B0C (crit =3D +105.0=B0C)
> >
> > c7temp-isa-0000
> > Adapter: ISA adapter
> > in0: +0.84 V
> > temp1: +0.0=B0C
> >
> > via_cputemp-isa-0000
> > Adapter: ISA adapter
> > Core 0: +0.1=B0C
> >
> > root@justin-mininote:/lib/modules/2.6.31-rc6justin/kernel/drivers/hwmon#
> > dmesg | tail
> > [28068.954298] TEMP: 53
> > [28075.767438] show_temp: 3
> > [28075.767451] CPU: 0, MSR: 1169, eax: 35, edx: 0, err: 3
> > [28075.767459] TEMP: 53
> > [28096.575734] show_temp: 3
> > [28096.575746] CPU: 0, MSR: 1169, eax: 37, edx: 0, err: 3
> > [28096.575753] TEMP: 55
> > [28156.787908] show_temp: 3
> > [28156.787920] CPU: 0, MSR: 1169, eax: 38, edx: 0, err: 3
> > [28156.787928] TEMP: 56
> >
> > As you can see, the dmesg log shows a CPU temp that tracks with but does
> > not exactly duplicate the ACPI temp. To me, this means that I am probab=
ly
> > getting good data.
> >
> > The function in question is show_temp on lines 69-86 in the attached
> > code. If someone can help me understand how the string buffer 'buf' with
> > the temperature reading is supposed to be passed on to userland code, I=
'd
> > appreciate it.
> >
> > Once again, please be patient as I am NOT a programmer, just a guy with=
 a
> > C7 cpu who want to get lm-sensors working.
> >
> > Thanks.
> >
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--Boundary-01=_K7IkKO3EAsMRWHr
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd"><html><head><meta name=3D"qrichtext" content=3D"1" /><st=
yle type=3D"text/css">p, li { white-space: pre-wrap; }</style></head><body =
style=3D" font-family:'DejaVu Serif'; font-size:8pt; font-weight:400; font-=
style:normal;">Thanks, Lu! That worked as advertised.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>With the addition of '* 1000', sensors is reporting s=
eemingly accurate data.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Now, what remains is merging Harald's temperature alg=
orithm with Juerg's voltage algorithm. I was planning on creating a module =
called via_c7temp with the working parts of both Harald's and Juerg's work.=
 However, I do not know if that is the appropriate thing to do.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Since this was initially Juerg's baby, (and since Jue=
rg is much better at this than I ;) ) would you like to handle it? Or direc=
t me in making the needed changes?<br>
 <br />-- <br /><br>
<span style=3D" font-family:'betecknalowercasebold';">Justin Chudgar</span>=
<br>
Information Technology Consultant<br>
5040 Saddlehorn Rd, Weed, CA 96084<br>
530-938-9692 (Home Office)<br>
<br />On Saturday 22 August 2009 02:16:16 am you wrote:<br>
&gt; Dear Justin,<br>
&gt;<br>
&gt;          Harald had a updated version of via_cputemp,<br>
&gt;<br>
&gt;         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c=
<br>
&gt; index 1032355..2abe516 100644<br>
&gt; --- a/drivers/hwmon/via-cputemp.c<br>
&gt; +++ b/drivers/hwmon/via-cputemp.c<br>
&gt; @@ -37,7 +37,7 @@<br>
&gt;  #include &lt;asm/msr.h&gt;<br>
&gt;  #include &lt;asm/processor.h&gt;<br>
&gt;<br>
&gt; -#define DRVNAME        "via-cputemp"<br>
&gt; +#define DRVNAME        "via_cputemp"<br>
&gt;<br>
&gt;  typedef enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME } SHOW;<br>
&gt;<br>
&gt; @@ -81,7 +81,7 @@ static ssize_t show_temp(struct device *dev,<br>
&gt;        if (err)<br>
&gt;                return -EAGAIN;<br>
&gt;<br>
&gt; -       err =3D sprintf(buf, "%d\n", eax &amp; 0xffffff);<br>
&gt; +       err =3D sprintf(buf, "%d\n", (eax &amp; 0xffffff) * 1000);<br>
&gt;<br>
&gt;        return err;<br>
&gt;  }<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;<br>
&gt;        Had you try it?<br>
&gt;        Just a remind.<br>
&gt;<br>
&gt; 2009/8/22 Justin Chudgar &lt;justin@justinzane.com&gt;:<br>
&gt; &gt; I've been messing (clumsily, since I am learning C while doing th=
is...<br>
&gt; &gt; please be patient with me :) with Harald's via_cputemp.ko driver =
and have<br>
&gt; &gt; noticed that while I do not get readings using his driver as is, =
some<br>
&gt; &gt; printk's added into his code show that there is a reading being o=
btained.<br>
&gt; &gt;<br>
&gt; &gt; Here is some sample output:<br>
&gt; &gt; acpitz-virtual-0<br>
&gt; &gt; Adapter: Virtual device<br>
&gt; &gt; temp1: +57.0=B0C (crit =3D +105.0=B0C)<br>
&gt; &gt;<br>
&gt; &gt; c7temp-isa-0000<br>
&gt; &gt; Adapter: ISA adapter<br>
&gt; &gt; in0: +0.84 V<br>
&gt; &gt; temp1: +0.0=B0C<br>
&gt; &gt;<br>
&gt; &gt; via_cputemp-isa-0000<br>
&gt; &gt; Adapter: ISA adapter<br>
&gt; &gt; Core 0: +0.1=B0C<br>
&gt; &gt;<br>
&gt; &gt; root@justin-mininote:/lib/modules/2.6.31-rc6justin/kernel/drivers=
/hwmon#<br>
&gt; &gt; dmesg | tail<br>
&gt; &gt; [28068.954298] TEMP: 53<br>
&gt; &gt; [28075.767438] show_temp: 3<br>
&gt; &gt; [28075.767451] CPU: 0, MSR: 1169, eax: 35, edx: 0, err: 3<br>
&gt; &gt; [28075.767459] TEMP: 53<br>
&gt; &gt; [28096.575734] show_temp: 3<br>
&gt; &gt; [28096.575746] CPU: 0, MSR: 1169, eax: 37, edx: 0, err: 3<br>
&gt; &gt; [28096.575753] TEMP: 55<br>
&gt; &gt; [28156.787908] show_temp: 3<br>
&gt; &gt; [28156.787920] CPU: 0, MSR: 1169, eax: 38, edx: 0, err: 3<br>
&gt; &gt; [28156.787928] TEMP: 56<br>
&gt; &gt;<br>
&gt; &gt; As you can see, the dmesg log shows a CPU temp that tracks with b=
ut does<br>
&gt; &gt; not exactly duplicate the ACPI temp. To me, this means that I am =
probably<br>
&gt; &gt; getting good data.<br>
&gt; &gt;<br>
&gt; &gt; The function in question is show_temp on lines 69-86 in the attac=
hed<br>
&gt; &gt; code. If someone can help me understand how the string buffer 'bu=
f' with<br>
&gt; &gt; the temperature reading is supposed to be passed on to userland c=
ode, I'd<br>
&gt; &gt; appreciate it.<br>
&gt; &gt;<br>
&gt; &gt; Once again, please be patient as I am NOT a programmer, just a gu=
y with a<br>
&gt; &gt; C7 cpu who want to get lm-sensors working.<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; lm-sensors mailing list<br>
&gt; &gt; lm-sensors@lm-sensors.org<br>
&gt; &gt; http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p></body></html>
--Boundary-01=_K7IkKO3EAsMRWHr--


--===============2596950322635316206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2596950322635316206==--
