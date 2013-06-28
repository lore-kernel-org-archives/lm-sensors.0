From: Robert Coulson <rob.coulson@gmail.com>
Date: Fri, 28 Jun 2013 13:45:50 +0000
Subject: Re: [lm-sensors] [lm-sensors 1/2] hwmon: (ds1621) Add ds1721 chip support
Message-Id: <CAEZKy8KD21ZUE8YR0NU2DimrCXXagvKgdkxDW_S5QDcnbezf4g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6179814843479156685=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
To: lm-sensors@vger.kernel.org

--===============6179814843479156685==
Content-Type: multipart/alternative; boundary=089e012940b8ca2bbf04e03718f5

--089e012940b8ca2bbf04e03718f5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Again, thank you both. (-:


On Fri, Jun 28, 2013 at 6:41 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Jun 28, 2013 at 02:05:26PM +0200, Jean Delvare wrote:
> > On Thu, 27 Jun 2013 10:12:51 -0700, Guenter Roeck wrote:
> > > On Thu, Jun 27, 2013 at 10:36:31AM +0200, Jean Delvare wrote:
> > > > This breaks limit rounding on the DS1621. Limits have a resolution =
of
> > > > 0.5=B0C on that chip, so limit values should rounded to the closest
> > > > half-degree. It used to work but no longer: if I write 20300 to
> > > > temp1_min, it is rounded down to 20000, while it should be rounded =
up
> > > > to 20500.
> > >
> > > Can you test the following patch ? It follows the logic implemented i=
n
> the
> > > tmp401 driver.
> >
> > Tested OK, thanks :)
> >
> > Tested-by: Jean Delvare <khali@linux-fr.org>
> >
> > And as the code looks sane too:
> >
> > Acked-by: Jean Delvare <khali@linux-fr.org>
> >
> Thanks, to keep simple I'll add it on top of my -next tree instead of
> merging it.
>
> Guenter
>

--089e012940b8ca2bbf04e03718f5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Again, thank you both. (-:</div><div class=3D"gmail_extra"=
><br><br><div class=3D"gmail_quote">On Fri, Jun 28, 2013 at 6:41 AM, Guente=
r Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On F=
ri, Jun 28, 2013 at 02:05:26PM +0200, Jean Delvare wrote:<br>
&gt; On Thu, 27 Jun 2013 10:12:51 -0700, Guenter Roeck wrote:<br>
&gt; &gt; On Thu, Jun 27, 2013 at 10:36:31AM +0200, Jean Delvare wrote:<br>
&gt; &gt; &gt; This breaks limit rounding on the DS1621. Limits have a reso=
lution of<br>
&gt; &gt; &gt; 0.5=B0C on that chip, so limit values should rounded to the =
closest<br>
&gt; &gt; &gt; half-degree. It used to work but no longer: if I write 20300=
 to<br>
&gt; &gt; &gt; temp1_min, it is rounded down to 20000, while it should be r=
ounded up<br>
&gt; &gt; &gt; to 20500.<br>
&gt; &gt;<br>
&gt; &gt; Can you test the following patch ? It follows the logic implement=
ed in the<br>
&gt; &gt; tmp401 driver.<br>
&gt;<br>
&gt; Tested OK, thanks :)<br>
&gt;<br>
&gt; Tested-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khal=
i@linux-fr.org</a>&gt;<br>
&gt;<br>
&gt; And as the code looks sane too:<br>
&gt;<br>
&gt; Acked-by: Jean Delvare &lt;<a href=3D"mailto:khali@linux-fr.org">khali=
@linux-fr.org</a>&gt;<br>
&gt;<br>
</div></div>Thanks, to keep simple I&#39;ll add it on top of my -next tree =
instead of merging it.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div>

--089e012940b8ca2bbf04e03718f5--


--===============6179814843479156685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6179814843479156685==--
