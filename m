From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Wed, 14 Aug 2013 19:06:35 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzS1rK4bQhqM6NWgOsDOz=Lxp+AgtHkN+Gm57Xq1Km-10A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="089e016354b671c6e704e3ed0e7e"
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--089e016354b671c6e704e3ed0e7e
Content-Type: multipart/alternative; boundary=089e016354b671c6e404e3ed0e7c

--089e016354b671c6e404e3ed0e7c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2013 at 2:29 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Aug 14, 2013 at 01:20:57PM -0400, Dev, Kapil wrote:
> > On Wed, Aug 14, 2013 at 1:30 AM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> >
> > > On 08/13/2013 10:17 PM, Kapil Dev wrote:
> > >
> > >>
> > >> On Aug 14, 2013, at 12:56 AM, Guenter Roeck <linux@roeck-us.net>
> wrote:
> > >>
> > >>  On 08/13/2013 08:09 PM, Dev, Kapil wrote:
> > >>>
> > >>>>
> > >>>>
> > >>>> On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck <linux@roeck-us.ne=
t
> <mailto:
> > >>>> linux@roeck-us.net>> wrote:
> > >>>>
> > >>>>     On 08/13/2013 07:41 PM, Dev, Kapil wrote:
> > >>>>
> > >>>>         Thanks again Guenter!
> > >>>>
> > >>>>
> > >>>>
> > >>>>
> > >>>>         On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <
> > >>>> linux@roeck-us.net <mailto:linux@roeck-us.net> <mailto:
> > >>>> linux@roeck-us.net <mailto:linux@roeck-us.net>>> wrote:
> > >>>>
> > >>>>              On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil
> wrote:
> > >>>>               > Thanks for the response Guenter!
> > >>>>               >
> > >>>>               > I put the system on load and I noticed their value
> > >>>> hardly changes. To my
> > >>>>               > surprise, I ran a benchmark for 3 minutes and none
> of
> > >>>> temp*  values changed
> > >>>>               > during execution. The highest reported temperature
> is
> > >>>> always 48C.
> > >>>>               >
> > >>>>               > I was expecting that the internal temperature woul=
d
> > >>>> have "sensor =3D thermal
> > >>>>               > diode" or "sensor =3D core" as a keyword. I though=
t
> > >>>> "sensor=3Dthermistor" means
> > >>>>               > the corresponding sensor is on the motherboard and
> not
> > >>>> the internal
> > >>>>               > die-sensor.
> > >>>>               >
> > >>>>              Sure, but who knows if they put a sensor below the CP=
U
> for
> > >>>> some reason ...
> > >>>>
> > >>>>              I am not familiar with the A10 CPUs. Are those simila=
r
> to
> > >>>> K10 ?
> > >>>>              If so, maybe the k10temp driver works or could be
> extended
> > >>>> to support it.
> > >>>>              Can you give it a try ?
> > >>>>
> > >>>>              If it does not work out of the box, can you send me t=
he
> > >>>> output of "lspci -nn" ?
> > >>>>
> > >>>>
> > >>>>         Kapil: I believe K10 corresponds to A8 seried, and A10 has
> > >>>> Bulldozer architecture (http://www.cpu-world.com/__**
> > >>>> CPUs/Bulldozer/TYPE-A10-__**Series.html<
> http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html><
> > >>>> http://www.cpu-world.com/**CPUs/Bulldozer/TYPE-A10-**Series.html<
> http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>>).
> > >>>> I am not sure how different they are though. I tried K10, but it
> did not
> > >>>> work out of the box. I am looking into k10temp.c driver now. Also,=
I
> am
> > >>>> attaching the output of "lspci -nn" command herewith; you might
> have to
> > >>>> open it using wordpad for proper formatting..
> > >>>>
> > >>>>
> > >>>>     Your lspci output includes
> > >>>>
> > >>>>     00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Devic=
e
> > >>>> [1022:1403]
> > >>>>
> > >>>>     which is supported by the latest k10temp driver. Support was
> added
> > >>>> early last year.
> > >>>>     What is your kernel version, and can you switch to a more rece=
nt
> > >>>> version ?
> > >>>>
> > >>>>
> > >>>> Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel f=
or
> > >>>> k10temp driver to work? Which stable kernel should I upgrade to?
> > >>>>
> > >>>>
> > >>> You need 3.4 or later.
> > >>>
> > >>
> > >> Kapil: I was trying to avoid updating the kernel because my current
> > >> kernel is setup for running different type of benchmarks etc. Seems
> like I
> > >> can't avoid updating the kernel; I will do it..
> > >>
> > >>  Alternative would be to back-port the k10temp driver from a later
> > > kernel. Then you can keep running the old one.
> > >
> > >
> > Kapil: Not sure how to do that. I am already taking the k10temp driver
> from
> > here: http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/ and
> > compiling and using it.
> >
> That version should already have support for your chip unless I am missin=
g
> something. If you already use it, a newer kernel version will not help.
>
> Do you get any kernel log message when you try to load it ?
>

Kapil: When I insert the module using: sudo insmod k10temp.ko, I don't get
any message on terminal. However, when I compile ktemp10.c file using make,
I get following warnings; I am not sure if they are acceptable.
---------------------------------------------------------------------------=
-
make[1]: Entering directory `/usr/src/linux-headers-2.6.39-020639-generic'
  CC [M]  /home/amd_a10/k10temp_driver/k10temp.o
/home//amd_a10/k10temp_driver/k10temp.c:232: warning: data definition has
no type or storage class
/home//amd_a10/k10temp_driver/k10temp.c:232: warning: type defaults to
=91int=92 in declaration of =91module_pci_driver=92
/home//amd_a10/k10temp_driver/k10temp.c:232: warning: parameter names
(without types) in function declaration
/home//amd_a10/k10temp_driver/k10temp.c:225: warning: =91k10temp_driver=92
defined but not used
  Building modules, stage 2.
  MODPOST 1 modules
  CC      /home/amd_a10/k10temp_driver/k10temp.mod.o
  LD [M]  /home/amd_a10/k10temp_driver/k10temp.ko
make[1]: Leaving directory `/usr/src/linux-headers-2.6.39-020639-generic'

I am also attaching the output of "dmesg" command herewith for your
reference.

Thanks,
Kapil


>
> Thanks,
> Guenter
>

--089e016354b671c6e404e3ed0e7c
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 14, 2013 at 2:29 PM, Guenter=
 Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Wed, Aug 14, 2013 at 01:20:57PM =
-0400, Dev, Kapil wrote:<br>
&gt; On Wed, Aug 14, 2013 at 1:30 AM, Guenter Roeck &lt;<a href=3D"mailto:l=
inux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On 08/13/2013 10:17 PM, Kapil Dev wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Aug 14, 2013, at 12:56 AM, Guenter Roeck &lt;<a href=3D"ma=
ilto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0On 08/13/2013 08:09 PM, Dev, Kapil wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck &lt;<=
a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&lt;mailto:<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.=
net</a>&gt;&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 On 08/13/2013 07:41 PM, Dev, Kapil wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 Thanks again Guenter!<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 On Tue, Aug 13, 2013 at 5:51 PM, Guen=
ter Roeck &lt;<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.=
net</a> &lt;mailto:<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net=
</a>&gt; &lt;mailto:<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.=
net</a> &lt;mailto:<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net=
</a>&gt;&gt;&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0On Tue, Aug 13, 2013 at 05=
:11:31PM -0400, Dev, Kapil wrote:<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; Thanks for the respo=
nse Guenter!<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; I put the system on =
load and I noticed their value<br>
&gt; &gt;&gt;&gt;&gt; hardly changes. To my<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; surprise, I ran a be=
nchmark for 3 minutes and none of<br>
&gt; &gt;&gt;&gt;&gt; temp* =A0values changed<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; during execution. Th=
e highest reported temperature is<br>
&gt; &gt;&gt;&gt;&gt; always 48C.<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; I was expecting that=
 the internal temperature would<br>
&gt; &gt;&gt;&gt;&gt; have &quot;sensor =3D thermal<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; diode&quot; or &quot=
;sensor =3D core&quot; as a keyword. I thought<br>
&gt; &gt;&gt;&gt;&gt; &quot;sensor=3Dthermistor&quot; means<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; the corresponding se=
nsor is on the motherboard and not<br>
&gt; &gt;&gt;&gt;&gt; the internal<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; die-sensor.<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0Sure, but who knows if the=
y put a sensor below the CPU for<br>
&gt; &gt;&gt;&gt;&gt; some reason ...<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0I am not familiar with the=
 A10 CPUs. Are those similar to<br>
&gt; &gt;&gt;&gt;&gt; K10 ?<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0If so, maybe the k10temp d=
river works or could be extended<br>
&gt; &gt;&gt;&gt;&gt; to support it.<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0Can you give it a try ?<br=
>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0If it does not work out of=
 the box, can you send me the<br>
&gt; &gt;&gt;&gt;&gt; output of &quot;lspci -nn&quot; ?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 Kapil: I believe K10 corresponds to A=
8 seried, and A10 has<br>
</div></div>&gt; &gt;&gt;&gt;&gt; Bulldozer architecture (<a href=3D"http:/=
/www.cpu-world.com/__**" target=3D"_blank">http://www.cpu-world.com/__**</a=
><br>
&gt; &gt;&gt;&gt;&gt; CPUs/Bulldozer/TYPE-A10-__**Series.html&lt;<a href=3D=
"http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html" target=
=3D"_blank">http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.htm=
l</a>&gt;&lt;<br>

&gt; &gt;&gt;&gt;&gt; <a href=3D"http://www.cpu-world.com/**CPUs/Bulldozer/=
TYPE-A10-**Series.html" target=3D"_blank">http://www.cpu-world.com/**CPUs/B=
ulldozer/TYPE-A10-**Series.html</a>&lt;<a href=3D"http://www.cpu-world.com/=
CPUs/Bulldozer/TYPE-A10-Series.html" target=3D"_blank">http://www.cpu-world=
.com/CPUs/Bulldozer/TYPE-A10-Series.html</a>&gt;&gt;).<br>

<div class=3D"im">&gt; &gt;&gt;&gt;&gt; I am not sure how different they ar=
e though. I tried K10, but it did not<br>
&gt; &gt;&gt;&gt;&gt; work out of the box. I am looking into k10temp.c driv=
er now. Also,I am<br>
&gt; &gt;&gt;&gt;&gt; attaching the output of &quot;lspci -nn&quot; command=
 herewith; you might have to<br>
&gt; &gt;&gt;&gt;&gt; open it using wordpad for proper formatting..<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 Your lspci output includes<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 00:18.3 Host bridge [0600]: Advanced Micro De=
vices [AMD] Device<br>
&gt; &gt;&gt;&gt;&gt; [1022:1403]<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 which is supported by the latest k10temp driv=
er. Support was added<br>
&gt; &gt;&gt;&gt;&gt; early last year.<br>
&gt; &gt;&gt;&gt;&gt; =A0 =A0 What is your kernel version, and can you swit=
ch to a more recent<br>
&gt; &gt;&gt;&gt;&gt; version ?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Kapil: I have 2.6.39-020639-generic kernel. Is it too=
 old kernel for<br>
&gt; &gt;&gt;&gt;&gt; k10temp driver to work? Which stable kernel should I =
upgrade to?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; You need 3.4 or later.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Kapil: I was trying to avoid updating the kernel because my c=
urrent<br>
&gt; &gt;&gt; kernel is setup for running different type of benchmarks etc.=
 Seems like I<br>
&gt; &gt;&gt; can&#39;t avoid updating the kernel; I will do it..<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0Alternative would be to back-port the k10temp driver from =
a later<br>
&gt; &gt; kernel. Then you can keep running the old one.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Kapil: Not sure how to do that. I am already taking the k10temp driver=
 from<br>
&gt; here: <a href=3D"http://khali.linux-fr.org/devel/lm-sensors/drivers/k1=
0temp/" target=3D"_blank">http://khali.linux-fr.org/devel/lm-sensors/driver=
s/k10temp/</a> and<br>
&gt; compiling and using it.<br>
&gt;<br>
</div>That version should already have support for your chip unless I am mi=
ssing<br>
something. If you already use it, a newer kernel version will not help.<br>
<br>
Do you get any kernel log message when you try to load it ?<br></blockquote=
><div><br></div><div>Kapil: When I insert the module using: sudo insmod k10=
temp.ko, I don&#39;t get any message on terminal. However, w<span style=3D"=
background-color:rgb(255,255,255);color:rgb(34,34,34);font-family:arial,san=
s-serif;font-size:12.727272033691406px">hen I compile ktemp10.c file using =
make, I get following warnings; I am not sure if they are acceptable.</span=
></div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.727272033691406px;background-color:rgb(255,255,255)"><div>----------------=
------------------------------------------------------------</div><div>make=
[1]: Entering directory `/usr/src/linux-headers-2.6.39-020639-generic&#39;<=
/div>
<div>=A0 CC [M] =A0/home/amd_a10/k10temp_driver/k10temp.o</div><div>/home//=
amd_a10/k10temp_driver/k10temp.c:232: warning: data definition has no type =
or storage class</div><div>/home//amd_a10/k10temp_driver/k10temp.c:232: war=
ning: type defaults to =91int=92 in declaration of =91module_pci_driver=92<=
/div>
<div>/home//amd_a10/k10temp_driver/k10temp.c:232: warning: parameter names =
(without types) in function declaration</div><div>/home//amd_a10/k10temp_dr=
iver/k10temp.c:225: warning: =91k10temp_driver=92 defined but not used</div=
>
<div>=A0 Building modules, stage 2.</div><div>=A0 MODPOST 1 modules</div><d=
iv>=A0 CC =A0 =A0 =A0/home/amd_a10/k10temp_driver/k10temp.mod.o</div><div>=
=A0 LD [M] =A0/home/amd_a10/k10temp_driver/k10temp.ko</div><div>make[1]: Le=
aving directory `/usr/src/linux-headers-2.6.39-020639-generic&#39;</div>
<div><br></div><div>I am also attaching the output of &quot;dmesg&quot; com=
mand herewith for your reference.</div><div><br></div><div>Thanks,</div><di=
v>Kapil</div></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br>

--089e016354b671c6e404e3ed0e7c--

--089e016354b671c6e704e3ed0e7e
Content-Type: text/plain; charset=US-ASCII; name="dmesg_output.TXT"
Content-Disposition: attachment; filename="dmesg_output.TXT"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkcwu9kz0

