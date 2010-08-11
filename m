From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 11 Aug 2010 21:15:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <AANLkTinZ7XALgPnpVNQSgqM3Ay=38tM8SDYoyUY+39i+@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1107016220697416618=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100707145841.58052281@hyperion.delvare>
In-Reply-To: <20100707145841.58052281@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============1107016220697416618==
Content-Type: multipart/alternative; boundary=0016364c7c1fe810a7048d92bfc1

--0016364c7c1fe810a7048d92bfc1
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 11, 2010 at 6:59 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Jim,
>
> On Sat, 7 Aug 2010 05:23:20 -0600, Jim Cromie wrote:
> > On Wed, Jul 7, 2010 at 6:58 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >
> > > It's not OK to call platform_device_add_resources() multiple times
> > > in a row. Despite its name, this functions sets the resources, it
> > > doesn't add them. So we have to prepare an array with all the
>

snip


> > I applied this patch, and it built w/o errors.
>
> Howver I have some distro (voyage 0.6.5) vs kernel issues
> > to resolve before I have a solid testing env.
> > It looks like 2.6.35 doesnt like udev 145, which shipped along with
> 2.6.30
> > kernel
> >
> > [   11.252182] udev: starting version 145
> > [   11.252232] <3>udev: missing sysfs features; please update the kernel
> or
> > disable the kernel's CONFIG_SYSFS_DEPRECATED option; udev may fail to
> work
> > correctly
>
> I can't help you much with this, I'm afraid. Just try what they say...
>
> FTR - udev 145 is added into the initramfs file from my laptop,
not from voyage-linux.  So I should be able to fix this and test soon.

 > In the meantime, it looks like res_count isnt initialized before 1st use.

> >
> > Oddly, gcc doesnt complain about this,
> > is this somehow hidden by zeroed memory due to __init on the function ??
>
> This is indeed a bug, thanks a lot for finding and reporting it. It's
> fixed now.
>
>
WRT lack of uninit-var warning,

[jimc@harpo sk1]$ make V=1 drivers/hwmon/pc87360.ko
...
  gcc -Wp,-MD,drivers/hwmon/.pc87360.o.d  -nostdinc -isystem
/usr/lib/gcc/i686-redhat-linux/4.4.4/include
-I/home/jimc/lx/linux-2.6.git/arch/x86/include -Iinclude
 -I/home/jimc/lx/linux-2.6.git/include -include include/generated/autoconf.h
 -I/home/jimc/lx/linux-2.6.git/drivers/hwmon -Idrivers/hwmon -D__KERNEL__
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -Werror-implicit-function-declaration -Wno-format-security
-fno-delete-null-pointer-checks -Os -m32 -msoft-float -mregparm=3
-freg-struct-return -mpreferred-stack-boundary=2 -march=pentium-mmx
-mtune=generic -Wa,-mtune=generic32 -ffreestanding -DCONFIG_AS_CFI=1
-DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -pipe
-Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx
-mno-sse2 -mno-3dnow -Wframe-larger-than=1024 -fno-stack-protector
-fno-omit-frame-pointer -fno-optimize-sibling-calls
-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
-fconserve-stack  -DMODULE -D"KBUILD_STR(s)=#s"
-D"KBUILD_BASENAME=KBUILD_STR(pc87360)"
 -D"KBUILD_MODNAME=KBUILD_STR(pc87360)"  -c -o drivers/hwmon/pc87360.o
/home/jimc/lx/linux-2.6.git/drivers/hwmon/pc87360.c
make -f /home/jimc/lx/linux-2.6.git/scripts/Makefile.modpost
  scripts/mod/modpost   -o /home/jimc/lx/sk1/Module.symvers    -S   -s
WARNING: modpost: Found 21 section mismatch(es).

-Wuninitialized  is not in there (explaining lack of warnings)

is this a local config problem, or has it somehow dropped out of the Kconfig
process ?
or was it never in there (seems unlikely) ?

also, regarding your patch, is there a real need for res_count at all ?
IOW, why not this (abbreviated) ?

- res[res_count].start = extra_isa[i];
+ res[i].start = extra_isa[i];
...
- err = platform_device_add_resources(pdev, res, res_count);
+ err = platform_device_add_resources(pdev, res, --i);

--0016364c7c1fe810a7048d92bfc1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 11, 2010 at 6:59 AM, Jean De=
lvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@lin=
ux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hi Jim,<br>
<div class=3D"im"><br>
On Sat, 7 Aug 2010 05:23:20 -0600, Jim Cromie wrote:<br>
&gt; On Wed, Jul 7, 2010 at 6:58 AM, Jean Delvare &lt;<a href=3D"mailto:kha=
li@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; It&#39;s not OK to call platform_device_add_resources() multiple =
times<br>
&gt; &gt; in a row. Despite its name, this functions sets the resources, it=
<br>
&gt; &gt; doesn&#39;t add them. So we have to prepare an array with all the=
<br></div></blockquote><div><br></div><div>snip</div><div>=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex;">
<div class=3D"im">&gt; I applied this patch, and it built w/o errors.=A0</d=
iv></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im">&gt; Howv=
er I have some distro (voyage 0.6.5) vs kernel issues<br>

