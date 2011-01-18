From: Nick Hall <darknovanick@gmail.com>
Date: Tue, 18 Jan 2011 16:03:23 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <AANLkTinKj=FhUPhVSd5q=-658nUBAVVTjB+4wCjOZazn@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1301711358694738982=="
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
To: lm-sensors@vger.kernel.org

--===============1301711358694738982==
Content-Type: multipart/alternative; boundary=001485f894786dda30049a210a48

--001485f894786dda30049a210a48
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 18, 2011 at 2:46 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Mon, 17 Jan 2011 13:54:30 -0800, Guenter Roeck wrote:
> > On Mon, 2011-01-17 at 15:26 -0500, DarkNovaNick@gmail.com wrote:
> > > # sensors-detect revision 5901 (2011-01-14 17:11:54 +0100)
> > > # System: Gigabyte Technology Co., Ltd. H67A-UD3H
> > > (...)
> > > Some Super I/O chips contain embedded sensors. We have to write to
> > > standard I/O ports to probe them. This is usually safe.
> > > Do you want to scan for Super I/O sensors? (YES/no):
> > > Probing for Super-I/O at 0x2e/0x2f
> > > Trying family `National Semiconductor'... No
> > > Trying family `SMSC'... No
> > > Trying family `VIA/Winbond/Nuvoton/Fintek'... No
> > > Trying family `ITE'... Yes
> > > Found unknown chip with ID 0x8728
> > > (logical device 4 has address 0x290, could be sensors)
> >
> > The problem is more likely that the SuperIO chip used in your system is
> > not supported. If so, your problem doesn't have anything to do with
> > SandyBridge.
>
> This would be an ITE8728F, ITE's latest Super-I/O chip. Nick, can you
> confirm this by visual inspection? The chip should look like this:
> http://img713.imageshack.us/img713/3831/it8728fsmall.jpg
>
> --
> Jean Delvare
>

Thanks, I checked and my motherboard did indeed have that chip. The only
difference, if it matters, is that under the "IT8728F" mine had "1039-CXS"
and "ZC46FBGB".

And regarding the sensors-detect script, I understand now. If anyone is
interested, my Sandy Bridge processor would be model "0x2A" according to how
that script does things.

Nick

--001485f894786dda30049a210a48
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Jan 18, 2011 at 2:46 AM, Jean Delvare <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Mon, 17 Jan 2011 13:54:30 -0800, Guenter Roeck wrote:<=
br>
&gt; On Mon, 2011-01-17 at 15:26 -0500, <a href=3D"mailto:DarkNovaNick@gmai=
l.com">DarkNovaNick@gmail.com</a> wrote:<br>
</div><div class=3D"im">&gt; &gt; # sensors-detect revision 5901 (2011-01-1=
4 17:11:54 +0100)<br>
&gt; &gt; # System: Gigabyte Technology Co., Ltd. H67A-UD3H<br>
</div>&gt; &gt; (...)<br>
<div class=3D"im">&gt; &gt; Some Super I/O chips contain embedded sensors. =
We have to write to<br>
&gt; &gt; standard I/O ports to probe them. This is usually safe.<br>
&gt; &gt; Do you want to scan for Super I/O sensors? (YES/no):<br>
&gt; &gt; Probing for Super-I/O at 0x2e/0x2f<br>
&gt; &gt; Trying family `National Semiconductor&#39;... No<br>
&gt; &gt; Trying family `SMSC&#39;... No<br>
&gt; &gt; Trying family `VIA/Winbond/Nuvoton/Fintek&#39;... No<br>
&gt; &gt; Trying family `ITE&#39;... Yes<br>
&gt; &gt; Found unknown chip with ID 0x8728<br>
&gt; &gt; (logical device 4 has address 0x290, could be sensors)<br>
&gt;<br>
&gt; The problem is more likely that the SuperIO chip used in your system i=
s<br>
&gt; not supported. If so, your problem doesn&#39;t have anything to do wit=
h<br>
&gt; SandyBridge.<br>
<br>
</div>This would be an ITE8728F, ITE&#39;s latest Super-I/O chip. Nick, can=
 you<br>
confirm this by visual inspection? The chip should look like this:<br>
<a href=3D"http://img713.imageshack.us/img713/3831/it8728fsmall.jpg" target=
=3D"_blank">http://img713.imageshack.us/img713/3831/it8728fsmall.jpg</a><br=
>
<br>
--<br>
<font color=3D"#888888">Jean Delvare<br>
</font></blockquote></div><br><div>Thanks, I checked and my motherboard did=
 indeed have that chip. The only difference, if it matters, is that under t=
he &quot;IT8728F&quot; mine had &quot;1039-CXS&quot; and &quot;ZC46FBGB&quo=
t;.</div>
<div><br></div><div>And regarding the sensors-detect script, I understand n=
ow. If anyone is interested, my Sandy Bridge processor would be model &quot=
;0x2A&quot; according to how that script does things.</div><div><br></div>
<div>Nick</div>

--001485f894786dda30049a210a48--


--===============1301711358694738982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1301711358694738982==--
