From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Wed, 22 Oct 2008 12:11:12 +0000
Subject: Re: [lm-sensors] [PATCH] Allow it87.c to handle IT8720
Message-Id: <79c9d4530810220511i225dde61o47388d6a38232794@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6879690066868660813=="
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
In-Reply-To: <79c9d4530810061031v77c2b2afo983cdef4ca6bc71e@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6879690066868660813==
Content-Type: multipart/alternative; 
	boundary="----=_Part_14584_25686408.1224677472093"

------=_Part_14584_25686408.1224677472093
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jean,

I will do it this afternoon (EST).

JM

2008/10/22 Jean Delvare <khali@linux-fr.org>

> Hi Jean-Marc,
>
> On Tue, 7 Oct 2008 22:36:23 +0200, Jean Delvare wrote:
> > Hi Jean-Marc,
> >
> > On Mon, 6 Oct 2008 13:33:56 -0400, Jean-Marc Spaggiari wrote:
> > > The goal of this patch is to allow it87.c to handle IT8720 chipset
> > > like IT8718 in order to retreive voltage, temperatures and fans speed
> > > from sensors tools.
> > >
> > > JMS
> > >
> > > Patch also attached.
> > >
> > > --- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig  2008-10-02
> 09:04:44.000000000 -0400
> > > +++ linux-2.6.27-rc8/drivers/hwmon/it87.c       2008-10-06
> 13:27:08.000000000 -0400
> > > @@ -14,6 +14,7 @@
>
> <snip, me reviewing the patch>
>
> > Other than that - and the lack of Signed-off-by line - your patch looks
> > OK to me.
>
> Any chance to have an updated patch from you by the end of the day, so
> that it makes it into kernel 2.6.28? The merge window is closing really
> soon now.
>
> --
> Jean Delvare
>

------=_Part_14584_25686408.1224677472093
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jean,<br><br>I will do it this afternoon (EST).<br><br>JM<br><br><div class="gmail_quote">2008/10/22 Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Jean-Marc,<br>
<div class="Ih2E3d"><br>
On Tue, 7 Oct 2008 22:36:23 +0200, Jean Delvare wrote:<br>
&gt; Hi Jean-Marc,<br>
&gt;<br>
&gt; On Mon, 6 Oct 2008 13:33:56 -0400, Jean-Marc Spaggiari wrote:<br>
&gt; &gt; The goal of this patch is to allow it87.c to handle IT8720 chipset<br>
&gt; &gt; like IT8718 in order to retreive voltage, temperatures and fans speed<br>
&gt; &gt; from sensors tools.<br>
&gt; &gt;<br>
&gt; &gt; JMS<br>
&gt; &gt;<br>
&gt; &gt; Patch also attached.<br>
&gt; &gt;<br>
&gt; &gt; --- linux-2.6.27-rc8/drivers/hwmon/it87.c.orig &nbsp;2008-10-02 09:04:44.000000000 -0400<br>
&gt; &gt; +++ linux-2.6.27-rc8/drivers/hwmon/it87.c &nbsp; &nbsp; &nbsp; 2008-10-06 13:27:08.000000000 -0400<br>
&gt; &gt; @@ -14,6 +14,7 @@<br>
<br>
</div>&lt;snip, me reviewing the patch&gt;<br>
<div class="Ih2E3d"><br>
&gt; Other than that - and the lack of Signed-off-by line - your patch looks<br>
&gt; OK to me.<br>
<br>
</div>Any chance to have an updated patch from you by the end of the day, so<br>
that it makes it into kernel 2.6.28? The merge window is closing really<br>
soon now.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br>

------=_Part_14584_25686408.1224677472093--


--===============6879690066868660813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6879690066868660813==--