WyAgICAwLjAwMDAwMF0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgY3B1c2V0ClsgICAgMC4w
MDAwMDBdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vic3lzIGNwdQpbICAgIDAuMDAwMDAwXSBMaW51
eCB2ZXJzaW9uIDIuNi4zOS0wMjA2MzktZ2VuZXJpYyAocm9vdEB6aW5jKSAoZ2NjIHZlcnNpb24g
NC4yLjMgKFVidW50dSA0LjIuMy0ydWJ1bnR1NykpICMyMDExMDUxOTA5MTEgU01QIFRodSBNYXkg
MTkgMDk6MTQ6MDUgVVRDIDIwMTEKWyAgICAwLjAwMDAwMF0gQ29tbWFuZCBsaW5lOiByb290PVVV
SUQ9MGNlODhlM2MtYWFjNy00NTE2LTk5MTItNzczZGUyYmY0NGE5IHJvIHF1aWV0IHNwbGFzaCAg
Y3Jhc2hrZXJuZWw9Mzg0TS0yRzo2NE1AMTZNLDJHLToxMjhNQDE2TQpbICAgIDAuMDAwMDAwXSBL
RVJORUwgc3VwcG9ydGVkIGNwdXM6ClsgICAgMC4wMDAwMDBdICAgSW50ZWwgR2VudWluZUludGVs
ClsgICAgMC4wMDAwMDBdICAgQU1EIEF1dGhlbnRpY0FNRApbICAgIDAuMDAwMDAwXSAgIENlbnRh
dXIgQ2VudGF1ckhhdWxzClsgICAgMC4wMDAwMDBdIEJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFN
IG1hcDoKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAwMDAwMDAwMCAtIDAwMDAw
MDAwMDAwOWZjMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDAw
MDA5ZmMwMCAtIDAwMDAwMDAwMDAwYTAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAgQklP
Uy1lODIwOiAwMDAwMDAwMDAwMGUwMDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2ZWQpClsg
ICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwMDAxMDAwMDAgLSAwMDAwMDAwMDViYjhj
MDAwICh1c2FibGUpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwNWJiOGMwMDAg
LSAwMDAwMDAwMDViZTY3MDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDog
MDAwMDAwMDA1YmU2NzAwMCAtIDAwMDAwMDAwNWMyMmIwMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAw
MF0gIEJJT1MtZTgyMDogMDAwMDAwMDA1YzIyYjAwMCAtIDAwMDAwMDAwNWM2ZDMwMDAgKEFDUEkg
TlZTKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMDVjNmQzMDAwIC0gMDAwMDAw
MDA1ZDkwZjAwMCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAw
NWQ5MGYwMDAgLSAwMDAwMDAwMDVkOTEwMDAwICh1c2FibGUpClsgICAgMC4wMDAwMDBdICBCSU9T
LWU4MjA6IDAwMDAwMDAwNWQ5MTAwMDAgLSAwMDAwMDAwMDVkYjE2MDAwIChBQ1BJIE5WUykKWyAg
ICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDA1ZGIxNjAwMCAtIDAwMDAwMDAwNWRjNmUw
MDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDogMDAwMDAwMDA1ZGM2ZTAwMCAt
IDAwMDAwMDAwNWU0MzIwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAgQklPUy1lODIwOiAw
MDAwMDAwMDVlNDMyMDAwIC0gMDAwMDAwMDA1ZTQ3MDAwMCAodXNhYmxlKQpbICAgIDAuMDAwMDAw
XSAgQklPUy1lODIwOiAwMDAwMDAwMDVlNDcwMDAwIC0gMDAwMDAwMDA1ZTdmMTAwMCAocmVzZXJ2
ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwNWU3ZjEwMDAgLSAwMDAwMDAw
MDVlODAwMDAwICh1c2FibGUpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwZmVj
MDAwMDAgLSAwMDAwMDAwMGZlYzAxMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1Mt
ZTgyMDogMDAwMDAwMDBmZWMxMDAwMCAtIDAwMDAwMDAwZmVjMTEwMDAgKHJlc2VydmVkKQpbICAg
IDAuMDAwMDAwXSAgQklPUy1lODIwOiAwMDAwMDAwMGZlZDAwMDAwIC0gMDAwMDAwMDBmZWQwMTAw
MCAocmVzZXJ2ZWQpClsgICAgMC4wMDAwMDBdICBCSU9TLWU4MjA6IDAwMDAwMDAwZmVkODAwMDAg
LSAwMDAwMDAwMGZlZDkwMDAwIChyZXNlcnZlZCkKWyAgICAwLjAwMDAwMF0gIEJJT1MtZTgyMDog
MDAwMDAwMDBmZjAwMDAwMCAtIDAwMDAwMDAxMDAwMDAwMDAgKHJlc2VydmVkKQpbICAgIDAuMDAw
MDAwXSBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBwcm90ZWN0aW9uOiBhY3RpdmUKWyAgICAwLjAwMDAw
MF0gRE1JIDIuNyBwcmVzZW50LgpbICAgIDAuMDAwMDAwXSBETUk6IEVDUyBBNzVGMi1BMi9BNzVG
Mi1BMiwgQklPUyA0LjYuNSAwNS8wOC8yMDEzClsgICAgMC4wMDAwMDBdIGU4MjAgdXBkYXRlIHJh
bmdlOiAwMDAwMDAwMDAwMDAwMDAwIC0gMDAwMDAwMDAwMDAxMDAwMCAodXNhYmxlKSA9PT4gKHJl
c2VydmVkKQpbICAgIDAuMDAwMDAwXSBlODIwIHJlbW92ZSByYW5nZTogMDAwMDAwMDAwMDBhMDAw
MCAtIDAwMDAwMDAwMDAxMDAwMDAgKHVzYWJsZSkKWyAgICAwLjAwMDAwMF0gTm8gQUdQIGJyaWRn
ZSBmb3VuZApbICAgIDAuMDAwMDAwXSBsYXN0X3BmbiA9IDB4NWU4MDAgbWF4X2FyY2hfcGZuID0g
MHg0MDAwMDAwMDAKWyAgICAwLjAwMDAwMF0gTVRSUiBkZWZhdWx0IHR5cGU6IHVuY2FjaGFibGUK
WyAgICAwLjAwMDAwMF0gTVRSUiBmaXhlZCByYW5nZXMgZW5hYmxlZDoKWyAgICAwLjAwMDAwMF0g
ICAwMDAwMC05RkZGRiB3cml0ZS1iYWNrClsgICAgMC4wMDAwMDBdICAgQTAwMDAtQkZGRkYgd3Jp
dGUtdGhyb3VnaApbICAgIDAuMDAwMDAwXSAgIEMwMDAwLUNGRkZGIHdyaXRlLXByb3RlY3QKWyAg
ICAwLjAwMDAwMF0gICBEMDAwMC1FN0ZGRiB1bmNhY2hhYmxlClsgICAgMC4wMDAwMDBdICAgRTgw
MDAtRkZGRkYgd3JpdGUtcHJvdGVjdApbICAgIDAuMDAwMDAwXSBNVFJSIHZhcmlhYmxlIHJhbmdl
cyBlbmFibGVkOgpbICAgIDAuMDAwMDAwXSAgIDAgYmFzZSAwMDAwMDAwMDAwMDAgbWFzayBGRkZG
ODAwMDAwMDAgd3JpdGUtYmFjawpbICAgIDAuMDAwMDAwXSAgIDEgYmFzZSAwMDAwNUU4MDAwMDAg
bWFzayBGRkZGRkY4MDAwMDAgdW5jYWNoYWJsZQpbICAgIDAuMDAwMDAwXSAgIDIgYmFzZSAwMDAw
NUYwMDAwMDAgbWFzayBGRkZGRkYwMDAwMDAgdW5jYWNoYWJsZQpbICAgIDAuMDAwMDAwXSAgIDMg
YmFzZSAwMDAwNjAwMDAwMDAgbWFzayBGRkZGRTAwMDAwMDAgdW5jYWNoYWJsZQpbICAgIDAuMDAw
MDAwXSAgIDQgZGlzYWJsZWQKWyAgICAwLjAwMDAwMF0gICA1IGRpc2FibGVkClsgICAgMC4wMDAw
MDBdICAgNiBkaXNhYmxlZApbICAgIDAuMDAwMDAwXSAgIDcgZGlzYWJsZWQKWyAgICAwLjAwMDAw
MF0geDg2IFBBVCBlbmFibGVkOiBjcHUgMCwgb2xkIDB4NzA0MDYwMDA3MDQwNiwgbmV3IDB4NzAx
MDYwMDA3MDEwNgpbICAgIDAuMDAwMDAwXSBmb3VuZCBTTVAgTVAtdGFibGUgYXQgW2ZmZmY4ODAw
MDAwZmQ5MTBdIGZkOTEwClsgICAgMC4wMDAwMDBdIGluaXRpYWwgbWVtb3J5IG1hcHBlZCA6IDAg
LSAyMDAwMDAwMApbICAgIDAuMDAwMDAwXSBCYXNlIG1lbW9yeSB0cmFtcG9saW5lIGF0IFtmZmZm
ODgwMDAwMDlhMDAwXSA5YTAwMCBzaXplIDIwNDgwClsgICAgMC4wMDAwMDBdIFVzaW5nIEdCIHBh
Z2VzIGZvciBkaXJlY3QgbWFwcGluZwpbICAgIDAuMDAwMDAwXSBpbml0X21lbW9yeV9tYXBwaW5n
OiAwMDAwMDAwMDAwMDAwMDAwLTAwMDAwMDAwNWU4MDAwMDAKWyAgICAwLjAwMDAwMF0gIDAwMDAw
MDAwMDAgLSAwMDQwMDAwMDAwIHBhZ2UgMUcKWyAgICAwLjAwMDAwMF0gIDAwNDAwMDAwMDAgLSAw
MDVlODAwMDAwIHBhZ2UgMk0KWyAgICAwLjAwMDAwMF0ga2VybmVsIGRpcmVjdCBtYXBwaW5nIHRh
YmxlcyB1cCB0byA1ZTgwMDAwMCBAIDVlN2ZlMDAwLTVlODAwMDAwClsgICAgMC4wMDAwMDBdIFJB
TURJU0s6IDM3NjJkMDAwIC0gMzdmZjAwMDAKWyAgICAwLjAwMDAwMF0gY3Jhc2hrZXJuZWwgcmVz
ZXJ2YXRpb24gZmFpbGVkIC0gbWVtb3J5IGlzIGluIHVzZS4KWyAgICAwLjAwMDAwMF0gQUNQSTog
UlNEUCAwMDAwMDAwMDAwMGYwNDkwIDAwMDI0ICh2MDIgQUxBU0tBKQpbICAgIDAuMDAwMDAwXSBB
Q1BJOiBYU0RUIDAwMDAwMDAwNWMyYmIwNzggMDAwNkMgKHYwMSBBTEFTS0EgICAgQSBNIEkgMDEw
NzIwMDkgQU1JICAwMDAxMDAxMykKWyAgICAwLjAwMDAwMF0gQUNQSTogRkFDUCAwMDAwMDAwMDVj
MmM0NDQ4IDAwMTBDICh2MDUgQUxBU0tBICAgIEEgTSBJIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMp
ClsgICAgMC4wMDAwMDBdIEFDUEkgV2FybmluZzogRkFEVCAocmV2aXNpb24gNSkgaXMgbG9uZ2Vy
IHRoYW4gQUNQSSAyLjAgdmVyc2lvbiwgdHJ1bmNhdGluZyBsZW5ndGggMjY4IHRvIDI0NCAoMjAx
MTAzMTYvdGJmYWR0LTI4OCkKWyAgICAwLjAwMDAwMF0gQUNQSSBXYXJuaW5nOiBPcHRpb25hbCBm
aWVsZCBQbTJDb250cm9sQmxvY2sgaGFzIHplcm8gYWRkcmVzcyBvciBsZW5ndGg6IDB4MDAwMDAw
MDAwMDAwMDAwMC8weDEgKDIwMTEwMzE2L3RiZmFkdC01NjApClsgICAgMC4wMDAwMDBdIEFDUEk6
IERTRFQgMDAwMDAwMDA1YzJiYjE3OCAwOTJDRCAodjAyIEFMQVNLQSAgICBBIE0gSSAwMDAwMDAw
MCBJTlRMIDIwMDUxMTE3KQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBGQUNTIDAwMDAwMDAwNWM2Yzgw
ODAgMDAwNDAKWyAgICAwLjAwMDAwMF0gQUNQSTogQVBJQyAwMDAwMDAwMDVjMmM0NTU4IDAwMDcy
ICh2MDMgQUxBU0tBICAgIEEgTSBJIDAxMDcyMDA5IEFNSSAgMDAwMTAwMTMpClsgICAgMC4wMDAw
MDBdIEFDUEk6IEZQRFQgMDAwMDAwMDA1YzJjNDVkMCAwMDA0NCAodjAxIEFMQVNLQSAgICBBIE0g
SSAwMTA3MjAwOSBBTUkgIDAwMDEwMDEzKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBNQ0ZHIDAwMDAw
MDAwNWMyYzQ2MTggMDAwM0MgKHYwMSBBTEFTS0EgICAgQSBNIEkgMDEwNzIwMDkgTVNGVCAwMDAx
MDAxMykKWyAgICAwLjAwMDAwMF0gQUNQSTogSFBFVCAwMDAwMDAwMDVjMmM0NjU4IDAwMDM4ICh2
MDEgQUxBU0tBICAgIEEgTSBJIDAxMDcyMDA5IEFNSSAgMDAwMDAwMDUpClsgICAgMC4wMDAwMDBd
IEFDUEk6IElWUlMgMDAwMDAwMDA1YzJjNDY5MCAwMDA3MCAodjAyICAgIEFNRCBBTk5BUFVSTiAw
MDAwMDAwMSBBTUQgIDAwMDAwMDAwKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBTU0RUIDAwMDAwMDAw
NWMyYzQ3MDAgMDA2QjIgKHYwMSAgICBBTUQgQU5OQVBVUk4gMDAwMDAwMDEgQU1EICAwMDAwMDAw
MSkKWyAgICAwLjAwMDAwMF0gQUNQSTogU1NEVCAwMDAwMDAwMDVjMmM0ZGI4IDAwNEI3ICh2MDIg
ICAgQU1EIEFOTkFQVVJOIDAwMDAwMDAxIE1TRlQgMDQwMDAwMDApClsgICAgMC4wMDAwMDBdIEFD
UEk6IENSQVQgMDAwMDAwMDA1YzJjNTI3MCAwMDFBOCAodjAxICAgIEFNRCBBTk5BUFVSTiAwMDAw
MDAwMSBBTUQgIDAwMDAwMDAxKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMb2NhbCBBUElDIGFkZHJl
c3MgMHhmZWUwMDAwMApbICAgIDAuMDAwMDAwXSBObyBOVU1BIGNvbmZpZ3VyYXRpb24gZm91bmQK
WyAgICAwLjAwMDAwMF0gRmFraW5nIGEgbm9kZSBhdCAwMDAwMDAwMDAwMDAwMDAwLTAwMDAwMDAw
NWU4MDAwMDAKWyAgICAwLjAwMDAwMF0gTlVNQTogVXNpbmcgNjMgZm9yIHRoZSBoYXNoIHNoaWZ0
LgpbICAgIDAuMDAwMDAwXSBJbml0bWVtIHNldHVwIG5vZGUgMCAwMDAwMDAwMDAwMDAwMDAwLTAw
MDAwMDAwNWU4MDAwMDAKWyAgICAwLjAwMDAwMF0gICBOT0RFX0RBVEEgWzAwMDAwMDAwNWU3Zjkw
MDAgLSAwMDAwMDAwMDVlN2ZkZmZmXQpbICAgIDAuMDAwMDAwXSAgW2ZmZmZlYTAwMDAwMDAwMDAt
ZmZmZmVhMDAwMTVmZmZmZl0gUE1EIC0+IFtmZmZmODgwMDU5YTAwMDAwLWZmZmY4ODAwNWFmZmZm
ZmZdIG9uIG5vZGUgMApbICAgIDAuMDAwMDAwXSBab25lIFBGTiByYW5nZXM6ClsgICAgMC4wMDAw
MDBdICAgRE1BICAgICAgMHgwMDAwMDAxMCAtPiAweDAwMDAxMDAwClsgICAgMC4wMDAwMDBdICAg
RE1BMzIgICAgMHgwMDAwMTAwMCAtPiAweDAwMTAwMDAwClsgICAgMC4wMDAwMDBdICAgTm9ybWFs
ICAgZW1wdHkKWyAgICAwLjAwMDAwMF0gTW92YWJsZSB6b25lIHN0YXJ0IFBGTiBmb3IgZWFjaCBu
b2RlClsgICAgMC4wMDAwMDBdIGVhcmx5X25vZGVfbWFwWzddIGFjdGl2ZSBQRk4gcmFuZ2VzClsg
ICAgMC4wMDAwMDBdICAgICAwOiAweDAwMDAwMDEwIC0+IDB4MDAwMDAwOWYKWyAgICAwLjAwMDAw
MF0gICAgIDA6IDB4MDAwMDAxMDAgLT4gMHgwMDA1YmI4YwpbICAgIDAuMDAwMDAwXSAgICAgMDog
MHgwMDA1YmU2NyAtPiAweDAwMDVjMjJiClsgICAgMC4wMDAwMDBdICAgICAwOiAweDAwMDVkOTBm
IC0+IDB4MDAwNWQ5MTAKWyAgICAwLjAwMDAwMF0gICAgIDA6IDB4MDAwNWRiMTYgLT4gMHgwMDA1
ZGM2ZQpbICAgIDAuMDAwMDAwXSAgICAgMDogMHgwMDA1ZTQzMiAtPiAweDAwMDVlNDcwClsgICAg
MC4wMDAwMDBdICAgICAwOiAweDAwMDVlN2YxIC0+IDB4MDAwNWU4MDAKWyAgICAwLjAwMDAwMF0g
T24gbm9kZSAwIHRvdGFscGFnZXM6IDM3Njk2NQpbICAgIDAuMDAwMDAwXSAgIERNQSB6b25lOiA1
NiBwYWdlcyB1c2VkIGZvciBtZW1tYXAKWyAgICAwLjAwMDAwMF0gICBETUEgem9uZTogNSBwYWdl
cyByZXNlcnZlZApbICAgIDAuMDAwMDAwXSAgIERNQSB6b25lOiAzOTIyIHBhZ2VzLCBMSUZPIGJh
dGNoOjAKWyAgICAwLjAwMDAwMF0gICBETUEzMiB6b25lOiA1MjM2IHBhZ2VzIHVzZWQgZm9yIG1l
bW1hcApbICAgIDAuMDAwMDAwXSAgIERNQTMyIHpvbmU6IDM2Nzc0NiBwYWdlcywgTElGTyBiYXRj
aDozMQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBQTS1UaW1lciBJTyBQb3J0OiAweDgwOApbICAgIDAu
MDAwMDAwXSBBQ1BJOiBMb2NhbCBBUElDIGFkZHJlc3MgMHhmZWUwMDAwMApbICAgIDAuMDAwMDAw
XSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDAxXSBsYXBpY19pZFsweDEwXSBlbmFibGVkKQpbICAg
IDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDAyXSBsYXBpY19pZFsweDExXSBlbmFi
bGVkKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBMQVBJQyAoYWNwaV9pZFsweDAzXSBsYXBpY19pZFsw
eDE0XSBkaXNhYmxlZCkKWyAgICAwLjAwMDAwMF0gQUNQSTogTEFQSUMgKGFjcGlfaWRbMHgwNF0g
bGFwaWNfaWRbMHgxNV0gZGlzYWJsZWQpClsgICAgMC4wMDAwMDBdIEFDUEk6IExBUElDX05NSSAo
YWNwaV9pZFsweGZmXSBoaWdoIGVkZ2UgbGludFsweDFdKQpbICAgIDAuMDAwMDAwXSBBQ1BJOiBJ
T0FQSUMgKGlkWzB4MDNdIGFkZHJlc3NbMHhmZWMwMDAwMF0gZ3NpX2Jhc2VbMF0pClsgICAgMC4w
MDAwMDBdIElPQVBJQ1swXTogYXBpY19pZCAzLCB2ZXJzaW9uIDMzLCBhZGRyZXNzIDB4ZmVjMDAw
MDAsIEdTSSAwLTIzClsgICAgMC4wMDAwMDBdIEFDUEk6IElOVF9TUkNfT1ZSIChidXMgMCBidXNf
aXJxIDAgZ2xvYmFsX2lycSAyIGRmbCBkZmwpClsgICAgMC4wMDAwMDBdIEFDUEk6IElOVF9TUkNf
T1ZSIChidXMgMCBidXNfaXJxIDkgZ2xvYmFsX2lycSA5IGxvdyBsZXZlbCkKWyAgICAwLjAwMDAw
MF0gQUNQSTogSVJRMCB1c2VkIGJ5IG92ZXJyaWRlLgpbICAgIDAuMDAwMDAwXSBBQ1BJOiBJUlEy
IHVzZWQgYnkgb3ZlcnJpZGUuClsgICAgMC4wMDAwMDBdIEFDUEk6IElSUTkgdXNlZCBieSBvdmVy
cmlkZS4KWyAgICAwLjAwMDAwMF0gVXNpbmcgQUNQSSAoTUFEVCkgZm9yIFNNUCBjb25maWd1cmF0
aW9uIGluZm9ybWF0aW9uClsgICAgMC4wMDAwMDBdIEFDUEk6IEhQRVQgaWQ6IDB4MTAyMjgyMTAg
YmFzZTogMHhmZWQwMDAwMApbICAgIDAuMDAwMDAwXSBTTVA6IEFsbG93aW5nIDQgQ1BVcywgMiBo
b3RwbHVnIENQVXMKWyAgICAwLjAwMDAwMF0gbnJfaXJxc19nc2k6IDQwClsgICAgMC4wMDAwMDBd
IFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAwMDAwMDAwMDAwOWYwMDAgLSAwMDAwMDAw
MDAwMGEwMDAwClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAw
MDAwMDAwMDAwYTAwMDAgLSAwMDAwMDAwMDAwMGUwMDAwClsgICAgMC4wMDAwMDBdIFBNOiBSZWdp
c3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAwMDAwMDAwMDAwZTAwMDAgLSAwMDAwMDAwMDAwMTAwMDAw
ClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAwMDAwMDAwNWJi
OGMwMDAgLSAwMDAwMDAwMDViZTY3MDAwClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5v
c2F2ZSBtZW1vcnk6IDAwMDAwMDAwNWMyMmIwMDAgLSAwMDAwMDAwMDVjNmQzMDAwClsgICAgMC4w
MDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAwMDAwMDAwNWM2ZDMwMDAgLSAw
MDAwMDAwMDVkOTBmMDAwClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1v
cnk6IDAwMDAwMDAwNWQ5MTAwMDAgLSAwMDAwMDAwMDVkYjE2MDAwClsgICAgMC4wMDAwMDBdIFBN
OiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAwMDAwMDAwNWRjNmUwMDAgLSAwMDAwMDAwMDVl
NDMyMDAwClsgICAgMC4wMDAwMDBdIFBNOiBSZWdpc3RlcmVkIG5vc2F2ZSBtZW1vcnk6IDAwMDAw
MDAwNWU0NzAwMDAgLSAwMDAwMDAwMDVlN2YxMDAwClsgICAgMC4wMDAwMDBdIEFsbG9jYXRpbmcg
UENJIHJlc291cmNlcyBzdGFydGluZyBhdCA1ZTgwMDAwMCAoZ2FwOiA1ZTgwMDAwMDphMDQwMDAw
MCkKWyAgICAwLjAwMDAwMF0gQm9vdGluZyBwYXJhdmlydHVhbGl6ZWQga2VybmVsIG9uIGJhcmUg
aGFyZHdhcmUKWyAgICAwLjAwMDAwMF0gc2V0dXBfcGVyY3B1OiBOUl9DUFVTOjI1NiBucl9jcHVt
YXNrX2JpdHM6MjU2IG5yX2NwdV9pZHM6NCBucl9ub2RlX2lkczoxClsgICAgMC4wMDAwMDBdIFBF
UkNQVTogRW1iZWRkZWQgMjggcGFnZXMvY3B1IEBmZmZmODgwMDVjMDAwMDAwIHM4NTA1NiByODE5
MiBkMjE0NDAgdTUyNDI4OApbICAgIDAuMDAwMDAwXSBwY3B1LWFsbG9jOiBzODUwNTYgcjgxOTIg
ZDIxNDQwIHU1MjQyODggYWxsb2M9MSoyMDk3MTUyClsgICAgMC4wMDAwMDBdIHBjcHUtYWxsb2M6
IFswXSAwIDEgMiAzIApbICAgIDAuMDAwMDAwXSBCdWlsdCAxIHpvbmVsaXN0cyBpbiBOb2RlIG9y
ZGVyLCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAzNzE2NjgKWyAgICAwLjAw
MDAwMF0gUG9saWN5IHpvbmU6IERNQTMyClsgICAgMC4wMDAwMDBdIEtlcm5lbCBjb21tYW5kIGxp
bmU6IHJvb3Q9VVVJRD0wY2U4OGUzYy1hYWM3LTQ1MTYtOTkxMi03NzNkZTJiZjQ0YTkgcm8gcXVp
ZXQgc3BsYXNoICBjcmFzaGtlcm5lbD0zODRNLTJHOjY0TUAxNk0sMkctOjEyOE1AMTZNClsgICAg
MC4wMDAwMDBdIFBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAzLCAzMjc2OCBi
eXRlcykKWyAgICAwLjAwMDAwMF0geHNhdmUveHJzdG9yOiBlbmFibGVkIHhzdGF0ZV9idiAweDcs
IGNudHh0IHNpemUgMHgzNDAKWyAgICAwLjAwMDAwMF0gQ2hlY2tpbmcgYXBlcnR1cmUuLi4KWyAg
ICAwLjAwMDAwMF0gTm8gQUdQIGJyaWRnZSBmb3VuZApbICAgIDAuMDAwMDAwXSBDYWxnYXJ5OiBk
ZXRlY3RpbmcgQ2FsZ2FyeSB2aWEgQklPUyBFQkRBIGFyZWEKWyAgICAwLjAwMDAwMF0gQ2FsZ2Fy
eTogVW5hYmxlIHRvIGxvY2F0ZSBSaW8gR3JhbmRlIHRhYmxlIGluIEVCREEgLSBiYWlsaW5nIQpb
ICAgIDAuMDAwMDAwXSBNZW1vcnk6IDE0NjEzMDBrLzE1NDgyODhrIGF2YWlsYWJsZSAoNjAxOWsg
a2VybmVsIGNvZGUsIDQwNDI4ayBhYnNlbnQsIDQ2NTYwayByZXNlcnZlZCwgNDk0NmsgZGF0YSwg
MTA2OGsgaW5pdCkKWyAgICAwLjAwMDAwMF0gU0xVQjogR2Vuc2xhYnM9MTUsIEhXYWxpZ249NjQs
IE9yZGVyPTAtMywgTWluT2JqZWN0cz0wLCBDUFVzPTQsIE5vZGVzPTEKWyAgICAwLjAwMDAwMF0g
SGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjAwMDAwMF0gCVJDVSBkeW50
aWNrLWlkbGUgZ3JhY2UtcGVyaW9kIGFjY2VsZXJhdGlvbiBpcyBlbmFibGVkLgpbICAgIDAuMDAw
MDAwXSAJUkNVLWJhc2VkIGRldGVjdGlvbiBvZiBzdGFsbGVkIENQVXMgaXMgZGlzYWJsZWQuClsg
ICAgMC4wMDAwMDBdIE5SX0lSUVM6MTY2NDAgbnJfaXJxczo3MTIgMTYKWyAgICAwLjAwMDAwMF0g
RXh0ZW5kZWQgQ01PUyB5ZWFyOiAyMDAwClsgICAgMC4wMDAwMDBdIENvbnNvbGU6IGNvbG91ciBW
R0ErIDgweDI1ClsgICAgMC4wMDAwMDBdIGNvbnNvbGUgW3R0eTBdIGVuYWJsZWQKWyAgICAwLjAw
MDAwMF0gYWxsb2NhdGVkIDEyNTgyOTEyIGJ5dGVzIG9mIHBhZ2VfY2dyb3VwClsgICAgMC4wMDAw
MDBdIHBsZWFzZSB0cnkgJ2Nncm91cF9kaXNhYmxlPW1lbW9yeScgb3B0aW9uIGlmIHlvdSBkb24n
dCB3YW50IG1lbW9yeSBjZ3JvdXBzClsgICAgMC4wMDAwMDBdIGhwZXQgY2xvY2tldmVudCByZWdp
c3RlcmVkClsgICAgMC4wMDAwMDBdIEZhc3QgVFNDIGNhbGlicmF0aW9uIHVzaW5nIFBJVApbICAg
IDAuMDAwMDAwXSBEZXRlY3RlZCAzNDAwLjI4NyBNSHogcHJvY2Vzc29yLgpbICAgIDAuMDAwMDAz
XSBDYWxpYnJhdGluZyBkZWxheSBsb29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2lu
ZyB0aW1lciBmcmVxdWVuY3kuLiA2ODAwLjU3IEJvZ29NSVBTIChscGo9MzQwMDI4NzApClsgICAg
MC4wMDAwMDZdIHBpZF9tYXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmltdW06IDMwMQpbICAgIDAuMDAw
MDI2XSBTZWN1cml0eSBGcmFtZXdvcmsgaW5pdGlhbGl6ZWQKWyAgICAwLjAwMDAzOV0gQXBwQXJt
b3I6IEFwcEFybW9yIGluaXRpYWxpemVkClsgICAgMC4wMDAyMzZdIERlbnRyeSBjYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDksIDIwOTcxNTIgYnl0ZXMpClsgICAgMC4w
MDA4NDFdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogOCwg
MTA0ODU3NiBieXRlcykKWyAgICAwLjAwMTEwMF0gTW91bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRy
aWVzOiAyNTYKWyAgICAwLjAwMTIwNF0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgbnMKWyAg
ICAwLjAwMTIwN10gbnNfY2dyb3VwIGRlcHJlY2F0ZWQ6IGNvbnNpZGVyIHVzaW5nIHRoZSAnY2xv
bmVfY2hpbGRyZW4nIGZsYWcgd2l0aG91dCB0aGUgbnNfY2dyb3VwLgpbICAgIDAuMDAxMjA5XSBJ
bml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBjcHVhY2N0ClsgICAgMC4wMDEyMTJdIEluaXRpYWxp
emluZyBjZ3JvdXAgc3Vic3lzIG1lbW9yeQpbICAgIDAuMDAxMjE5XSBJbml0aWFsaXppbmcgY2dy
b3VwIHN1YnN5cyBkZXZpY2VzClsgICAgMC4wMDEyMjFdIEluaXRpYWxpemluZyBjZ3JvdXAgc3Vi
c3lzIGZyZWV6ZXIKWyAgICAwLjAwMTIyMl0gSW5pdGlhbGl6aW5nIGNncm91cCBzdWJzeXMgbmV0
X2NscwpbICAgIDAuMDAxMjI0XSBJbml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBibGtpbwpbICAg
IDAuMDAxMjMwXSBJbml0aWFsaXppbmcgY2dyb3VwIHN1YnN5cyBwZXJmX2V2ZW50ClsgICAgMC4w
MDEyNTNdIHRzZWc6IDAwNWU4MDAwMDAKWyAgICAwLjAwMTI1NF0gQ1BVOiBQaHlzaWNhbCBQcm9j
ZXNzb3IgSUQ6IDAKWyAgICAwLjAwMTI1NV0gQ1BVOiBQcm9jZXNzb3IgQ29yZSBJRDogMApbICAg
IDAuMDAxMjU3XSBtY2U6IENQVSBzdXBwb3J0cyA3IE1DRSBiYW5rcwpbICAgIDAuMDExNTc0XSBB
Q1BJOiBDb3JlIHJldmlzaW9uIDIwMTEwMzE2ClsgICAgMC4wMjAwMTZdIGZ0cmFjZTogYWxsb2Nh
dGluZyAyODY3NSBlbnRyaWVzIGluIDExMyBwYWdlcwpbICAgIDAuMDMwMDYyXSBTZXR0aW5nIEFQ
SUMgcm91dGluZyB0byBmbGF0ClsgICAgMC4wMzAzMzBdIC4uVElNRVI6IHZlY3Rvcj0weDMwIGFw
aWMxPTAgcGluMT0yIGFwaWMyPS0xIHBpbjI9LTEKWyAgICAwLjEzNDU3OV0gQ1BVMDogQU1EIEEx
MC01NzAwIEFQVSB3aXRoIFJhZGVvbih0bSkgSEQgR3JhcGhpY3MgICAgc3RlcHBpbmcgMDEKWyAg
ICAwLjE0MDAwMF0gUGVyZm9ybWFuY2UgRXZlbnRzOiBBTUQgRmFtaWx5IDE1aCBQTVUgZHJpdmVy
LgpbICAgIDAuMTQwMDAwXSAuLi4gdmVyc2lvbjogICAgICAgICAgICAgICAgMApbICAgIDAuMTQw
MDAwXSAuLi4gYml0IHdpZHRoOiAgICAgICAgICAgICAgNDgKWyAgICAwLjE0MDAwMF0gLi4uIGdl
bmVyaWMgcmVnaXN0ZXJzOiAgICAgIDYKWyAgICAwLjE0MDAwMF0gLi4uIHZhbHVlIG1hc2s6ICAg
ICAgICAgICAgIDAwMDBmZmZmZmZmZmZmZmYKWyAgICAwLjE0MDAwMF0gLi4uIG1heCBwZXJpb2Q6
ICAgICAgICAgICAgIDAwMDA3ZmZmZmZmZmZmZmYKWyAgICAwLjE0MDAwMF0gLi4uIGZpeGVkLXB1
cnBvc2UgZXZlbnRzOiAgIDAKWyAgICAwLjE0MDAwMF0gLi4uIGV2ZW50IG1hc2s6ICAgICAgICAg
ICAgIDAwMDAwMDAwMDAwMDAwM2YKWyAgICAwLjE0MDAwMF0gQm9vdGluZyBOb2RlICAgMCwgUHJv
Y2Vzc29ycyAgIzEKWyAgICAwLjE0MDAwMF0gc21wYm9vdCBjcHUgMTogc3RhcnRfaXAgPSA5YTAw
MApbICAgIDAuMzAwMDEzXSBCcm91Z2h0IHVwIDIgQ1BVcwpbICAgIDAuMzAwMDE3XSBUb3RhbCBv
ZiAyIHByb2Nlc3NvcnMgYWN0aXZhdGVkICgxMzYwMC45OSBCb2dvTUlQUykuClsgICAgMC4zMDAz
NjVdIGRldnRtcGZzOiBpbml0aWFsaXplZApbICAgIDAuMzAwMzY1XSBQTTogUmVnaXN0ZXJpbmcg
QUNQSSBOVlMgcmVnaW9uIGF0IDVjMjJiMDAwICg0ODgyNDMyIGJ5dGVzKQpbICAgIDAuMzAwMzY1
XSBQTTogUmVnaXN0ZXJpbmcgQUNQSSBOVlMgcmVnaW9uIGF0IDVkOTEwMDAwICgyMTIxNzI4IGJ5
dGVzKQpbICAgIDAuMzAwODYyXSBwcmludF9jb25zdHJhaW50czogZHVtbXk6IApbICAgIDAuMzAw
ODgxXSBUaW1lOiAxMDoxNjowOSAgRGF0ZTogMDgvMTQvMTMKWyAgICAwLjMwMDkwOV0gTkVUOiBS
ZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNgpbICAgIDAuMzAxMDU2XSBFeHRlbmRlZCBDb25m
aWcgU3BhY2UgZW5hYmxlZCBvbiAwIG5vZGVzClsgICAgMC4zMDEwNzVdIEFDUEk6IGJ1cyB0eXBl
IHBjaSByZWdpc3RlcmVkClsgICAgMC4zMDExMjBdIFBDSTogTU1DT05GSUcgZm9yIGRvbWFpbiAw
MDAwIFtidXMgMDAtZmZdIGF0IFttZW0gMHhlMDAwMDAwMC0weGVmZmZmZmZmXSAoYmFzZSAweGUw
MDAwMDAwKQpbICAgIDAuMzAxMTIzXSBQQ0k6IG5vdCB1c2luZyBNTUNPTkZJRwpbICAgIDAuMzAx
MTI1XSBQQ0k6IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAxIGZvciBiYXNlIGFjY2VzcwpbICAg
IDAuMzAxMTI2XSBQQ0k6IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAxIGZvciBleHRlbmRlZCBh
Y2Nlc3MKWyAgICAwLjMwMTY5M10gYmlvOiBjcmVhdGUgc2xhYiA8YmlvLTA+IGF0IDAKWyAgICAw
LjMwMTY5M10gQUNQSTogRUM6IExvb2sgdXAgRUMgaW4gRFNEVApbICAgIDAuMzAyNjAyXSBBQ1BJ
OiBFeGVjdXRlZCAxIGJsb2NrcyBvZiBtb2R1bGUtbGV2ZWwgZXhlY3V0YWJsZSBBTUwgY29kZQpb
ICAgIDAuMzA2MzI4XSBBQ1BJOiBJbnRlcnByZXRlciBlbmFibGVkClsgICAgMC4zMDYzMzFdIEFD
UEk6IChzdXBwb3J0cyBTMCBTMyBTNCBTNSkKWyAgICAwLjMwNjM2Ml0gQUNQSTogVXNpbmcgSU9B
UElDIGZvciBpbnRlcnJ1cHQgcm91dGluZwpbICAgIDAuMzA2MzgyXSBQQ0k6IE1NQ09ORklHIGZv
ciBkb21haW4gMDAwMCBbYnVzIDAwLWZmXSBhdCBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0g
KGJhc2UgMHhlMDAwMDAwMCkKWyAgICAwLjMwNjQxOV0gUENJOiBNTUNPTkZJRyBhdCBbbWVtIDB4
ZTAwMDAwMDAtMHhlZmZmZmZmZl0gcmVzZXJ2ZWQgaW4gQUNQSSBtb3RoZXJib2FyZCByZXNvdXJj
ZXMKWyAgICAwLjU1MDE2Ml0gQUNQSTogTm8gZG9jayBkZXZpY2VzIGZvdW5kLgpbICAgIDAuNTUw
MTY2XSBIRVNUOiBUYWJsZSBub3QgZm91bmQuClsgICAgMC41NTAxNjldIFBDSTogVXNpbmcgaG9z
dCBicmlkZ2Ugd2luZG93cyBmcm9tIEFDUEk7IGlmIG5lY2Vzc2FyeSwgdXNlICJwY2k9bm9jcnMi
IGFuZCByZXBvcnQgYSBidWcKWyAgICAwLjU1MDQ5NF0gQUNQSTogUENJIFJvb3QgQnJpZGdlIFtQ
Q0kwXSAoZG9tYWluIDAwMDAgW2J1cyAwMC1mZl0pClsgICAgMC41NTA3ODZdIHBjaV9yb290IFBO
UDBBMDM6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MDAwMC0weDAzYWZdClsgICAgMC41
NTA3ODhdIHBjaV9yb290IFBOUDBBMDM6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MDNl
MC0weDBjZjddClsgICAgMC41NTA3OTBdIHBjaV9yb290IFBOUDBBMDM6MDA6IGhvc3QgYnJpZGdl
IHdpbmRvdyBbaW8gIDB4MDNiMC0weDAzZGZdClsgICAgMC41NTA3OTJdIHBjaV9yb290IFBOUDBB
MDM6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbaW8gIDB4MGQwMC0weGZmZmZdClsgICAgMC41NTA3
OTVdIHBjaV9yb290IFBOUDBBMDM6MDA6IGhvc3QgYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAwYTAw
MDAtMHgwMDBiZmZmZl0KWyAgICAwLjU1MDc5N10gcGNpX3Jvb3QgUE5QMEEwMzowMDogaG9zdCBi
cmlkZ2Ugd2luZG93IFttZW0gMHgwMDBjMDAwMC0weDAwMGRmZmZmXQpbICAgIDAuNTUwNzk5XSBw
Y2lfcm9vdCBQTlAwQTAzOjAwOiBob3N0IGJyaWRnZSB3aW5kb3cgW21lbSAweDdmMDAwMDAwLTB4
ZmZmZmZmZmZdClsgICAgMC41NTA4MTBdIHBjaSAwMDAwOjAwOjAwLjA6IFsxMDIyOjE0MTBdIHR5
cGUgMCBjbGFzcyAweDAwMDYwMApbICAgIDAuNTUwODQwXSBwY2kgMDAwMDowMDowMC4yOiBbMTAy
MjoxNDE5XSB0eXBlIDAgY2xhc3MgMHgwMDA4MDYKWyAgICAwLjU1MDg4OV0gcGNpIDAwMDA6MDA6
MDEuMDogWzEwMDI6OTkwMV0gdHlwZSAwIGNsYXNzIDB4MDAwMzAwClsgICAgMC41NTA4OTddIHBj
aSAwMDAwOjAwOjAxLjA6IHJlZyAxMDogW21lbSAweGMwMDAwMDAwLTB4Y2ZmZmZmZmYgcHJlZl0K
WyAgICAwLjU1MDkwMl0gcGNpIDAwMDA6MDA6MDEuMDogcmVnIDE0OiBbaW8gIDB4ZjAwMC0weGYw
ZmZdClsgICAgMC41NTA5MDddIHBjaSAwMDAwOjAwOjAxLjA6IHJlZyAxODogW21lbSAweGZlZjAw
MDAwLTB4ZmVmM2ZmZmZdClsgICAgMC41NTA5MzJdIHBjaSAwMDAwOjAwOjAxLjA6IHN1cHBvcnRz
IEQxIEQyClsgICAgMC41NTA5NDRdIHBjaSAwMDAwOjAwOjAxLjE6IFsxMDAyOjk5MDJdIHR5cGUg
MCBjbGFzcyAweDAwMDQwMwpbICAgIDAuNTUwOTUxXSBwY2kgMDAwMDowMDowMS4xOiByZWcgMTA6
IFttZW0gMHhmZWY0NDAwMC0weGZlZjQ3ZmZmXQpbICAgIDAuNTUwOTgyXSBwY2kgMDAwMDowMDow
MS4xOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNTUxMDIzXSBwY2kgMDAwMDowMDoxMC4wOiBbMTAy
Mjo3ODEyXSB0eXBlIDAgY2xhc3MgMHgwMDBjMDMKWyAgICAwLjU1MTA0MV0gcGNpIDAwMDA6MDA6
MTAuMDogcmVnIDEwOiBbbWVtIDB4ZmVmNGEwMDAtMHhmZWY0YmZmZiA2NGJpdF0KWyAgICAwLjU1
MTExMl0gcGNpIDAwMDA6MDA6MTAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2Nv
bGQKWyAgICAwLjU1MTExNl0gcGNpIDAwMDA6MDA6MTAuMDogUE1FIyBkaXNhYmxlZApbICAgIDAu
NTUxMTUwXSBwY2kgMDAwMDowMDoxMC4xOiBbMTAyMjo3ODEyXSB0eXBlIDAgY2xhc3MgMHgwMDBj
MDMKWyAgICAwLjU1MTE2N10gcGNpIDAwMDA6MDA6MTAuMTogcmVnIDEwOiBbbWVtIDB4ZmVmNDgw
MDAtMHhmZWY0OWZmZiA2NGJpdF0KWyAgICAwLjU1MTIzOV0gcGNpIDAwMDA6MDA6MTAuMTogUE1F
IyBzdXBwb3J0ZWQgZnJvbSBEMCBEM2hvdCBEM2NvbGQKWyAgICAwLjU1MTI0Ml0gcGNpIDAwMDA6
MDA6MTAuMTogUE1FIyBkaXNhYmxlZApbICAgIDAuNTUxMjczXSBwY2kgMDAwMDowMDoxMS4wOiBb
MTAyMjo3ODAwXSB0eXBlIDAgY2xhc3MgMHgwMDAxMDEKWyAgICAwLjU1MTI4N10gcGNpIDAwMDA6
MDA6MTEuMDogcmVnIDEwOiBbaW8gIDB4ZjE5MC0weGYxOTddClsgICAgMC41NTEyOTVdIHBjaSAw
MDAwOjAwOjExLjA6IHJlZyAxNDogW2lvICAweGYxODAtMHhmMTgzXQpbICAgIDAuNTUxMzAzXSBw
Y2kgMDAwMDowMDoxMS4wOiByZWcgMTg6IFtpbyAgMHhmMTcwLTB4ZjE3N10KWyAgICAwLjU1MTMx
MV0gcGNpIDAwMDA6MDA6MTEuMDogcmVnIDFjOiBbaW8gIDB4ZjE2MC0weGYxNjNdClsgICAgMC41
NTEzMTldIHBjaSAwMDAwOjAwOjExLjA6IHJlZyAyMDogW2lvICAweGYxNTAtMHhmMTVmXQpbICAg
IDAuNTUxMzI3XSBwY2kgMDAwMDowMDoxMS4wOiByZWcgMjQ6IFttZW0gMHhmZWY1MTAwMC0weGZl
ZjUxN2ZmXQpbICAgIDAuNTUxMzQ0XSBwY2kgMDAwMDowMDoxMS4wOiBzZXQgU0FUQSB0byBBSENJ
IG1vZGUKWyAgICAwLjU1MTM2N10gcGNpIDAwMDA6MDA6MTIuMDogWzEwMjI6NzgwN10gdHlwZSAw
IGNsYXNzIDB4MDAwYzAzClsgICAgMC41NTEzNzhdIHBjaSAwMDAwOjAwOjEyLjA6IHJlZyAxMDog
W21lbSAweGZlZjUwMDAwLTB4ZmVmNTBmZmZdClsgICAgMC41NTE0MzVdIHBjaSAwMDAwOjAwOjEy
LjI6IFsxMDIyOjc4MDhdIHR5cGUgMCBjbGFzcyAweDAwMGMwMwpbICAgIDAuNTUxNDUxXSBwY2kg
MDAwMDowMDoxMi4yOiByZWcgMTA6IFttZW0gMHhmZWY0ZjAwMC0weGZlZjRmMGZmXQpbICAgIDAu
NTUxNTA4XSBwY2kgMDAwMDowMDoxMi4yOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNTUxNTEwXSBw
Y2kgMDAwMDowMDoxMi4yOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90ClsgICAg
MC41NTE1MTNdIHBjaSAwMDAwOjAwOjEyLjI6IFBNRSMgZGlzYWJsZWQKWyAgICAwLjU1MTUzM10g
cGNpIDAwMDA6MDA6MTMuMDogWzEwMjI6NzgwN10gdHlwZSAwIGNsYXNzIDB4MDAwYzAzClsgICAg
MC41NTE1NDRdIHBjaSAwMDAwOjAwOjEzLjA6IHJlZyAxMDogW21lbSAweGZlZjRlMDAwLTB4ZmVm
NGVmZmZdClsgICAgMC41NTE2MDFdIHBjaSAwMDAwOjAwOjEzLjI6IFsxMDIyOjc4MDhdIHR5cGUg
MCBjbGFzcyAweDAwMGMwMwpbICAgIDAuNTUxNjE3XSBwY2kgMDAwMDowMDoxMy4yOiByZWcgMTA6
IFttZW0gMHhmZWY0ZDAwMC0weGZlZjRkMGZmXQpbICAgIDAuNTUxNjc0XSBwY2kgMDAwMDowMDox
My4yOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNTUxNjc1XSBwY2kgMDAwMDowMDoxMy4yOiBQTUUj
IHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQyIEQzaG90ClsgICAgMC41NTE2NzldIHBjaSAwMDAwOjAw
OjEzLjI6IFBNRSMgZGlzYWJsZWQKWyAgICAwLjU1MTY5Nl0gcGNpIDAwMDA6MDA6MTQuMDogWzEw
MjI6NzgwYl0gdHlwZSAwIGNsYXNzIDB4MDAwYzA1ClsgICAgMC41NTE3NTNdIHBjaSAwMDAwOjAw
OjE0LjE6IFsxMDIyOjc4MGNdIHR5cGUgMCBjbGFzcyAweDAwMDEwMQpbICAgIDAuNTUxNzY1XSBw
Y2kgMDAwMDowMDoxNC4xOiByZWcgMTA6IFtpbyAgMHhmMTQwLTB4ZjE0N10KWyAgICAwLjU1MTc3
M10gcGNpIDAwMDA6MDA6MTQuMTogcmVnIDE0OiBbaW8gIDB4ZjEzMC0weGYxMzNdClsgICAgMC41
NTE3ODFdIHBjaSAwMDAwOjAwOjE0LjE6IHJlZyAxODogW2lvICAweGYxMjAtMHhmMTI3XQpbICAg
IDAuNTUxNzg5XSBwY2kgMDAwMDowMDoxNC4xOiByZWcgMWM6IFtpbyAgMHhmMTEwLTB4ZjExM10K
WyAgICAwLjU1MTc5N10gcGNpIDAwMDA6MDA6MTQuMTogcmVnIDIwOiBbaW8gIDB4ZjEwMC0weGYx
MGZdClsgICAgMC41NTE4MjZdIHBjaSAwMDAwOjAwOjE0LjI6IFsxMDIyOjc4MGRdIHR5cGUgMCBj
bGFzcyAweDAwMDQwMwpbICAgIDAuNTUxODQ0XSBwY2kgMDAwMDowMDoxNC4yOiByZWcgMTA6IFtt
ZW0gMHhmZWY0MDAwMC0weGZlZjQzZmZmIDY0Yml0XQpbICAgIDAuNTUxODkxXSBwY2kgMDAwMDow
MDoxNC4yOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZApbICAgIDAuNTUxODk1
XSBwY2kgMDAwMDowMDoxNC4yOiBQTUUjIGRpc2FibGVkClsgICAgMC41NTE5MDVdIHBjaSAwMDAw
OjAwOjE0LjM6IFsxMDIyOjc4MGVdIHR5cGUgMCBjbGFzcyAweDAwMDYwMQpbICAgIDAuNTUxOTY2
XSBwY2kgMDAwMDowMDoxNC40OiBbMTAyMjo3ODBmXSB0eXBlIDEgY2xhc3MgMHgwMDA2MDQKWyAg
ICAwLjU1MTk5OV0gcGNpIDAwMDA6MDA6MTQuNTogWzEwMjI6NzgwOV0gdHlwZSAwIGNsYXNzIDB4
MDAwYzAzClsgICAgMC41NTIwMTBdIHBjaSAwMDAwOjAwOjE0LjU6IHJlZyAxMDogW21lbSAweGZl
ZjRjMDAwLTB4ZmVmNGNmZmZdClsgICAgMC41NTIwNjhdIHBjaSAwMDAwOjAwOjE1LjA6IFsxMDIy
OjQzYTBdIHR5cGUgMSBjbGFzcyAweDAwMDYwNApbICAgIDAuNTUyMTEzXSBwY2kgMDAwMDowMDox
NS4wOiBzdXBwb3J0cyBEMSBEMgpbICAgIDAuNTUyMTM0XSBwY2kgMDAwMDowMDoxNS4xOiBbMTAy
Mjo0M2ExXSB0eXBlIDEgY2xhc3MgMHgwMDA2MDQKWyAgICAwLjU1MjE3OV0gcGNpIDAwMDA6MDA6
MTUuMTogc3VwcG9ydHMgRDEgRDIKWyAgICAwLjU1MjIwM10gcGNpIDAwMDA6MDA6MTguMDogWzEw
MjI6MTQwMF0gdHlwZSAwIGNsYXNzIDB4MDAwNjAwClsgICAgMC41NTIyMThdIHBjaSAwMDAwOjAw
OjE4LjE6IFsxMDIyOjE0MDFdIHR5cGUgMCBjbGFzcyAweDAwMDYwMApbICAgIDAuNTUyMjMzXSBw
Y2kgMDAwMDowMDoxOC4yOiBbMTAyMjoxNDAyXSB0eXBlIDAgY2xhc3MgMHgwMDA2MDAKWyAgICAw
LjU1MjI0OF0gcGNpIDAwMDA6MDA6MTguMzogWzEwMjI6MTQwM10gdHlwZSAwIGNsYXNzIDB4MDAw
NjAwClsgICAgMC41NTIyNjVdIHBjaSAwMDAwOjAwOjE4LjQ6IFsxMDIyOjE0MDRdIHR5cGUgMCBj
bGFzcyAweDAwMDYwMApbICAgIDAuNTUyMjc5XSBwY2kgMDAwMDowMDoxOC41OiBbMTAyMjoxNDA1
XSB0eXBlIDAgY2xhc3MgMHgwMDA2MDAKWyAgICAwLjU1MjM1MF0gcGNpIDAwMDA6MDA6MTQuNDog
UENJIGJyaWRnZSB0byBbYnVzIDAxLTAxXSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuNTUy
MzU1XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweGYwMDAtMHgwMDAw
XSAoZGlzYWJsZWQpClsgICAgMC41NTIzNTldIHBjaSAwMDAwOjAwOjE0LjQ6ICAgYnJpZGdlIHdp
bmRvdyBbbWVtIDB4ZmZmMDAwMDAtMHgwMDBmZmZmZl0gKGRpc2FibGVkKQpbICAgIDAuNTUyMzYz
XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweGZmZjAwMDAwLTB4MDAw
ZmZmZmYgcHJlZl0gKGRpc2FibGVkKQpbICAgIDAuNTUyMzY1XSBwY2kgMDAwMDowMDoxNC40OiAg
IGJyaWRnZSB3aW5kb3cgW2lvICAweDAwMDAtMHgwM2FmXSAoc3VidHJhY3RpdmUgZGVjb2RlKQpb
ICAgIDAuNTUyMzY3XSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDAz
ZTAtMHgwY2Y3XSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuNTUyMzcwXSBwY2kgMDAwMDow
MDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW2lvICAweDAzYjAtMHgwM2RmXSAoc3VidHJhY3RpdmUg
ZGVjb2RlKQpbICAgIDAuNTUyMzcyXSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cg
W2lvICAweDBkMDAtMHhmZmZmXSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAuNTUyMzc0XSBw
Y2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDAwMGEwMDAwLTB4MDAwYmZm
ZmZdIChzdWJ0cmFjdGl2ZSBkZWNvZGUpClsgICAgMC41NTIzNzZdIHBjaSAwMDAwOjAwOjE0LjQ6
ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZl0gKHN1YnRyYWN0aXZl
IGRlY29kZSkKWyAgICAwLjU1MjM3OF0gcGNpIDAwMDA6MDA6MTQuNDogICBicmlkZ2Ugd2luZG93
IFttZW0gMHg3ZjAwMDAwMC0weGZmZmZmZmZmXSAoc3VidHJhY3RpdmUgZGVjb2RlKQpbICAgIDAu
NTUyNDE5XSBwY2kgMDAwMDowMDoxNS4wOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDItMDJdClsgICAg
MC41NTI0MjRdIHBjaSAwMDAwOjAwOjE1LjA6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4ZmZmMDAw
LTB4MDAwMF0gKGRpc2FibGVkKQpbICAgIDAuNTUyNDI4XSBwY2kgMDAwMDowMDoxNS4wOiAgIGJy
aWRnZSB3aW5kb3cgW21lbSAweGZmZjAwMDAwLTB4MDAwZmZmZmZdIChkaXNhYmxlZCkKWyAgICAw
LjU1MjQzM10gcGNpIDAwMDA6MDA6MTUuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhmZmYwMDAw
MC0weDAwMGZmZmZmIHByZWZdIChkaXNhYmxlZCkKWyAgICAwLjU1MjQ5MF0gcGNpIDAwMDA6MDM6
MDAuMDogWzEwZWM6ODE2OF0gdHlwZSAwIGNsYXNzIDB4MDAwMjAwClsgICAgMC41NTI1MDZdIHBj
aSAwMDAwOjAzOjAwLjA6IHJlZyAxMDogW2lvICAweGUwMDAtMHhlMGZmXQpbICAgIDAuNTUyNTM0
XSBwY2kgMDAwMDowMzowMC4wOiByZWcgMTg6IFttZW0gMHhkMDAwNDAwMC0weGQwMDA0ZmZmIDY0
Yml0IHByZWZdClsgICAgMC41NTI1NTFdIHBjaSAwMDAwOjAzOjAwLjA6IHJlZyAyMDogW21lbSAw
eGQwMDAwMDAwLTB4ZDAwMDNmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU1MjYwMV0gcGNpIDAwMDA6
MDM6MDAuMDogc3VwcG9ydHMgRDEgRDIKWyAgICAwLjU1MjYwM10gcGNpIDAwMDA6MDM6MDAuMDog
UE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEMSBEMiBEM2hvdCBEM2NvbGQKWyAgICAwLjU1MjYwN10g
cGNpIDAwMDA6MDM6MDAuMDogUE1FIyBkaXNhYmxlZApbICAgIDAuNTcwMDUzXSBwY2kgMDAwMDow
MDoxNS4xOiBQQ0kgYnJpZGdlIHRvIFtidXMgMDMtMDNdClsgICAgMC41NzAwNjFdIHBjaSAwMDAw
OjAwOjE1LjE6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIDB4ZTAwMC0weGVmZmZdClsgICAgMC41NzAw
NjVdIHBjaSAwMDAwOjAwOjE1LjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ZmZmMDAwMDAtMHgw
MDBmZmZmZl0gKGRpc2FibGVkKQpbICAgIDAuNTcwMDcxXSBwY2kgMDAwMDowMDoxNS4xOiAgIGJy
aWRnZSB3aW5kb3cgW21lbSAweGQwMDAwMDAwLTB4ZDAwZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAw
LjU3MDA5Ml0gQUNQSTogUENJIEludGVycnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLl9Q
UlRdClsgICAgMC41NzAzNDddIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9T
Ql8uUENJMC5QRTIwLl9QUlRdClsgICAgMC41NzAzNzldIEFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91
dGluZyBUYWJsZSBbXF9TQl8uUENJMC5QRTIxLl9QUlRdClsgICAgMC41NzA0NDBdIEFDUEk6IFBD
SSBJbnRlcnJ1cHQgUm91dGluZyBUYWJsZSBbXF9TQl8uUENJMC5QMFBDLl9QUlRdClsgICAgMC41
NzA2MTNdICBwY2kwMDAwOjAwOiBSZXF1ZXN0aW5nIEFDUEkgX09TQyBjb250cm9sICgweDFkKQpb
ICAgIDAuNTcwNzg2XSAgcGNpMDAwMDowMDogQUNQSSBfT1NDIGNvbnRyb2wgKDB4MWQpIGdyYW50
ZWQKWyAgICAwLjU3Njg4Ml0gQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktBXSAoSVJRcyAz
IDQgNSA2IDcgMTAgKjExIDE0IDE1KQpbICAgIDAuNTc2OTQ0XSBBQ1BJOiBQQ0kgSW50ZXJydXB0
IExpbmsgW0xOS0JdIChJUlFzIDMgNCA1IDYgNyAqMTAgMTEgMTQgMTUpClsgICAgMC41NzcwMDhd
IEFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQ10gKElSUXMgNCA1IDcgMTAgKjExIDE0IDE1
KQpbICAgIDAuNTc3MDcyXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0RdIChJUlFzICoz
IDQgNiA3IDEwIDExIDE0IDE1KQpbICAgIDAuNTc3MTIxXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExp
bmsgW0xOS0VdIChJUlFzIDQgNSA3IDEwIDExIDE0IDE1KSAqMApbICAgIDAuNTc3MTU5XSBBQ1BJ
OiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0ZdIChJUlFzIDQgNSA3IDEwIDExIDE0IDE1KSAqMApb
ICAgIDAuNTc3MTk2XSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0ddIChJUlFzIDQgNSA3
IDEwIDExIDE0IDE1KSAqMApbICAgIDAuNTc3MjMzXSBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsg
W0xOS0hdIChJUlFzIDQgNSA3IDEwIDExIDE0IDE1KSAqMApbICAgIDAuNTc3MzMwXSB2Z2FhcmI6
IGRldmljZSBhZGRlZDogUENJOjAwMDA6MDA6MDEuMCxkZWNvZGVzPWlvK21lbSxvd25zPWlvK21l
bSxsb2Nrcz1ub25lClsgICAgMC41NzczNDBdIHZnYWFyYjogbG9hZGVkClsgICAgMC41Nzc0OThd
IFNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkClsgICAgMC41Nzc1MTVdIGxpYmF0YSB2ZXJzaW9u
IDMuMDAgbG9hZGVkLgpbICAgIDAuNTc3NTE1XSB1c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRl
cmZhY2UgZHJpdmVyIHVzYmZzClsgICAgMC41Nzc1MTVdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3
IGludGVyZmFjZSBkcml2ZXIgaHViClsgICAgMC41Nzc1MTVdIHVzYmNvcmU6IHJlZ2lzdGVyZWQg
bmV3IGRldmljZSBkcml2ZXIgdXNiClsgICAgMC41Nzc1MTVdIHdtaTogTWFwcGVyIGxvYWRlZApb
ICAgIDAuNTc3NTE1XSBQQ0k6IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5nClsgICAgMC41Nzc1
MTVdIFBDSTogcGNpX2NhY2hlX2xpbmVfc2l6ZSBzZXQgdG8gNjQgYnl0ZXMKWyAgICAwLjU3NzUx
NV0gcmVzZXJ2ZSBSQU0gYnVmZmVyOiAwMDAwMDAwMDAwMDlmYzAwIC0gMDAwMDAwMDAwMDA5ZmZm
ZiAKWyAgICAwLjU3NzUxNV0gcmVzZXJ2ZSBSQU0gYnVmZmVyOiAwMDAwMDAwMDViYjhjMDAwIC0g
MDAwMDAwMDA1YmZmZmZmZiAKWyAgICAwLjU3NzUxNV0gcmVzZXJ2ZSBSQU0gYnVmZmVyOiAwMDAw
MDAwMDVjMjJiMDAwIC0gMDAwMDAwMDA1ZmZmZmZmZiAKWyAgICAwLjU3NzUxNV0gcmVzZXJ2ZSBS
QU0gYnVmZmVyOiAwMDAwMDAwMDVkOTEwMDAwIC0gMDAwMDAwMDA1ZmZmZmZmZiAKWyAgICAwLjU3
NzUxNV0gcmVzZXJ2ZSBSQU0gYnVmZmVyOiAwMDAwMDAwMDVkYzZlMDAwIC0gMDAwMDAwMDA1ZmZm
ZmZmZiAKWyAgICAwLjU3NzUxNV0gcmVzZXJ2ZSBSQU0gYnVmZmVyOiAwMDAwMDAwMDVlNDcwMDAw
IC0gMDAwMDAwMDA1ZmZmZmZmZiAKWyAgICAwLjU3NzUxNV0gcmVzZXJ2ZSBSQU0gYnVmZmVyOiAw
MDAwMDAwMDVlODAwMDAwIC0gMDAwMDAwMDA1ZmZmZmZmZiAKWyAgICAwLjU3NzUxNV0gTmV0TGFi
ZWw6IEluaXRpYWxpemluZwpbICAgIDAuNTc3NTE1XSBOZXRMYWJlbDogIGRvbWFpbiBoYXNoIHNp
emUgPSAxMjgKWyAgICAwLjU3NzUxNV0gTmV0TGFiZWw6ICBwcm90b2NvbHMgPSBVTkxBQkVMRUQg
Q0lQU092NApbICAgIDAuNTc3NTE1XSBOZXRMYWJlbDogIHVubGFiZWxlZCB0cmFmZmljIGFsbG93
ZWQgYnkgZGVmYXVsdApbICAgIDAuNTc3NTE1XSBocGV0MDogYXQgTU1JTyAweGZlZDAwMDAwLCBJ
UlFzIDIsIDgsIDAKWyAgICAwLjU3NzUxNV0gaHBldDA6IDMgY29tcGFyYXRvcnMsIDMyLWJpdCAx
NC4zMTgxODAgTUh6IGNvdW50ZXIKWyAgICAwLjU4MDAxM10gU3dpdGNoaW5nIHRvIGNsb2Nrc291
cmNlIGhwZXQKWyAgICAwLjU4NTI3M10gQXBwQXJtb3I6IEFwcEFybW9yIEZpbGVzeXN0ZW0gRW5h
YmxlZApbICAgIDAuNTg1Mjk4XSBwbnA6IFBuUCBBQ1BJIGluaXQKWyAgICAwLjU4NTMxNF0gQUNQ
STogYnVzIHR5cGUgcG5wIHJlZ2lzdGVyZWQKWyAgICAwLjU4NTUwN10gcG5wIDAwOjAwOiBbYnVz
IDAwLWZmXQpbICAgIDAuNTg1NTA5XSBwbnAgMDA6MDA6IFtpbyAgMHgwY2Y4LTB4MGNmZl0KWyAg
ICAwLjU4NTUxMV0gcG5wIDAwOjAwOiBbaW8gIDB4MDAwMC0weDAzYWYgd2luZG93XQpbICAgIDAu
NTg1NTEzXSBwbnAgMDA6MDA6IFtpbyAgMHgwM2UwLTB4MGNmNyB3aW5kb3ddClsgICAgMC41ODU1
MTVdIHBucCAwMDowMDogW2lvICAweDAzYjAtMHgwM2RmIHdpbmRvd10KWyAgICAwLjU4NTUxNl0g
cG5wIDAwOjAwOiBbaW8gIDB4MGQwMC0weGZmZmYgd2luZG93XQpbICAgIDAuNTg1NTE4XSBwbnAg
MDA6MDA6IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRvd10KWyAgICAwLjU4NTUyMF0g
cG5wIDAwOjAwOiBbbWVtIDB4MDAwYzAwMDAtMHgwMDBkZmZmZiB3aW5kb3ddClsgICAgMC41ODU1
MjJdIHBucCAwMDowMDogW21lbSAweDdmMDAwMDAwLTB4ZmZmZmZmZmYgd2luZG93XQpbICAgIDAu
NTg1NTI0XSBwbnAgMDA6MDA6IFttZW0gMHgwMDAwMDAwMCB3aW5kb3ddClsgICAgMC41ODU1Njld
IHBucCAwMDowMDogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDBhMDMgKGFjdGl2
ZSkKWyAgICAwLjU4NTYwMl0gcG5wIDAwOjAxOiBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0K
WyAgICAwLjU4NTY0M10gc3lzdGVtIDAwOjAxOiBbbWVtIDB4ZTAwMDAwMDAtMHhlZmZmZmZmZl0g
aGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NTY0Nl0gc3lzdGVtIDAwOjAxOiBQbHVnIGFuZCBQ
bGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5QMGMwMSAoYWN0aXZlKQpbICAgIDAuNTg1Njk5XSBwbnAg
MDA6MDI6IFttZW0gMHg1ZjAwMDAwMC0weDdlZmZmZmZmXQpbICAgIDAuNTg1NzMxXSBzeXN0ZW0g
MDA6MDI6IFttZW0gMHg1ZjAwMDAwMC0weDdlZmZmZmZmXSBjb3VsZCBub3QgYmUgcmVzZXJ2ZWQK
WyAgICAwLjU4NTczNF0gc3lzdGVtIDAwOjAyOiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJ
RHMgUE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuNTg1Nzg3XSBwbnAgMDA6MDM6IFttZW0gMHhmZWI4
MDAwMC0weGZlYmZmZmZmXQpbICAgIDAuNTg1ODE4XSBzeXN0ZW0gMDA6MDM6IFttZW0gMHhmZWI4
MDAwMC0weGZlYmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg1ODIxXSBzeXN0ZW0g
MDA6MDM6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUpClsg
ICAgMC41ODYwNjJdIHBucCAwMDowNDogW2lvICAweDAwMTAtMHgwMDFmXQpbICAgIDAuNTg2MDY0
XSBwbnAgMDA6MDQ6IFtpbyAgMHgwMDIyLTB4MDAzZl0KWyAgICAwLjU4NjA2NV0gcG5wIDAwOjA0
OiBbaW8gIDB4MDA2M10KWyAgICAwLjU4NjA2N10gcG5wIDAwOjA0OiBbaW8gIDB4MDA2NV0KWyAg
ICAwLjU4NjA3MF0gcG5wIDAwOjA0OiBbaW8gIDB4MDA2Ny0weDAwNmZdClsgICAgMC41ODYwNzJd
IHBucCAwMDowNDogW2lvICAweDAwNzItMHgwMDdmXQpbICAgIDAuNTg2MDczXSBwbnAgMDA6MDQ6
IFtpbyAgMHgwMDgwXQpbICAgIDAuNTg2MDc1XSBwbnAgMDA6MDQ6IFtpbyAgMHgwMDg0LTB4MDA4
Nl0KWyAgICAwLjU4NjA3Nl0gcG5wIDAwOjA0OiBbaW8gIDB4MDA4OF0KWyAgICAwLjU4NjA3N10g
cG5wIDAwOjA0OiBbaW8gIDB4MDA4Yy0weDAwOGVdClsgICAgMC41ODYwNzldIHBucCAwMDowNDog
W2lvICAweDAwOTAtMHgwMDlmXQpbICAgIDAuNTg2MDgwXSBwbnAgMDA6MDQ6IFtpbyAgMHgwMGEy
LTB4MDBiZl0KWyAgICAwLjU4NjA4Ml0gcG5wIDAwOjA0OiBbaW8gIDB4MDBiMV0KWyAgICAwLjU4
NjA4M10gcG5wIDAwOjA0OiBbaW8gIDB4MDBlMC0weDAwZWZdClsgICAgMC41ODYwODRdIHBucCAw
MDowNDogW2lvICAweDA0ZDAtMHgwNGQxXQpbICAgIDAuNTg2MDg2XSBwbnAgMDA6MDQ6IFtpbyAg
MHgwNDBiXQpbICAgIDAuNTg2MDg3XSBwbnAgMDA6MDQ6IFtpbyAgMHgwNGQ2XQpbICAgIDAuNTg2
MDg4XSBwbnAgMDA6MDQ6IFtpbyAgMHgwYzAwLTB4MGMwMV0KWyAgICAwLjU4NjA5MF0gcG5wIDAw
OjA0OiBbaW8gIDB4MGMxNF0KWyAgICAwLjU4NjA5MV0gcG5wIDAwOjA0OiBbaW8gIDB4MGM1MC0w
eDBjNTFdClsgICAgMC41ODYwOTNdIHBucCAwMDowNDogW2lvICAweDBjNTJdClsgICAgMC41ODYw
OTRdIHBucCAwMDowNDogW2lvICAweDBjNmNdClsgICAgMC41ODYwOTVdIHBucCAwMDowNDogW2lv
ICAweDBjNmZdClsgICAgMC41ODYwOTddIHBucCAwMDowNDogW2lvICAweDBjZDAtMHgwY2QxXQpb
ICAgIDAuNTg2MDk4XSBwbnAgMDA6MDQ6IFtpbyAgMHgwY2QyLTB4MGNkM10KWyAgICAwLjU4NjA5
OV0gcG5wIDAwOjA0OiBbaW8gIDB4MGNkNC0weDBjZDVdClsgICAgMC41ODYxMDFdIHBucCAwMDow
NDogW2lvICAweDBjZDYtMHgwY2Q3XQpbICAgIDAuNTg2MTAyXSBwbnAgMDA6MDQ6IFtpbyAgMHgw
Y2Q4LTB4MGNkZl0KWyAgICAwLjU4NjEwNF0gcG5wIDAwOjA0OiBbaW8gIDB4MDgwMC0weDA4OWZd
ClsgICAgMC41ODYxMDVdIHBucCAwMDowNDogW2lvICAweDAwMDAtMHhmZmZmZmZmZmZmZmZmZmZm
IGRpc2FibGVkXQpbICAgIDAuNTg2MTA3XSBwbnAgMDA6MDQ6IFtpbyAgMHgwMDAwLTB4MDAwZl0K
WyAgICAwLjU4NjEwOV0gcG5wIDAwOjA0OiBbaW8gIDB4MGIyMC0weDBiM2ZdClsgICAgMC41ODYx
MTBdIHBucCAwMDowNDogW2lvICAweDA5MDAtMHgwOTBmXQpbICAgIDAuNTg2MTExXSBwbnAgMDA6
MDQ6IFtpbyAgMHgwOTEwLTB4MDkxZl0KWyAgICAwLjU4NjExM10gcG5wIDAwOjA0OiBbaW8gIDB4
ZmUwMC0weGZlZmVdClsgICAgMC41ODYxMTRdIHBucCAwMDowNDogW2lvICAweDAwNjAtMHgwMDVm
IGRpc2FibGVkXQpbICAgIDAuNTg2MTE2XSBwbnAgMDA6MDQ6IFtpbyAgMHgwMDY0LTB4MDA2MyBk
aXNhYmxlZF0KWyAgICAwLjU4NjExOF0gcG5wIDAwOjA0OiBbbWVtIDB4ZmVjMDAwMDAtMHhmZWMw
MGZmZl0KWyAgICAwLjU4NjExOV0gcG5wIDAwOjA0OiBbbWVtIDB4ZmVlMDAwMDAtMHhmZWUwMGZm
Zl0KWyAgICAwLjU4NjEyMV0gcG5wIDAwOjA0OiBbbWVtIDB4ZmVkODAwMDAtMHhmZWQ4ZmZmZl0K
WyAgICAwLjU4NjEyM10gcG5wIDAwOjA0OiBbbWVtIDB4ZmVkNjEwMDAtMHhmZWQ3MGZmZl0KWyAg
ICAwLjU4NjEyNF0gcG5wIDAwOjA0OiBbbWVtIDB4ZmVjMTAwMDAtMHhmZWMxMGZmZl0KWyAgICAw
LjU4NjEyNl0gcG5wIDAwOjA0OiBbbWVtIDB4ZmVkMDAwMDAtMHhmZWQwMGZmZl0KWyAgICAwLjU4
NjEyN10gcG5wIDAwOjA0OiBbbWVtIDB4ZmYwMDAwMDAtMHhmZmZmZmZmZl0KWyAgICAwLjU4NjI4
NV0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4MDRkMC0weDA0ZDFdIGhhcyBiZWVuIHJlc2VydmVkClsg
ICAgMC41ODYyODddIHN5c3RlbSAwMDowNDogW2lvICAweDA0MGJdIGhhcyBiZWVuIHJlc2VydmVk
ClsgICAgMC41ODYyOTBdIHN5c3RlbSAwMDowNDogW2lvICAweDA0ZDZdIGhhcyBiZWVuIHJlc2Vy
dmVkClsgICAgMC41ODYyOTJdIHN5c3RlbSAwMDowNDogW2lvICAweDBjMDAtMHgwYzAxXSBoYXMg
YmVlbiByZXNlcnZlZApbICAgIDAuNTg2Mjk0XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHgwYzE0XSBo
YXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg2Mjk2XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHgwYzUw
LTB4MGM1MV0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NjI5OF0gc3lzdGVtIDAwOjA0OiBb
aW8gIDB4MGM1Ml0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NjMwMF0gc3lzdGVtIDAwOjA0
OiBbaW8gIDB4MGM2Y10gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NjMwMl0gc3lzdGVtIDAw
OjA0OiBbaW8gIDB4MGM2Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NjMwNF0gc3lzdGVt
IDAwOjA0OiBbaW8gIDB4MGNkMC0weDBjZDFdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41ODYz
MDddIHN5c3RlbSAwMDowNDogW2lvICAweDBjZDItMHgwY2QzXSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDAuNTg2MzA5XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHgwY2Q0LTB4MGNkNV0gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAwLjU4NjMxMV0gc3lzdGVtIDAwOjA0OiBbaW8gIDB4MGNkNi0weDBjZDdd
IGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41ODYzMTNdIHN5c3RlbSAwMDowNDogW2lvICAweDBj
ZDgtMHgwY2RmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg2MzE1XSBzeXN0ZW0gMDA6MDQ6
IFtpbyAgMHgwODAwLTB4MDg5Zl0gaGFzIGJlZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NjMxOF0gc3lz
dGVtIDAwOjA0OiBbaW8gIDB4MGIyMC0weDBiM2ZdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41
ODYzMjNdIHN5c3RlbSAwMDowNDogW2lvICAweDA5MDAtMHgwOTBmXSBoYXMgYmVlbiByZXNlcnZl
ZApbICAgIDAuNTg2MzI1XSBzeXN0ZW0gMDA6MDQ6IFtpbyAgMHgwOTEwLTB4MDkxZl0gaGFzIGJl
ZW4gcmVzZXJ2ZWQKWyAgICAwLjU4NjMyN10gc3lzdGVtIDAwOjA0OiBbaW8gIDB4ZmUwMC0weGZl
ZmVdIGhhcyBiZWVuIHJlc2VydmVkClsgICAgMC41ODYzMzFdIHN5c3RlbSAwMDowNDogW21lbSAw
eGZlYzAwMDAwLTB4ZmVjMDBmZmZdIGNvdWxkIG5vdCBiZSByZXNlcnZlZApbICAgIDAuNTg2MzM0
XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWUwMDAwMC0weGZlZTAwZmZmXSBoYXMgYmVlbiByZXNl
cnZlZApbICAgIDAuNTg2MzM2XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQ4MDAwMC0weGZlZDhm
ZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg2MzM5XSBzeXN0ZW0gMDA6MDQ6IFttZW0g
MHhmZWQ2MTAwMC0weGZlZDcwZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg2MzQxXSBz
eXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWMxMDAwMC0weGZlYzEwZmZmXSBoYXMgYmVlbiByZXNlcnZl
ZApbICAgIDAuNTg2MzQ0XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhmZWQwMDAwMC0weGZlZDAwZmZm
XSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg2MzQ3XSBzeXN0ZW0gMDA6MDQ6IFttZW0gMHhm
ZjAwMDAwMC0weGZmZmZmZmZmXSBoYXMgYmVlbiByZXNlcnZlZApbICAgIDAuNTg2MzUwXSBzeXN0
ZW0gMDA6MDQ6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYzAyIChhY3RpdmUp
ClsgICAgMC41ODY0NDddIHBucCAwMDowNTogW2lvICAweDAwMDAtMHhmZmZmZmZmZmZmZmZmZmZm
IGRpc2FibGVkXQpbICAgIDAuNTg2NDQ5XSBwbnAgMDA6MDU6IFtpbyAgMHgwYTAwLTB4MGExZl0K
WyAgICAwLjU4NjQ1M10gcG5wIDAwOjA1OiBbaW8gIDB4MGU4MC0weDBlOGZdClsgICAgMC41ODY0
ODddIHN5c3RlbSAwMDowNTogW2lvICAweDBhMDAtMHgwYTFmXSBoYXMgYmVlbiByZXNlcnZlZApb
ICAgIDAuNTg2NDkwXSBzeXN0ZW0gMDA6MDU6IFtpbyAgMHgwZTgwLTB4MGU4Zl0gaGFzIGJlZW4g
cmVzZXJ2ZWQKWyAgICAwLjU4NjQ5Ml0gc3lzdGVtIDAwOjA1OiBQbHVnIGFuZCBQbGF5IEFDUEkg
ZGV2aWNlLCBJRHMgUE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuNTg2NzQ0XSBwbnAgMDA6MDY6IFtp
byAgMHgwM2Y4LTB4MDNmZl0KWyAgICAwLjU4Njc1NV0gcG5wIDAwOjA2OiBbaXJxIDRdClsgICAg
MC41ODY3NTZdIHBucCAwMDowNjogW2RtYSAwIGRpc2FibGVkXQpbICAgIDAuNTg2Nzk5XSBwbnAg
MDA6MDY6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwNTAxIChhY3RpdmUpClsg
ICAgMC41ODcxMDFdIHBucCAwMDowNzogW2lvICAweDAzNzgtMHgwMzdmXQpbICAgIDAuNTg3MTA1
XSBwbnAgMDA6MDc6IFtpcnEgNV0KWyAgICAwLjU4NzEwN10gcG5wIDAwOjA3OiBbZG1hIDNdClsg
ICAgMC41ODcyMTZdIHBucCAwMDowNzogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBO
UDA0MDAgKGFjdGl2ZSkKWyAgICAwLjU4NzI2MF0gc3lzdGVtIDAwOjA4OiBQbHVnIGFuZCBQbGF5
IEFDUEkgZGV2aWNlLCBJRHMgUE5QMGMwMiAoYWN0aXZlKQpbICAgIDAuNTg3Mjc5XSBwbnAgMDA6
MDk6IFtkbWEgNF0KWyAgICAwLjU4NzI4MF0gcG5wIDAwOjA5OiBbaW8gIDB4MDAwMC0weDAwMGZd
ClsgICAgMC41ODcyODJdIHBucCAwMDowOTogW2lvICAweDAwODEtMHgwMDgzXQpbICAgIDAuNTg3
Mjg0XSBwbnAgMDA6MDk6IFtpbyAgMHgwMDg3XQpbICAgIDAuNTg3Mjg1XSBwbnAgMDA6MDk6IFtp
byAgMHgwMDg5LTB4MDA4Yl0KWyAgICAwLjU4NzI4Nl0gcG5wIDAwOjA5OiBbaW8gIDB4MDA4Zl0K
WyAgICAwLjU4NzI4OF0gcG5wIDAwOjA5OiBbaW8gIDB4MDBjMC0weDAwZGZdClsgICAgMC41ODcz
MTBdIHBucCAwMDowOTogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDAyMDAgKGFj
dGl2ZSkKWyAgICAwLjU4NzMxOV0gcG5wIDAwOjBhOiBbaW8gIDB4MDA3MC0weDAwNzFdClsgICAg
MC41ODczMjNdIHBucCAwMDowYTogW2lycSA4XQpbICAgIDAuNTg3MzQ0XSBwbnAgMDA6MGE6IFBs
dWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElEcyBQTlAwYjAwIChhY3RpdmUpClsgICAgMC41ODcz
NTFdIHBucCAwMDowYjogW2lvICAweDAwNjFdClsgICAgMC41ODczNzJdIHBucCAwMDowYjogUGx1
ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwgSURzIFBOUDA4MDAgKGFjdGl2ZSkKWyAgICAwLjU4NzM5
N10gcG5wIDAwOjBjOiBbaW8gIDB4MDAxMC0weDAwMWZdClsgICAgMC41ODczOThdIHBucCAwMDow
YzogW2lvICAweDAwMjItMHgwMDNmXQpbICAgIDAuNTg3NDAwXSBwbnAgMDA6MGM6IFtpbyAgMHgw
MDQ0LTB4MDA1Zl0KWyAgICAwLjU4NzQwMl0gcG5wIDAwOjBjOiBbaW8gIDB4MDA2Mi0weDAwNjNd
ClsgICAgMC41ODc0MDNdIHBucCAwMDowYzogW2lvICAweDAwNjUtMHgwMDZmXQpbICAgIDAuNTg3
NDA1XSBwbnAgMDA6MGM6IFtpbyAgMHgwMDcyLTB4MDA3Zl0KWyAgICAwLjU4NzQwNl0gcG5wIDAw
OjBjOiBbaW8gIDB4MDA4MF0KWyAgICAwLjU4NzQwOV0gcG5wIDAwOjBjOiBbaW8gIDB4MDA4NC0w
eDAwODZdClsgICAgMC41ODc0MTFdIHBucCAwMDowYzogW2lvICAweDAwODhdClsgICAgMC41ODc0
MTJdIHBucCAwMDowYzogW2lvICAweDAwOGMtMHgwMDhlXQpbICAgIDAuNTg3NDEzXSBwbnAgMDA6
MGM6IFtpbyAgMHgwMDkwLTB4MDA5Zl0KWyAgICAwLjU4NzQxNV0gcG5wIDAwOjBjOiBbaW8gIDB4
MDBhMi0weDAwYmZdClsgICAgMC41ODc0MTZdIHBucCAwMDowYzogW2lvICAweDAwZTAtMHgwMGVm
XQpbICAgIDAuNTg3NDE4XSBwbnAgMDA6MGM6IFtpbyAgMHgwNGQwLTB4MDRkMV0KWyAgICAwLjU4
NzQ3MV0gc3lzdGVtIDAwOjBjOiBbaW8gIDB4MDRkMC0weDA0ZDFdIGhhcyBiZWVuIHJlc2VydmVk
ClsgICAgMC41ODc0NzRdIHN5c3RlbSAwMDowYzogUGx1ZyBhbmQgUGxheSBBQ1BJIGRldmljZSwg
SURzIFBOUDBjMDIgKGFjdGl2ZSkKWyAgICAwLjU4NzQ4MV0gcG5wIDAwOjBkOiBbaW8gIDB4MDBm
MC0weDAwZmZdClsgICAgMC41ODc0ODZdIHBucCAwMDowZDogW2lycSAxM10KWyAgICAwLjU4NzUw
N10gcG5wIDAwOjBkOiBQbHVnIGFuZCBQbGF5IEFDUEkgZGV2aWNlLCBJRHMgUE5QMGMwNCAoYWN0
aXZlKQpbICAgIDAuNTg3NjgxXSBwbnAgMDA6MGU6IFttZW0gMHhmZWQwMDAwMC0weGZlZDAwM2Zm
XQpbICAgIDAuNTg3NzExXSBwbnAgMDA6MGU6IFBsdWcgYW5kIFBsYXkgQUNQSSBkZXZpY2UsIElE
cyBQTlAwMTAzIChhY3RpdmUpClsgICAgMC41ODc3MThdIHBucDogUG5QIEFDUEk6IGZvdW5kIDE1
IGRldmljZXMKWyAgICAwLjU4NzcyMF0gQUNQSTogQUNQSSBidXMgdHlwZSBwbnAgdW5yZWdpc3Rl
cmVkClsgICAgMC41ODk4NzJdIFN3aXRjaGVkIHRvIE5PSHogbW9kZSBvbiBDUFUgIzAKWyAgICAw
LjU4OTk2NF0gU3dpdGNoZWQgdG8gTk9IeiBtb2RlIG9uIENQVSAjMQpbICAgIDAuNTkzNDE2XSBw
Y2kgMDAwMDowMDoxNC40OiBQQ0kgYnJpZGdlIHRvIFtidXMgMDEtMDFdClsgICAgMC41OTM0MThd
IHBjaSAwMDAwOjAwOjE0LjQ6ICAgYnJpZGdlIHdpbmRvdyBbaW8gIGRpc2FibGVkXQpbICAgIDAu
NTkzNDIyXSBwY2kgMDAwMDowMDoxNC40OiAgIGJyaWRnZSB3aW5kb3cgW21lbSBkaXNhYmxlZF0K
WyAgICAwLjU5MzQyNV0gcGNpIDAwMDA6MDA6MTQuNDogICBicmlkZ2Ugd2luZG93IFttZW0gcHJl
ZiBkaXNhYmxlZF0KWyAgICAwLjU5MzQzMV0gcGNpIDAwMDA6MDA6MTUuMDogUENJIGJyaWRnZSB0
byBbYnVzIDAyLTAyXQpbICAgIDAuNTkzNDMyXSBwY2kgMDAwMDowMDoxNS4wOiAgIGJyaWRnZSB3
aW5kb3cgW2lvICBkaXNhYmxlZF0KWyAgICAwLjU5MzQzNl0gcGNpIDAwMDA6MDA6MTUuMDogICBi
cmlkZ2Ugd2luZG93IFttZW0gZGlzYWJsZWRdClsgICAgMC41OTM0MzldIHBjaSAwMDAwOjAwOjE1
LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIHByZWYgZGlzYWJsZWRdClsgICAgMC41OTM0NDRdIHBj
aSAwMDAwOjAwOjE1LjE6IFBDSSBicmlkZ2UgdG8gW2J1cyAwMy0wM10KWyAgICAwLjU5MzQ0Nl0g
cGNpIDAwMDA6MDA6MTUuMTogICBicmlkZ2Ugd2luZG93IFtpbyAgMHhlMDAwLTB4ZWZmZl0KWyAg
ICAwLjU5MzQ1MF0gcGNpIDAwMDA6MDA6MTUuMTogICBicmlkZ2Ugd2luZG93IFttZW0gZGlzYWJs
ZWRdClsgICAgMC41OTM0NTRdIHBjaSAwMDAwOjAwOjE1LjE6ICAgYnJpZGdlIHdpbmRvdyBbbWVt
IDB4ZDAwMDAwMDAtMHhkMDBmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNTkzNDczXSBwY2kgMDAw
MDowMDoxNS4wOiBQQ0kgSU5UIEEgLT4gR1NJIDE2IChsZXZlbCwgbG93KSAtPiBJUlEgMTYKWyAg
ICAwLjU5MzQ3N10gcGNpIDAwMDA6MDA6MTUuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0
ClsgICAgMC41OTM0ODJdIHBjaSAwMDAwOjAwOjE1LjE6IFBDSSBJTlQgQSAtPiBHU0kgMTYgKGxl
dmVsLCBsb3cpIC0+IElSUSAxNgpbICAgIDAuNTkzNDg2XSBwY2kgMDAwMDowMDoxNS4xOiBzZXR0
aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAwLjU5MzQ4OV0gcGNpX2J1cyAwMDAwOjAwOiBy
ZXNvdXJjZSA0IFtpbyAgMHgwMDAwLTB4MDNhZl0KWyAgICAwLjU5MzQ5MV0gcGNpX2J1cyAwMDAw
OjAwOiByZXNvdXJjZSA1IFtpbyAgMHgwM2UwLTB4MGNmN10KWyAgICAwLjU5MzQ5M10gcGNpX2J1
cyAwMDAwOjAwOiByZXNvdXJjZSA2IFtpbyAgMHgwM2IwLTB4MDNkZl0KWyAgICAwLjU5MzQ5NV0g
cGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA3IFtpbyAgMHgwZDAwLTB4ZmZmZl0KWyAgICAwLjU5
MzQ5N10gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA4IFttZW0gMHgwMDBhMDAwMC0weDAwMGJm
ZmZmXQpbICAgIDAuNTkzNDk5XSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNlIDkgW21lbSAweDAw
MGMwMDAwLTB4MDAwZGZmZmZdClsgICAgMC41OTM1MDFdIHBjaV9idXMgMDAwMDowMDogcmVzb3Vy
Y2UgMTAgW21lbSAweDdmMDAwMDAwLTB4ZmZmZmZmZmZdClsgICAgMC41OTM1MDNdIHBjaV9idXMg
MDAwMDowMTogcmVzb3VyY2UgNCBbaW8gIDB4MDAwMC0weDAzYWZdClsgICAgMC41OTM1MDVdIHBj
aV9idXMgMDAwMDowMTogcmVzb3VyY2UgNSBbaW8gIDB4MDNlMC0weDBjZjddClsgICAgMC41OTM1
MDZdIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgNiBbaW8gIDB4MDNiMC0weDAzZGZdClsgICAg
MC41OTM1MDhdIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgNyBbaW8gIDB4MGQwMC0weGZmZmZd
ClsgICAgMC41OTM1MTBdIHBjaV9idXMgMDAwMDowMTogcmVzb3VyY2UgOCBbbWVtIDB4MDAwYTAw
MDAtMHgwMDBiZmZmZl0KWyAgICAwLjU5MzUxMl0gcGNpX2J1cyAwMDAwOjAxOiByZXNvdXJjZSA5
IFttZW0gMHgwMDBjMDAwMC0weDAwMGRmZmZmXQpbICAgIDAuNTkzNTE0XSBwY2lfYnVzIDAwMDA6
MDE6IHJlc291cmNlIDEwIFttZW0gMHg3ZjAwMDAwMC0weGZmZmZmZmZmXQpbICAgIDAuNTkzNTE2
XSBwY2lfYnVzIDAwMDA6MDM6IHJlc291cmNlIDAgW2lvICAweGUwMDAtMHhlZmZmXQpbICAgIDAu
NTkzNTE4XSBwY2lfYnVzIDAwMDA6MDM6IHJlc291cmNlIDIgW21lbSAweGQwMDAwMDAwLTB4ZDAw
ZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU5MzU1Ml0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29s
IGZhbWlseSAyClsgICAgMC41OTM2NjJdIElQIHJvdXRlIGNhY2hlIGhhc2ggdGFibGUgZW50cmll
czogNjU1MzYgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMpClsgICAgMC41OTQzMzBdIFRDUCBlc3Rh
Ymxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDEwLCA0MTk0MzA0IGJ5
dGVzKQpbICAgIDAuNTk1MzkwXSBUQ1AgYmluZCBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChv
cmRlcjogOCwgMTA0ODU3NiBieXRlcykKWyAgICAwLjU5NTYyOV0gVENQOiBIYXNoIHRhYmxlcyBj
b25maWd1cmVkIChlc3RhYmxpc2hlZCAyNjIxNDQgYmluZCA2NTUzNikKWyAgICAwLjU5NTYzMV0g
VENQIHJlbm8gcmVnaXN0ZXJlZApbICAgIDAuNTk1NjM4XSBVRFAgaGFzaCB0YWJsZSBlbnRyaWVz
OiAxMDI0IChvcmRlcjogMywgMzI3NjggYnl0ZXMpClsgICAgMC41OTU2NTFdIFVEUC1MaXRlIGhh
c2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzKQpbICAgIDAuNTk1
NzM2XSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEKWyAgICAwLjU5NTc1MV0gcGNp
IDAwMDA6MDA6MDEuMDogQm9vdCB2aWRlbyBkZXZpY2UKWyAgICAwLjY4MDEyN10gUENJOiBDTFMg
NjQgYnl0ZXMsIGRlZmF1bHQgNjQKWyAgICAwLjY4MDE3Ml0gVHJ5aW5nIHRvIHVucGFjayByb290
ZnMgaW1hZ2UgYXMgaW5pdHJhbWZzLi4uClsgICAgMC44MzkyOTFdIEZyZWVpbmcgaW5pdHJkIG1l
bW9yeTogOTk5NmsgZnJlZWQKWyAgICAwLjg0NTE1OF0gcGNpIDAwMDA6MDA6MDAuMjogUENJIElO
VCBBIC0+IEdTSSAxNiAobGV2ZWwsIGxvdykgLT4gSVJRIDE2ClsgICAgMC44NDUzMjVdIHBjaSAw
MDAwOjAwOjAwLjI6IGlycSA0MCBmb3IgTVNJL01TSS1YClsgICAgMC44NDUzNDddIEFNRC1WaTog
RW5hYmxpbmcgSU9NTVUgYXQgMDAwMDowMDowMC4yIGNhcCAweDQwClsgICAgMC44NTcwMjFdIEFN
RC1WaTogTGF6eSBJTy9UTEIgZmx1c2hpbmcgZW5hYmxlZApbICAgIDAuODU3NDU2XSBhdWRpdDog
aW5pdGlhbGl6aW5nIG5ldGxpbmsgc29ja2V0IChkaXNhYmxlZCkKWyAgICAwLjg1NzQ2OF0gdHlw
ZT0yMDAwIGF1ZGl0KDEzNzY0NzUzNjkuODUwOjEpOiBpbml0aWFsaXplZApbICAgIDAuODc0ODU5
XSBIdWdlVExCIHJlZ2lzdGVyZWQgMiBNQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdl
cwpbICAgIDAuODc2NTM1XSBWRlM6IERpc2sgcXVvdGFzIGRxdW90XzYuNS4yClsgICAgMC44NzY1
ODJdIERxdW90LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlciAwLCA0MDk2IGJ5
dGVzKQpbICAgIDAuODc3MTIyXSBmdXNlIGluaXQgKEFQSSB2ZXJzaW9uIDcuMTYpClsgICAgMC44
NzcxOTRdIG1zZ21uaSBoYXMgYmVlbiBzZXQgdG8gMjg3MwpbICAgIDAuODc3NDExXSBCbG9jayBs
YXllciBTQ1NJIGdlbmVyaWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3Ig
MjUzKQpbICAgIDAuODc3NDM4XSBpbyBzY2hlZHVsZXIgbm9vcCByZWdpc3RlcmVkClsgICAgMC44
Nzc0NDBdIGlvIHNjaGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVkClsgICAgMC44Nzc0NzZdIGlv
IHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVsdCkKWyAgICAwLjg3NzU2N10gcGNpZXBv
cnQgMDAwMDowMDoxNS4wOiBzZXR0aW5nIGxhdGVuY3kgdGltZXIgdG8gNjQKWyAgICAwLjg3NzYx
MV0gcGNpZXBvcnQgMDAwMDowMDoxNS4wOiBpcnEgNDEgZm9yIE1TSS9NU0ktWApbICAgIDAuODc3
NjY2XSBwY2llcG9ydCAwMDAwOjAwOjE1LjE6IHNldHRpbmcgbGF0ZW5jeSB0aW1lciB0byA2NApb
ICAgIDAuODc3NzAyXSBwY2llcG9ydCAwMDAwOjAwOjE1LjE6IGlycSA0MiBmb3IgTVNJL01TSS1Y
ClsgICAgMC44Nzc3NzRdIHBjaWVwb3J0IDAwMDA6MDA6MTUuMDogU2lnbmFsaW5nIFBNRSB0aHJv
dWdoIFBDSWUgUE1FIGludGVycnVwdApbICAgIDAuODc3Nzc4XSBwY2llX3BtZSAwMDAwOjAwOjE1
LjA6cGNpZTAxOiBzZXJ2aWNlIGRyaXZlciBwY2llX3BtZSBsb2FkZWQKWyAgICAwLjg3Nzc5Ml0g
cGNpZXBvcnQgMDAwMDowMDoxNS4xOiBTaWduYWxpbmcgUE1FIHRocm91Z2ggUENJZSBQTUUgaW50
ZXJydXB0ClsgICAgMC44Nzc3OTRdIHBjaSAwMDAwOjAzOjAwLjA6IFNpZ25hbGluZyBQTUUgdGhy
b3VnaCBQQ0llIFBNRSBpbnRlcnJ1cHQKWyAgICAwLjg3Nzc5N10gcGNpZV9wbWUgMDAwMDowMDox
NS4xOnBjaWUwMTogc2VydmljZSBkcml2ZXIgcGNpZV9wbWUgbG9hZGVkClsgICAgMC44Nzc4MTBd
IHBjaV9ob3RwbHVnOiBQQ0kgSG90IFBsdWcgUENJIENvcmUgdmVyc2lvbjogMC41ClsgICAgMC44
Nzc4MjhdIHBjaWVocDogUENJIEV4cHJlc3MgSG90IFBsdWcgQ29udHJvbGxlciBEcml2ZXIgdmVy
c2lvbjogMC40ClsgICAgMC44Nzc5MjNdIGlucHV0OiBQb3dlciBCdXR0b24gYXMgL2RldmljZXMv
TE5YU1lTVE06MDAvZGV2aWNlOjAwL1BOUDBDMEM6MDAvaW5wdXQvaW5wdXQwClsgICAgMC44Nzc5
MjldIEFDUEk6IFBvd2VyIEJ1dHRvbiBbUFdSQl0KWyAgICAwLjg3Nzk2MV0gaW5wdXQ6IFBvd2Vy
IEJ1dHRvbiBhcyAvZGV2aWNlcy9MTlhTWVNUTTowMC9MTlhQV1JCTjowMC9pbnB1dC9pbnB1dDEK
WyAgICAwLjg3Nzk2NF0gQUNQSTogUG93ZXIgQnV0dG9uIFtQV1JGXQpbICAgIDAuODc4MTQwXSBB
Q1BJOiBhY3BpX2lkbGUgcmVnaXN0ZXJlZCB3aXRoIGNwdWlkbGUKWyAgICAxLjAyMDU0NF0gRVJT
VDogVGFibGUgaXMgbm90IGZvdW5kIQpbICAgIDEuMDIwNjE1XSBTZXJpYWw6IDgyNTAvMTY1NTAg
ZHJpdmVyLCAzMiBwb3J0cywgSVJRIHNoYXJpbmcgZW5hYmxlZApbICAgIDEuMDQxMTQ5XSBzZXJp
YWw4MjUwOiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQpIGlzIGEgMTY1NTBBClsgICAgMS4w
NjMyMTldIDAwOjA2OiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQpIGlzIGEgMTY1NTBBClsg
ICAgMS4wNjM0MzFdIExpbnV4IGFncGdhcnQgaW50ZXJmYWNlIHYwLjEwMwpbICAgIDEuMDY0MjM5
XSBicmQ6IG1vZHVsZSBsb2FkZWQKWyAgICAxLjA2NDYxNV0gbG9vcDogbW9kdWxlIGxvYWRlZApb
ICAgIDEuMDY0NzgzXSBwYXRhX2FjcGkgMDAwMDowMDoxNC4xOiBQQ0kgSU5UIEIgLT4gR1NJIDE3
IChsZXZlbCwgbG93KSAtPiBJUlEgMTcKWyAgICAxLjA2NDgxMl0gcGF0YV9hY3BpIDAwMDA6MDA6
MTQuMTogUENJIElOVCBCIGRpc2FibGVkClsgICAgMS4wNjUwMzldIEZpeGVkIE1ESU8gQnVzOiBw
cm9iZWQKWyAgICAxLjA2NTA2MV0gUFBQIGdlbmVyaWMgZHJpdmVyIHZlcnNpb24gMi40LjIKWyAg
ICAxLjA2NTA4Nl0gdHVuOiBVbml2ZXJzYWwgVFVOL1RBUCBkZXZpY2UgZHJpdmVyLCAxLjYKWyAg
ICAxLjA2NTA4N10gdHVuOiAoQykgMTk5OS0yMDA0IE1heCBLcmFzbnlhbnNreSA8bWF4a0BxdWFs
Y29tbS5jb20+ClsgICAgMS4wNjUxNDddIGVoY2lfaGNkOiBVU0IgMi4wICdFbmhhbmNlZCcgSG9z
dCBDb250cm9sbGVyIChFSENJKSBEcml2ZXIKWyAgICAxLjA2NTE1N10gZWhjaV9oY2QgMDAwMDow
MDoxMi4yOiBQQ0kgSU5UIEIgLT4gR1NJIDE3IChsZXZlbCwgbG93KSAtPiBJUlEgMTcKWyAgICAx
LjA2NTE2N10gZWhjaV9oY2QgMDAwMDowMDoxMi4yOiBFSENJIEhvc3QgQ29udHJvbGxlcgpbICAg
IDEuMDY1MTkyXSBlaGNpX2hjZCAwMDAwOjAwOjEyLjI6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQs
IGFzc2lnbmVkIGJ1cyBudW1iZXIgMQpbICAgIDEuMDcwMTIwXSBlaGNpX2hjZCAwMDAwOjAwOjEy
LjI6IGFwcGx5aW5nIEFNRCBTQjcwMC9TQjgwMC9IdWRzb24tMi8zIEVIQ0kgZHVtbXkgcWggd29y
a2Fyb3VuZApbICAgIDEuMDcwMTU1XSBRVUlSSzogRW5hYmxlIEFNRCBQTEwgZml4ClsgICAgMS4w
NzAxNjVdIGVoY2lfaGNkIDAwMDA6MDA6MTIuMjogZGVidWcgcG9ydCAxClsgICAgMS4wNzAxODhd
IGVoY2lfaGNkIDAwMDA6MDA6MTIuMjogaXJxIDE3LCBpbyBtZW0gMHhmZWY0ZjAwMApbICAgIDEu
MDkwMTA2XSBlaGNpX2hjZCAwMDAwOjAwOjEyLjI6IFVTQiAyLjAgc3RhcnRlZCwgRUhDSSAxLjAw
ClsgICAgMS4wOTAyNDJdIGh1YiAxLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgMS4wOTAyNDZd
IGh1YiAxLTA6MS4wOiA1IHBvcnRzIGRldGVjdGVkClsgICAgMS4wOTAzMTVdIGVoY2lfaGNkIDAw
MDA6MDA6MTMuMjogUENJIElOVCBCIC0+IEdTSSAxNyAobGV2ZWwsIGxvdykgLT4gSVJRIDE3Clsg
ICAgMS4wOTAzMzFdIGVoY2lfaGNkIDAwMDA6MDA6MTMuMjogRUhDSSBIb3N0IENvbnRyb2xsZXIK
WyAgICAxLjA5MDM2Nl0gZWhjaV9oY2QgMDAwMDowMDoxMy4yOiBuZXcgVVNCIGJ1cyByZWdpc3Rl
cmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDIKWyAgICAxLjA5MDM5OF0gZWhjaV9oY2QgMDAwMDow
MDoxMy4yOiBhcHBseWluZyBBTUQgU0I3MDAvU0I4MDAvSHVkc29uLTIvMyBFSENJIGR1bW15IHFo
IHdvcmthcm91bmQKWyAgICAxLjA5MDQyMV0gZWhjaV9oY2QgMDAwMDowMDoxMy4yOiBkZWJ1ZyBw
b3J0IDEKWyAgICAxLjA5MDQzNV0gZWhjaV9oY2QgMDAwMDowMDoxMy4yOiBpcnEgMTcsIGlvIG1l
bSAweGZlZjRkMDAwClsgICAgMS4xMTAxMDZdIGVoY2lfaGNkIDAwMDA6MDA6MTMuMjogVVNCIDIu
MCBzdGFydGVkLCBFSENJIDEuMDAKWyAgICAxLjExMDI1MV0gaHViIDItMDoxLjA6IFVTQiBodWIg
Zm91bmQKWyAgICAxLjExMDI1NV0gaHViIDItMDoxLjA6IDUgcG9ydHMgZGV0ZWN0ZWQKWyAgICAx
LjExMDMyNF0gb2hjaV9oY2Q6IFVTQiAxLjEgJ09wZW4nIEhvc3QgQ29udHJvbGxlciAoT0hDSSkg
RHJpdmVyClsgICAgMS4xMTAzNTBdIG9oY2lfaGNkIDAwMDA6MDA6MTIuMDogUENJIElOVCBBIC0+
IEdTSSAxOCAobGV2ZWwsIGxvdykgLT4gSVJRIDE4ClsgICAgMS4xMTAzNjddIG9oY2lfaGNkIDAw
MDA6MDA6MTIuMDogT0hDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAxLjExMDM5N10gb2hjaV9oY2Qg
MDAwMDowMDoxMi4wOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVy
IDMKWyAgICAxLjEyMDE0OV0gb2hjaV9oY2QgMDAwMDowMDoxMi4wOiBpcnEgMTgsIGlvIG1lbSAw
eGZlZjUwMDAwClsgICAgMS4xODQyNDldIGh1YiAzLTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAg
MS4xODQyNTddIGh1YiAzLTA6MS4wOiA1IHBvcnRzIGRldGVjdGVkClsgICAgMS4xODQzMjVdIG9o
Y2lfaGNkIDAwMDA6MDA6MTMuMDogUENJIElOVCBBIC0+IEdTSSAxOCAobGV2ZWwsIGxvdykgLT4g
SVJRIDE4ClsgICAgMS4xODQzNDFdIG9oY2lfaGNkIDAwMDA6MDA6MTMuMDogT0hDSSBIb3N0IENv
bnRyb2xsZXIKWyAgICAxLjE4NDM3MF0gb2hjaV9oY2QgMDAwMDowMDoxMy4wOiBuZXcgVVNCIGJ1
cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDQKWyAgICAxLjE4NDQxNF0gb2hjaV9o
Y2QgMDAwMDowMDoxMy4wOiBpcnEgMTgsIGlvIG1lbSAweGZlZjRlMDAwClsgICAgMS4yNDQyNjdd
IGh1YiA0LTA6MS4wOiBVU0IgaHViIGZvdW5kClsgICAgMS4yNDQyNzRdIGh1YiA0LTA6MS4wOiA1
IHBvcnRzIGRldGVjdGVkClsgICAgMS4yNDQzNDRdIG9oY2lfaGNkIDAwMDA6MDA6MTQuNTogUENJ
IElOVCBDIC0+IEdTSSAxOCAobGV2ZWwsIGxvdykgLT4gSVJRIDE4ClsgICAgMS4yNDQzNjBdIG9o
Y2lfaGNkIDAwMDA6MDA6MTQuNTogT0hDSSBIb3N0IENvbnRyb2xsZXIKWyAgICAxLjI0NDM5NV0g
b2hjaV9oY2QgMDAwMDowMDoxNC41OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBi
dXMgbnVtYmVyIDUKWyAgICAxLjI1MDE0M10gb2hjaV9oY2QgMDAwMDowMDoxNC41OiBpcnEgMTgs
IGlvIG1lbSAweGZlZjRjMDAwClsgICAgMS4zMTQyOTFdIGh1YiA1LTA6MS4wOiBVU0IgaHViIGZv
dW5kClsgICAgMS4zMTQzMDBdIGh1YiA1LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAgMS4z
MTQzODJdIHVoY2lfaGNkOiBVU0IgVW5pdmVyc2FsIEhvc3QgQ29udHJvbGxlciBJbnRlcmZhY2Ug
ZHJpdmVyClsgICAgMS4zMTQ0NzNdIGk4MDQyOiBQTlA6IE5vIFBTLzIgY29udHJvbGxlciBmb3Vu
ZC4gUHJvYmluZyBwb3J0cyBkaXJlY3RseS4KWyAgICAxLjMxNDgxNV0gc2VyaW86IGk4MDQyIEtC
RCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMQpbICAgIDEuMzE0ODIyXSBzZXJpbzogaTgwNDIgQVVY
IHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMgpbICAgIDEuMzE0OTI5XSBtb3VzZWRldjogUFMvMiBt
b3VzZSBkZXZpY2UgY29tbW9uIGZvciBhbGwgbWljZQpbICAgIDEuMzE1MDM1XSBydGNfY21vcyAw
MDowYTogUlRDIGNhbiB3YWtlIGZyb20gUzQKWyAgICAxLjMzMDIzMV0gcnRjX2Ntb3MgMDA6MGE6
IHJ0YyBjb3JlOiByZWdpc3RlcmVkIHJ0Y19jbW9zIGFzIHJ0YzAKWyAgICAxLjMzMDI1NV0gcnRj
MDogYWxhcm1zIHVwIHRvIG9uZSBtb250aCwgeTNrLCAxMTQgYnl0ZXMgbnZyYW0sIGhwZXQgaXJx
cwpbICAgIDEuMzMwMzYzXSBkZXZpY2UtbWFwcGVyOiB1ZXZlbnQ6IHZlcnNpb24gMS4wLjMKWyAg
ICAxLjMzMDQzMl0gZGV2aWNlLW1hcHBlcjogaW9jdGw6IDQuMjAuMC1pb2N0bCAoMjAxMS0wMi0w
MikgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQHJlZGhhdC5jb20KWyAgICAxLjMzMDQ5OV0gZGV2aWNl
LW1hcHBlcjogbXVsdGlwYXRoOiB2ZXJzaW9uIDEuMy4wIGxvYWRlZApbICAgIDEuMzMwNTAyXSBk
ZXZpY2UtbWFwcGVyOiBtdWx0aXBhdGggcm91bmQtcm9iaW46IHZlcnNpb24gMS4wLjAgbG9hZGVk
ClsgICAgMS4zMzA1OThdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcgpbICAgIDEuMzMw
NjUyXSBjcHVpZGxlOiB1c2luZyBnb3Zlcm5vciBtZW51ClsgICAgMS4zMzA2NTRdIEVGSSBWYXJp
YWJsZXMgRmFjaWxpdHkgdjAuMDggMjAwNC1NYXktMTcKWyAgICAxLjMzMDkyMV0gVENQIGN1Ymlj
IHJlZ2lzdGVyZWQKWyAgICAxLjMzMTAyMl0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWls
eSAxMApbICAgIDEuMzMxNTYyXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDE3Clsg
ICAgMS4zMzE1NzZdIFJlZ2lzdGVyaW5nIHRoZSBkbnNfcmVzb2x2ZXIga2V5IHR5cGUKWyAgICAx
LjMzMTU5NV0gcG93ZXJub3ctazg6IEZvdW5kIDEgQU1EIEExMC01NzAwIEFQVSB3aXRoIFJhZGVv
bih0bSkgSEQgR3JhcGhpY3MgICAgKDIgY3B1IGNvcmVzKSAodmVyc2lvbiAyLjIwLjAwKQpbICAg
IDEuMzMxNjA2XSBwb3dlcm5vdy1rODogQ29yZSBQZXJmb3JtYW5jZSBCb29zdGluZzogb24uClsg
ICAgMS4zMzE2NjldIHBvd2Vybm93LWs4OiAgICAwIDogcHN0YXRlIDAgKDM0MDAgTUh6KQpbICAg
IDEuMzMxNjcxXSBwb3dlcm5vdy1rODogICAgMSA6IHBzdGF0ZSAxICgzMDAwIE1IeikKWyAgICAx
LjMzMTY3Ml0gcG93ZXJub3ctazg6ICAgIDIgOiBwc3RhdGUgMiAoMjYwMCBNSHopClsgICAgMS4z
MzE2NzNdIHBvd2Vybm93LWs4OiAgICAzIDogcHN0YXRlIDMgKDIzMDAgTUh6KQpbICAgIDEuMzMx
Njc1XSBwb3dlcm5vdy1rODogICAgNCA6IHBzdGF0ZSA0ICgxOTAwIE1IeikKWyAgICAxLjMzMTY3
Nl0gcG93ZXJub3ctazg6ICAgIDUgOiBwc3RhdGUgNSAoMTQwMCBNSHopClsgICAgMS4zMzE4NjBd
IFBNOiBIaWJlcm5hdGlvbiBpbWFnZSBub3QgcHJlc2VudCBvciBjb3VsZCBub3QgYmUgbG9hZGVk
LgpbICAgIDEuMzMxODcwXSByZWdpc3RlcmVkIHRhc2tzdGF0cyB2ZXJzaW9uIDEKWyAgICAxLjMz
MjE4MF0gICBNYWdpYyBudW1iZXI6IDk6ODQxOjI3NApbICAgIDEuMzMyMTk5XSB0dHkgdHR5MTE6
IGhhc2ggbWF0Y2hlcwpbICAgIDEuMzMyMjM3XSBydGNfY21vcyAwMDowYTogc2V0dGluZyBzeXN0
ZW0gY2xvY2sgdG8gMjAxMy0wOC0xNCAxMDoxNjoxMCBVVEMgKDEzNzY0NzUzNzApClsgICAgMS4z
MzIyNDBdIEJJT1MgRUREIGZhY2lsaXR5IHYwLjE2IDIwMDQtSnVuLTI1LCAwIGRldmljZXMgZm91
bmQKWyAgICAxLjMzMjI0MV0gRUREIGluZm9ybWF0aW9uIG5vdCBhdmFpbGFibGUuClsgICAgMS4z
MzQ3NzhdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDEwNjhrIGZyZWVkClsgICAgMS4z
MzUwMDhdIFdyaXRlIHByb3RlY3RpbmcgdGhlIGtlcm5lbCByZWFkLW9ubHkgZGF0YTogMTAyNDBr
ClsgICAgMS4zMzU1NjldIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDEwNGsgZnJlZWQK
WyAgICAxLjM0MTE3MF0gRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogMTM2NGsgZnJlZWQK
WyAgICAxLjQ0MDI4Nl0gdWRldmQgKDE1NSk6IC9wcm9jLzE1NS9vb21fYWRqIGlzIGRlcHJlY2F0
ZWQsIHBsZWFzZSB1c2UgL3Byb2MvMTU1L29vbV9zY29yZV9hZGogaW5zdGVhZC4KWyAgICAxLjUw
ODk5Ml0gYWhjaSAwMDAwOjAwOjExLjA6IHZlcnNpb24gMy4wClsgICAgMS41MDkwMTVdIGFoY2kg
MDAwMDowMDoxMS4wOiBQQ0kgSU5UIEEgLT4gR1NJIDE5IChsZXZlbCwgbG93KSAtPiBJUlEgMTkK
WyAgICAxLjUwOTA4N10gYWhjaSAwMDAwOjAwOjExLjA6IEFIQ0kgMDAwMS4wMzAwIDMyIHNsb3Rz
IDEgcG9ydHMgNiBHYnBzIDB4MiBpbXBsIFNBVEEgbW9kZQpbICAgIDEuNTA5MDkyXSBhaGNpIDAw
MDA6MDA6MTEuMDogZmxhZ3M6IDY0Yml0IG5jcSBzbnRmIGlsY2sgcG0gbGVkIGNsbyBwbXAgcGlv
IHNsdW0gcGFydCAKWyAgICAxLjY2MTgyM10gc2NzaTAgOiBhaGNpClsgICAgMS42NjYxNjJdIHI4
MTY5IEdpZ2FiaXQgRXRoZXJuZXQgZHJpdmVyIDIuM0xLLU5BUEkgbG9hZGVkClsgICAgMS42NjYx
ODldIHI4MTY5IDAwMDA6MDM6MDAuMDogUENJIElOVCBBIC0+IEdTSSAxNyAobGV2ZWwsIGxvdykg
LT4gSVJRIDE3ClsgICAgMS42NjYyMzddIHI4MTY5IDAwMDA6MDM6MDAuMDogc2V0dGluZyBsYXRl
bmN5IHRpbWVyIHRvIDY0ClsgICAgMS42NjYyNDZdIHI4MTY5IDAwMDA6MDM6MDAuMDogKHVucmVn
aXN0ZXJlZCBuZXRfZGV2aWNlKTogdW5rbm93biBNQUMsIHVzaW5nIGZhbWlseSBkZWZhdWx0Clsg
ICAgMS42NjYzMjFdIHI4MTY5IDAwMDA6MDM6MDAuMDogaXJxIDQzIGZvciBNU0kvTVNJLVgKWyAg
ICAxLjY2NjQzMF0gcjgxNjkgMDAwMDowMzowMC4wOiBldGgwOiBGZWF0dXJlcyBjaGFuZ2VkOiAw
eDAwMDA0OTgwIC0+IDB4MDAwMDQxODAKWyAgICAxLjY2NzAyOF0gcjgxNjkgMDAwMDowMzowMC4w
OiBldGgwOiBSVEw4MTY4Yi84MTExYiBhdCAweGZmZmZjOTAwMDAzMjAwMDAsIDc0OjI3OmVhOjQ1
Ojk0OjYyLCBYSUQgMGM5MDA4MDAgSVJRIDQzClsgICAgMS42NjcxMzFdIHNjc2kxIDogYWhjaQpb
ICAgIDEuNjY3MzM5XSBhdGExOiBEVU1NWQpbICAgIDEuNjY3MzQyXSBhdGEyOiBTQVRBIG1heCBV
RE1BLzEzMyBhYmFyIG0yMDQ4QDB4ZmVmNTEwMDAgcG9ydCAweGZlZjUxMTgwIGlycSAxOQpbICAg
IDEuNjY3NDI1XSBwYXRhX2F0aWl4cCAwMDAwOjAwOjE0LjE6IFBDSSBJTlQgQiAtPiBHU0kgMTcg
KGxldmVsLCBsb3cpIC0+IElSUSAxNwpbICAgIDEuNjcyMDIwXSBzY3NpMiA6IHBhdGFfYXRpaXhw
ClsgICAgMS42ODAwNTNdIHNjc2kzIDogcGF0YV9hdGlpeHAKWyAgICAxLjY4MDkxOF0gYXRhMzog
UEFUQSBtYXggVURNQS8xMDAgY21kIDB4MWYwIGN0bCAweDNmNiBibWRtYSAweGYxMDAgaXJxIDE0
ClsgICAgMS42ODA5MjNdIGF0YTQ6IFBBVEEgbWF4IFVETUEvMTAwIGNtZCAweDE3MCBjdGwgMHgz
NzYgYm1kbWEgMHhmMTA4IGlycSAxNQpbICAgIDEuNzQwMDcwXSB1c2IgNC0xOiBuZXcgZnVsbCBz
cGVlZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIG9oY2lfaGNkClsgICAgMS44NTAwMjNdIFJl
ZmluZWQgVFNDIGNsb2Nrc291cmNlIGNhbGlicmF0aW9uOiAzNDAwLjI1NCBNSHouClsgICAgMS44
NTAwMjldIFN3aXRjaGluZyB0byBjbG9ja3NvdXJjZSB0c2MKWyAgICAyLjA0MDE5NV0gaW5wdXQ6
IExvZ2l0ZWNoIFVTQiBSZWNlaXZlciBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MTMu
MC91c2I0LzQtMS80LTE6MS4wL2lucHV0L2lucHV0MgpbICAgIDIuMDQwMzcxXSBnZW5lcmljLXVz
YiAwMDAzOjA0NkQ6QzUyRS4wMDAxOiBpbnB1dCxoaWRyYXcwOiBVU0IgSElEIHYxLjExIEtleWJv
YXJkIFtMb2dpdGVjaCBVU0IgUmVjZWl2ZXJdIG9uIHVzYi0wMDAwOjAwOjEzLjAtMS9pbnB1dDAK
WyAgICAyLjA0NDUwMF0gaW5wdXQ6IExvZ2l0ZWNoIFVTQiBSZWNlaXZlciBhcyAvZGV2aWNlcy9w
Y2kwMDAwOjAwLzAwMDA6MDA6MTMuMC91c2I0LzQtMS80LTE6MS4xL2lucHV0L2lucHV0MwpbICAg
IDIuMDQ0OTI2XSBnZW5lcmljLXVzYiAwMDAzOjA0NkQ6QzUyRS4wMDAyOiBpbnB1dCxoaWRkZXYw
LGhpZHJhdzE6IFVTQiBISUQgdjEuMTEgTW91c2UgW0xvZ2l0ZWNoIFVTQiBSZWNlaXZlcl0gb24g
dXNiLTAwMDA6MDA6MTMuMC0xL2lucHV0MQpbICAgIDIuMDQ1MDQ1XSB1c2Jjb3JlOiByZWdpc3Rl
cmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmhpZApbICAgIDIuMDQ1MDQ4XSB1c2JoaWQ6IFVT
QiBISUQgY29yZSBkcml2ZXIKWyAgICAyLjIyMDExM10gYXRhMjogU0FUQSBsaW5rIHVwIDMuMCBH
YnBzIChTU3RhdHVzIDEyMyBTQ29udHJvbCAzMDApClsgICAgMi4yMjExMjVdIGF0YTIuMDA6IEFU
QS04OiBXREMgV0QyNTAwQUFKUy03NUI0QTAsIDAxLjAzQTAxLCBtYXggVURNQS8xMzMKWyAgICAy
LjIyMTEyOF0gYXRhMi4wMDogNDg4MjgxMjUwIHNlY3RvcnMsIG11bHRpIDE2OiBMQkE0OCBOQ1Eg
KGRlcHRoIDMxLzMyKSwgQUEKWyAgICAyLjIyMjE1M10gYXRhMi4wMDogY29uZmlndXJlZCBmb3Ig
VURNQS8xMzMKWyAgICAyLjIyMjI1OV0gc2NzaSAxOjA6MDowOiBEaXJlY3QtQWNjZXNzICAgICBB
VEEgICAgICBXREMgV0QyNTAwQUFKUy03IDAxLjAgUFE6IDAgQU5TSTogNQpbICAgIDIuMjIyNDE0
XSBzZCAxOjA6MDowOiBBdHRhY2hlZCBzY3NpIGdlbmVyaWMgc2cwIHR5cGUgMApbICAgIDIuMjIy
NTA1XSBzZCAxOjA6MDowOiBbc2RhXSA0ODgyODEyNTAgNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6
ICgyNTAgR0IvMjMyIEdpQikKWyAgICAyLjIyMjU1NF0gc2QgMTowOjA6MDogW3NkYV0gV3JpdGUg
UHJvdGVjdCBpcyBvZmYKWyAgICAyLjIyMjU1N10gc2QgMTowOjA6MDogW3NkYV0gTW9kZSBTZW5z
ZTogMDAgM2EgMDAgMDAKWyAgICAyLjIyMjU5MF0gc2QgMTowOjA6MDogW3NkYV0gV3JpdGUgY2Fj
aGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3Ig
RlVBClsgICAgMi4yMjI3NThdIHNkYTogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0
byAyNTAwMDAwMDAwMDAKWyAgICAyLjI1NzkzMF0gIHNkYTogc2RhMSBzZGEyIDwgc2RhNSA+Clsg
ICAgMi4yNTgyMDVdIHNkIDE6MDowOjA6IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDIu
NDI2MTIzXSBQTTogU3RhcnRpbmcgbWFudWFsIHJlc3VtZSBmcm9tIGRpc2sKWyAgICAyLjQyNjEy
Nl0gUE06IEhpYmVybmF0aW9uIGltYWdlIHBhcnRpdGlvbiA4OjUgcHJlc2VudApbICAgIDIuNDI2
MTI3XSBQTTogTG9va2luZyBmb3IgaGliZXJuYXRpb24gaW1hZ2UuClsgICAgMi40MjYyNTldIFBN
OiBJbWFnZSBub3QgZm91bmQgKGNvZGUgLTIyKQpbICAgIDIuNDI2MjYxXSBQTTogSGliZXJuYXRp
b24gaW1hZ2Ugbm90IHByZXNlbnQgb3IgY291bGQgbm90IGJlIGxvYWRlZC4KWyAgICAyLjQ1NjQz
Nl0gRVhUMy1mczogYmFycmllcnMgbm90IGVuYWJsZWQKWyAgICAyLjQ3NzgwM10ga2pvdXJuYWxk
IHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcwpbICAgIDIuNDc3ODg5XSBFWFQz
LWZzIChzZGExKTogbW91bnRlZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUKWyAg
ICA3LjA1MTYzM10gdWRldjogc3RhcnRpbmcgdmVyc2lvbiAxNDEKWyAgICA3LjE1MDkwOV0gdWRl
djogcmVuYW1lZCBuZXR3b3JrIGludGVyZmFjZSBldGgwIHRvIGV0aDE2ClsgICAgNy4xNTYxNzdd
IHhoY2lfaGNkIDAwMDA6MDA6MTAuMDogUENJIElOVCBBIC0+IEdTSSAxOCAobGV2ZWwsIGxvdykg
LT4gSVJRIDE4ClsgICAgNy4xNTYxOTldIHhoY2lfaGNkIDAwMDA6MDA6MTAuMDogc2V0dGluZyBs
YXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgNy4xNTYyMDNdIHhoY2lfaGNkIDAwMDA6MDA6MTAuMDog
eEhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICA3LjE1NjMxNV0geGhjaV9oY2QgMDAwMDowMDoxMC4w
OiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDYKWyAgICA3LjE4
MDM5Nl0geGhjaV9oY2QgMDAwMDowMDoxMC4wOiBpcnEgMTgsIGlvIG1lbSAweGZlZjRhMDAwClsg
ICAgNy4xODA0NjBdIHhoY2lfaGNkIDAwMDA6MDA6MTAuMDogaXJxIDQ0IGZvciBNU0kvTVNJLVgK
WyAgICA3LjE4MDQ2NV0geGhjaV9oY2QgMDAwMDowMDoxMC4wOiBpcnEgNDUgZm9yIE1TSS9NU0kt
WApbICAgIDcuMTgwNDcwXSB4aGNpX2hjZCAwMDAwOjAwOjEwLjA6IGlycSA0NiBmb3IgTVNJL01T
SS1YClsgICAgNy4xODA2NTJdIHhIQ0kgeGhjaV9hZGRfZW5kcG9pbnQgY2FsbGVkIGZvciByb290
IGh1YgpbICAgIDcuMTgwNjU0XSB4SENJIHhoY2lfY2hlY2tfYmFuZHdpZHRoIGNhbGxlZCBmb3Ig
cm9vdCBodWIKWyAgICA3LjE4MDY4MV0gaHViIDYtMDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICA3
LjE4MDY4OV0gaHViIDYtMDoxLjA6IDIgcG9ydHMgZGV0ZWN0ZWQKWyAgICA3LjE4MDc1Ml0geGhj
aV9oY2QgMDAwMDowMDoxMC4wOiB4SENJIEhvc3QgQ29udHJvbGxlcgpbICAgIDcuMTgwNzk5XSB4
aGNpX2hjZCAwMDAwOjAwOjEwLjA6IG5ldyBVU0IgYnVzIHJlZ2lzdGVyZWQsIGFzc2lnbmVkIGJ1
cyBudW1iZXIgNwpbICAgIDcuMjIwMjY2XSB4SENJIHhoY2lfYWRkX2VuZHBvaW50IGNhbGxlZCBm
b3Igcm9vdCBodWIKWyAgICA3LjIyMDI2OV0geEhDSSB4aGNpX2NoZWNrX2JhbmR3aWR0aCBjYWxs
ZWQgZm9yIHJvb3QgaHViClsgICAgNy4yMjAzMDldIGh1YiA3LTA6MS4wOiBVU0IgaHViIGZvdW5k
ClsgICAgNy4yMjAzMTddIGh1YiA3LTA6MS4wOiAyIHBvcnRzIGRldGVjdGVkClsgICAgNy4yMjAz
OTVdIHhoY2lfaGNkIDAwMDA6MDA6MTAuMTogUENJIElOVCBCIC0+IEdTSSAxNyAobGV2ZWwsIGxv
dykgLT4gSVJRIDE3ClsgICAgNy4yMjA0MTddIHhoY2lfaGNkIDAwMDA6MDA6MTAuMTogc2V0dGlu
ZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgNy4yMjA0MjFdIHhoY2lfaGNkIDAwMDA6MDA6MTAu
MTogeEhDSSBIb3N0IENvbnRyb2xsZXIKWyAgICA3LjIyMDQ2MV0geGhjaV9oY2QgMDAwMDowMDox
MC4xOiBuZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDgKWyAgICA3
LjIyNzU1Ml0gaW5wdXQ6IFBDIFNwZWFrZXIgYXMgL2RldmljZXMvcGxhdGZvcm0vcGNzcGtyL2lu
cHV0L2lucHV0NApbICAgIDcuMjQwNTIzXSB4aGNpX2hjZCAwMDAwOjAwOjEwLjE6IGlycSAxNywg
aW8gbWVtIDB4ZmVmNDgwMDAKWyAgICA3LjI0MDU4N10geGhjaV9oY2QgMDAwMDowMDoxMC4xOiBp
cnEgNDcgZm9yIE1TSS9NU0ktWApbICAgIDcuMjQwNTkzXSB4aGNpX2hjZCAwMDAwOjAwOjEwLjE6
IGlycSA0OCBmb3IgTVNJL01TSS1YClsgICAgNy4yNDA1OTddIHhoY2lfaGNkIDAwMDA6MDA6MTAu
MTogaXJxIDQ5IGZvciBNU0kvTVNJLVgKWyAgICA3LjI0MDc5OF0geEhDSSB4aGNpX2FkZF9lbmRw
b2ludCBjYWxsZWQgZm9yIHJvb3QgaHViClsgICAgNy4yNDA4MDBdIHhIQ0kgeGhjaV9jaGVja19i
YW5kd2lkdGggY2FsbGVkIGZvciByb290IGh1YgpbICAgIDcuMjQwODI3XSBodWIgOC0wOjEuMDog
VVNCIGh1YiBmb3VuZApbICAgIDcuMjQwODM1XSBodWIgOC0wOjEuMDogMiBwb3J0cyBkZXRlY3Rl
ZApbICAgIDcuMjQwOTA1XSB4aGNpX2hjZCAwMDAwOjAwOjEwLjE6IHhIQ0kgSG9zdCBDb250cm9s
bGVyClsgICAgNy4yNDA5NDVdIHhoY2lfaGNkIDAwMDA6MDA6MTAuMTogbmV3IFVTQiBidXMgcmVn
aXN0ZXJlZCwgYXNzaWduZWQgYnVzIG51bWJlciA5ClsgICAgNy4yODA0NTJdIHhIQ0kgeGhjaV9h
ZGRfZW5kcG9pbnQgY2FsbGVkIGZvciByb290IGh1YgpbICAgIDcuMjgwNDU1XSB4SENJIHhoY2lf
Y2hlY2tfYmFuZHdpZHRoIGNhbGxlZCBmb3Igcm9vdCBodWIKWyAgICA3LjI4MDQ4M10gaHViIDkt
MDoxLjA6IFVTQiBodWIgZm91bmQKWyAgICA3LjI4MDQ5MV0gaHViIDktMDoxLjA6IDIgcG9ydHMg
ZGV0ZWN0ZWQKWyAgICA3LjI4MDcxOF0gcGlpeDRfc21idXMgMDAwMDowMDoxNC4wOiBTTUJ1cyBI
b3N0IENvbnRyb2xsZXIgYXQgMHhiMDAsIHJldmlzaW9uIDAKWyAgICA3LjMwODM1MV0gcGFycG9y
dF9wYyAwMDowNzogcmVwb3J0ZWQgYnkgUGx1ZyBhbmQgUGxheSBBQ1BJClsgICAgNy4zMDgzOTdd
IHBhcnBvcnQwOiBQQy1zdHlsZSBhdCAweDM3OCwgaXJxIDUgW1BDU1BQXQpbICAgIDcuNDIyNTQ5
XSBwcGRldjogdXNlci1zcGFjZSBwYXJhbGxlbCBwb3J0IGRyaXZlcgpbICAgIDcuNjg5MzczXSBI
REEgSW50ZWwgMDAwMDowMDowMS4xOiBQQ0kgSU5UIEIgLT4gR1NJIDE4IChsZXZlbCwgbG93KSAt
PiBJUlEgMTgKWyAgICA3LjY4OTQyNl0gSERBIEludGVsIDAwMDA6MDA6MDEuMTogaXJxIDUwIGZv
ciBNU0kvTVNJLVgKWyAgICA3LjY4OTQ0OF0gSERBIEludGVsIDAwMDA6MDA6MDEuMTogc2V0dGlu
ZyBsYXRlbmN5IHRpbWVyIHRvIDY0ClsgICAgOC4yNDU5MDBdIEhETUk6IG5vIHNwYWNlIGZvciBj
b252ZXJ0ZXIgOApbICAgIDguMjQ1OTQ2XSBIRE1JOiBubyBzcGFjZSBmb3IgY29udmVydGVyIDEw
ClsgICAgOC4yNDU5OTNdIEhETUk6IG5vIHNwYWNlIGZvciBjb252ZXJ0ZXIgMTIKWyAgICA4LjI0
NjQ4Ml0gSERBIEludGVsIDAwMDA6MDA6MTQuMjogUENJIElOVCBBIC0+IEdTSSAxNiAobGV2ZWws
IGxvdykgLT4gSVJRIDE2ClsgICAgOC41MTE1NDZdIGxwMDogdXNpbmcgcGFycG9ydDAgKGludGVy
cnVwdC1kcml2ZW4pLgpbICAgIDguNzQxMTg1XSBBZGRpbmcgNTk1MjA0NGsgc3dhcCBvbiAvZGV2
L3NkYTUuICBQcmlvcml0eTotMSBleHRlbnRzOjEgYWNyb3NzOjU5NTIwNDRrIApbICAgMTIuNzE4
ODM0XSBFWFQzLWZzIChzZGExKTogd2FybmluZzogbWF4aW1hbCBtb3VudCBjb3VudCByZWFjaGVk
LCBydW5uaW5nIGUyZnNjayBpcyByZWNvbW1lbmRlZApbICAgMTIuNzE5MDYxXSBFWFQzLWZzIChz
ZGExKTogdXNpbmcgaW50ZXJuYWwgam91cm5hbApbICAgMTQuMDYxNzg4XSBpcG1pIG1lc3NhZ2Ug
aGFuZGxlciB2ZXJzaW9uIDM5LjIKWyAgIDE0LjA4OTgxNV0gRUlOSjogVGFibGUgaXMgbm90IGZv
dW5kIQpbICAgMTQuMTE5MDY0XSBHSEVTOiBIRVNUIGlzIG5vdCBlbmFibGVkIQpbICAgMTUuODYz
NTI5XSBCbHVldG9vdGg6IENvcmUgdmVyIDIuMTYKWyAgIDE1Ljg2MzU1M10gTkVUOiBSZWdpc3Rl
cmVkIHByb3RvY29sIGZhbWlseSAzMQpbICAgMTUuODYzNTU1XSBCbHVldG9vdGg6IEhDSSBkZXZp
Y2UgYW5kIGNvbm5lY3Rpb24gbWFuYWdlciBpbml0aWFsaXplZApbICAgMTUuODYzNTU5XSBCbHVl
dG9vdGg6IEhDSSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDE1Ljg2MzU2MF0gQmx1ZXRv
b3RoOiBMMkNBUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQKWyAgIDE1Ljg2NDMxOV0gQmx1ZXRv
b3RoOiBTQ08gc29ja2V0IGxheWVyIGluaXRpYWxpemVkClsgICAxNS44Njg5NTVdIEJsdWV0b290
aDogQk5FUCAoRXRoZXJuZXQgRW11bGF0aW9uKSB2ZXIgMS4zClsgICAxNS44Njg5NTldIEJsdWV0
b290aDogQk5FUCBmaWx0ZXJzOiBwcm90b2NvbCBtdWx0aWNhc3QKWyAgIDE1Ljg3ODMyOV0gQnJp
ZGdlIGZpcmV3YWxsaW5nIHJlZ2lzdGVyZWQKWyAgIDE2LjI0MzM5M10gQmx1ZXRvb3RoOiBSRkNP
TU0gVFRZIGxheWVyIGluaXRpYWxpemVkClsgICAxNi4yNDM0MDZdIEJsdWV0b290aDogUkZDT01N
IHNvY2tldCBsYXllciBpbml0aWFsaXplZApbICAgMTYuMjQzNDExXSBCbHVldG9vdGg6IFJGQ09N
TSB2ZXIgMS4xMQpbICAgMjIuMDIwNTk5XSByODE2OSAwMDAwOjAzOjAwLjA6IGV0aDE2OiBsaW5r
IGRvd24KWyAgIDIyLjAyMTEyNF0gQUREUkNPTkYoTkVUREVWX1VQKTogZXRoMTY6IGxpbmsgaXMg
bm90IHJlYWR5ClsgIDE3Ny42ODg1NDldIGhkYS1pbnRlbDogSW52YWxpZCBwb3NpdGlvbiBidWZm
ZXIsIHVzaW5nIExQSUIgcmVhZCBtZXRob2QgaW5zdGVhZC4KWyAgMTc3LjcyMTc4Ml0gaGRhLWlu
dGVsOiBJbnZhbGlkIHBvc2l0aW9uIGJ1ZmZlciwgdXNpbmcgTFBJQiByZWFkIG1ldGhvZCBpbnN0
ZWFkLgpbICAyNDYuMDYxNTc5XSBmNzE4ODJmZzogRm91bmQgZjcxODY5IGNoaXAgYXQgMHhlODAs
IHJldmlzaW9uIDE3ClsgIDI0Ni4wNjE4MzhdIGY3MTg4MmZnIGY3MTg4MmZnLjM3MTI6IEF1dG8g
cHdtIGNvbnRyb2xsZWQgYnkgcmF3IGRpZ2l0YWwgZGF0YSwgZGlzYWJsaW5nIHB3bSBhdXRvX3Bv
aW50IHN5c2ZzIGF0dHJpYnV0ZXMKWyAgMjQ2LjA2MTg0OV0gZjcxODgyZmcgZjcxODgyZmcuMzcx
MjogRmFuOiAxIGlzIGluIGR1dHktY3ljbGUgbW9kZQpbICAyNDYuMDYxODU2XSBmNzE4ODJmZyBm
NzE4ODJmZy4zNzEyOiBGYW46IDIgaXMgaW4gZHV0eS1jeWNsZSBtb2RlClsgIDI0Ni4wNjE4NjNd
IGY3MTg4MmZnIGY3MTg4MmZnLjM3MTI6IEZhbjogMyBpcyBpbiBkdXR5LWN5Y2xlIG1vZGUKWyA0
ODg5LjI0NTMxMl0gTm8gbW9kdWxlIGZvdW5kIGluIG9iamVjdApbIDQ5MDEuMDA3OTU1XSBObyBt
b2R1bGUgZm91bmQgaW4gb2JqZWN0Cg==
--089e016354b671c6e704e3ed0e7e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--089e016354b671c6e704e3ed0e7e--