&gt; to resolve before I have a solid testing env.<br>
&gt; It looks like 2.6.35 doesnt like udev 145, which shipped along with 2.=
6.30<br>
&gt; kernel<br>
&gt;<br>
&gt; [ =A0 11.252182] udev: starting version 145<br>
&gt; [ =A0 11.252232] &lt;3&gt;udev: missing sysfs features; please update =
the kernel or<br>
&gt; disable the kernel&#39;s CONFIG_SYSFS_DEPRECATED option; udev may fail=
 to work<br>
&gt; correctly<br>
<br>
</div>I can&#39;t help you much with this, I&#39;m afraid. Just try what th=
ey say...<br>
<div class=3D"im"><br></div></blockquote><div>FTR - udev 145 is added into =
the initramfs file from my laptop,=A0</div><div>not from voyage-linux. =A0S=
o I should be able to fix this and test soon.</div><div><br></div><div>=A0&=
gt; In the meantime, it looks like res_count isnt initialized before 1st us=
e.</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">
&gt;<br>&gt; Oddly, gcc doesnt complain about this,<br>
&gt; is this somehow hidden by zeroed memory due to __init on the function =
??<br>
<br>
</div>This is indeed a bug, thanks a lot for finding and reporting it. It&#=
39;s<br>
fixed now.<br>
<br></blockquote><div><br></div><div>WRT lack of uninit-var warning,</div><=
div><br></div><div><div>[jimc@harpo sk1]$ make V=3D1 drivers/hwmon/pc87360.=
ko</div></div><div>...</div><div><div>=A0=A0gcc -Wp,-MD,drivers/hwmon/.pc87=
360.o.d =A0-nostdinc -isystem /usr/lib/gcc/i686-redhat-linux/4.4.4/include =
-I/home/jimc/lx/linux-2.6.git/arch/x86/include -Iinclude =A0-I/home/jimc/lx=
/linux-2.6.git/include -include include/generated/autoconf.h =A0-I/home/jim=
c/lx/linux-2.6.git/drivers/hwmon -Idrivers/hwmon -D__KERNEL__ -Wall -Wundef=
 -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werro=
r-implicit-function-declaration -Wno-format-security -fno-delete-null-point=
er-checks -Os -m32 -msoft-float -mregparm=3D3 -freg-struct-return -mpreferr=
ed-stack-boundary=3D2 -march=3Dpentium-mmx -mtune=3Dgeneric -Wa,-mtune=3Dge=
neric32 -ffreestanding -DCONFIG_AS_CFI=3D1 -DCONFIG_AS_CFI_SIGNAL_FRAME=3D1=
 -DCONFIG_AS_CFI_SECTIONS=3D1 -pipe -Wno-sign-compare -fno-asynchronous-unw=
ind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -Wframe-larger-than=3D102=
4 -fno-stack-protector -fno-omit-frame-pointer -fno-optimize-sibling-calls =
-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fcons=
erve-stack =A0-DMODULE -D&quot;KBUILD_STR(s)=3D#s&quot; -D&quot;KBUILD_BASE=
NAME=3DKBUILD_STR(pc87360)&quot; =A0-D&quot;KBUILD_MODNAME=3DKBUILD_STR(pc8=
7360)&quot; =A0-c -o drivers/hwmon/pc87360.o /home/jimc/lx/linux-2.6.git/dr=
ivers/hwmon/pc87360.c</div>
<div>make -f /home/jimc/lx/linux-2.6.git/scripts/Makefile.modpost</div><div=
>=A0=A0scripts/mod/modpost =A0 -o /home/jimc/lx/sk1/Module.symvers =A0 =A0-=
S =A0 -s</div><div>WARNING: modpost: Found 21 section mismatch(es).</div></=
div><div>
<br></div><div>-Wuninitialized =A0is not in there (explaining lack of warni=
ngs)</div><div><br></div><div>is this a local config problem, or has it som=
ehow dropped out of the Kconfig process ?</div><div>or was it never in ther=
e (seems unlikely) ?</div>
<div><br></div><div>also, regarding your patch, is there a real need for re=
s_count at all ?</div><div><div>IOW, why not this (abbreviated) ?</div><div=
><br></div><div>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
	</span>res[res_count].start =3D extra_isa[i];</div>
</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space: pre; ">		<=
/span>res[i].start =3D extra_isa[i];</div><div><div>...</div><div>-<span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">	</span>err =3D platform_d=
evice_add_resources(pdev, res, res_count);</div>
</div><div><div><div>+<span class=3D"Apple-tab-span" style=3D"white-space: =
pre; ">	</span>err =3D platform_device_add_resources(pdev, res, --i);</div>=
</div></div><div><br></div></div>

--0016364c7c1fe810a7048d92bfc1--


--===============1107016220697416618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1107016220697416618==--
