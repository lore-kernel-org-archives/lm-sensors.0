From: Vahid Keykhaey <vahid.keykhaey@gmail.com>
Date: Tue, 11 Dec 2012 09:38:13 +0000
Subject: Re: [lm-sensors] Fwd: Driver for Bulldozer
Message-Id: <CAMcsHH3ak=7wtyAfu0JgYsDrWCTMtsTL7S5NiCJxAKz4QP1UkQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2803937480736087946=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2803937480736087946==
Content-Type: multipart/alternative; boundary=bcaec50408ecd4ce2504d0907027

--bcaec50408ecd4ce2504d0907027
Content-Type: text/plain; charset=ISO-8859-1

test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir
/lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic
FATAL: Could not open '/lib/modules/3.2.0-23-generic/build/System.map': No
such file or directory
make: *** [modules_install] Error 1



On Tue, Dec 11, 2012 at 4:33 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Tue, 11 Dec 2012 04:20:22 -0500, Vahid Keykhaey wrote:
> > Dear Mr Delvare,
> > Hi,
> > Thank you for the installation instructions, but it did not work. There
> was
> > a problem. At line "make install", I got these:
> > root@user-desktop:~/Desktop# make install
> > test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir
> > /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
> > cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
> > depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map
> 3.2.0-23-generic
> > FATAL: Could not open '/lib/modules/3.2.0-23-generic/build/System.map':
> No
> > such file or directory
> > make: *** [modules_install] Error 1
>
> Your distribution puts the System.map file at a different location.
> I've updated the Makefile, please download it again and it should work
> now.
>
> --
> Jean Delvare
>

--bcaec50408ecd4ce2504d0907027
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir /lib/mo=
dules/3.2.0-23-generic/kernel/drivers/hwmon<br>cp k10temp.ko /lib/modules/3=
.2.0-23-generic/kernel/drivers/hwmon<br>depmod -a -F /lib/modules/3.2.0-23-=
generic/build/System.map 3.2.0-23-generic<br>
FATAL: Could not open &#39;/lib/modules/3.2.0-23-generic/build/System.map&#=
39;: No such file or directory<br>make: *** [modules_install] Error 1<br><b=
r><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Dec=
 11, 2012 at 4:33 AM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:=
khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, 11 Dec 2012 04:20:=
22 -0500, Vahid Keykhaey wrote:<br>
&gt; Dear Mr Delvare,<br>
&gt; Hi,<br>
&gt; Thank you for the installation instructions, but it did not work. Ther=
e was<br>
&gt; a problem. At line &quot;make install&quot;, I got these:<br>
&gt; root@user-desktop:~/Desktop# make install<br>
&gt; test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir<br=
>
&gt; /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon<br>
&gt; cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon<br>
&gt; depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-g=
eneric<br>
&gt; FATAL: Could not open &#39;/lib/modules/3.2.0-23-generic/build/System.=
map&#39;: No<br>
&gt; such file or directory<br>
&gt; make: *** [modules_install] Error 1<br>
<br>
</div>Your distribution puts the System.map file at a different location.<b=
r>
I&#39;ve updated the Makefile, please download it again and it should work<=
br>
now.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div>

--bcaec50408ecd4ce2504d0907027--


--===============2803937480736087946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2803937480736087946==--
