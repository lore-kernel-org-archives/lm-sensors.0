From: MrBill <cruznredrune@gmail.com>
Date: Wed, 06 Oct 2010 20:15:17 +0000
Subject: Re: [lm-sensors] Asus P7p55D motherboard sensor issues
Message-Id: <AANLkTikwL5Zgr3BZsPs7YDxpMgB7OZaug1+tXY--ziiT@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8411453428101553490=="
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
In-Reply-To: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8411453428101553490==
Content-Type: multipart/alternative; boundary=20cf30223de5a5e0810491f86f75

--20cf30223de5a5e0810491f86f75
Content-Type: text/plain; charset=ISO-8859-1

Thanks again.  When you said to grab the asus file from a newer kernel are
you telling me to load 11.3 and copy the file or is there somewhere on the
net I can download the file.  I have tried to download the asus_atk0110 file
before and did not have much success.
I do have the source files loaded for my kernel.

Thanks

On Wed, Oct 6, 2010 at 4:06 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:

> Plaese use reply all :)
>
> On Wed, Oct 6, 2010 at 9:42 PM, MrBill <cruznredrune@gmail.com> wrote:
> > Thanks for the reply.
> >
> > Im running Suse 11.2 64 with the Asus P7P55D MB.
> > The asus_atk0110.c file is from sept 2009.
> > lsmod shows the asus_atk0110.c driver is loaded.
> >
> > Im seeing this in my messages file:  ATK0110 ATK0110:00:
> atk_read_value_new:
> > ACPI exception: AE_BUFFER_OVERFLOW
>
> Ah, that :) Yes, it's a known bug.
>
> > In reading someone said to add acpi_enforce_resources=lax to my
> > /boot/grub/menu.lst file.
>
> No, that a different thing: it allows the user to load native drivers
> (which potentially dangerous).
>
> > You mentioned to take a copy of it from a newer kernel and compile.  I
> have
> > not done that.  If you have any docs on that please let me know.
> > I've seen many forums talking about this and wanted to know if you had
> any
> > suggestions on this.
>
> Grab the driver from a newer kernel and put it somewhere, then create
> a simple Makefile:
>
> obj-m += asus_atk0110.o
>
> and compile with:
>
> make -C /lib/modules/$(uname -r)/source O=/lib/modules/$(uname
> -r)/build M=$(pwd)
>
> You'll need the kernel sources installed (it should be either
> kernel-default-devel or kernel-desktop-devel depending on which kernel
> you're running).
>
> Luca
>

--20cf30223de5a5e0810491f86f75
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks again.=A0 When you said to grab the asus file from a newer kernel ar=
e you telling me to load 11.3 and copy the file or is there somewhere on th=
e net I can download the file.=A0 I have tried to download the asus_atk0110=
 file before and did not have much success.<br>
I do have the source files loaded for my kernel.<br><br>Thanks<br><br><div =
class=3D"gmail_quote">On Wed, Oct 6, 2010 at 4:06 PM, Luca Tettamanti <span=
 dir=3D"ltr">&lt;<a href=3D"http://kronos.it">kronos.it</a>@<a href=3D"http=
://gmail.com">gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Plaese use reply =
all :)<br>
<div class=3D"im"><br>
On Wed, Oct 6, 2010 at 9:42 PM, MrBill &lt;<a href=3D"mailto:cruznredrune@g=
mail.com">cruznredrune@gmail.com</a>&gt; wrote:<br>
&gt; Thanks for the reply.<br>
&gt;<br>
&gt; Im running Suse 11.2 64 with the Asus P7P55D MB.<br>
&gt; The asus_atk0110.c file is from sept 2009.<br>
&gt; lsmod shows the asus_atk0110.c driver is loaded.<br>
&gt;<br>
&gt; Im seeing this in my messages file:=A0 ATK0110 ATK0110:00: atk_read_va=
lue_new:<br>
&gt; ACPI exception: AE_BUFFER_OVERFLOW<br>
<br>
</div>Ah, that :) Yes, it&#39;s a known bug.<br>
<div class=3D"im"><br>
&gt; In reading someone said to add acpi_enforce_resources=3Dlax to my<br>
&gt; /boot/grub/menu.lst file.<br>
<br>
</div>No, that a different thing: it allows the user to load native drivers=
<br>
(which potentially dangerous).<br>
<div class=3D"im"><br>
&gt; You mentioned to take a copy of it from a newer kernel and compile.=A0=
 I have<br>
&gt; not done that.=A0 If you have any docs on that please let me know.<br>
&gt; I&#39;ve seen many forums talking about this and wanted to know if you=
 had any<br>
&gt; suggestions on this.<br>
<br>
</div>Grab the driver from a newer kernel and put it somewhere, then create=
<br>
a simple Makefile:<br>
<br>
obj-m +=3D asus_atk0110.o<br>
<br>
and compile with:<br>
<br>
make -C /lib/modules/$(uname -r)/source O=3D/lib/modules/$(uname<br>
-r)/build M=3D$(pwd)<br>
<br>
You&#39;ll need the kernel sources installed (it should be either<br>
kernel-default-devel or kernel-desktop-devel depending on which kernel<br>
you&#39;re running).<br>
<font color=3D"#888888"><br>
Luca<br>
</font></blockquote></div><br>

--20cf30223de5a5e0810491f86f75--


--===============8411453428101553490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8411453428101553490==--
