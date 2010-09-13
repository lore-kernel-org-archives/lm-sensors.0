From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Mon, 13 Sep 2010 08:04:40 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <905855.37829.qm@web50003.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6926518750624538391=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============6926518750624538391==
Content-Type: multipart/alternative; boundary="0-1584305018-1284365080=:37829"

--0-1584305018-1284365080=:37829
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

What is the conclusion then? I read this thread=A0but=A0didn't end up with =
a clear =0Asolution. Is it related to the distro or lm-sensors?=0A=0AI need=
 to=A0see core temps in my kubuntu/ubuntu 10.04 with 2.6.32-24-generic =0Ak=
ernel. Some one please answer=A0step byt step from scratch.=0A=0AThanks,=A0=
=0A// Naderan *Mahmood;=0A=0A=0A=0A=0A________________________________=0AFr=
om: Jean Delvare <khali@linux-fr.org>=0ATo: Guenter Roeck <guenter.roeck@er=
icsson.com>=0ACc: Mahmood Naderan <nt_mahmood@yahoo.com>; lm-sensors =0A<lm=
-sensors@lm-sensors.org>=0ASent: Tue, September 7, 2010 12:30:03 PM=0ASubje=
ct: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors=0A=0AOn Mon, =
6 Sep 2010 18:32:56 -0700, Guenter Roeck wrote:=0A> On Mon, Sep 06, 2010 at=
 12:18:58PM -0400, Jean Delvare wrote:=0A> > On Sat, 4 Sep 2010 10:28:32 -0=
700, Guenter Roeck wrote:=0A> > > Maybe the best approach is to not (try to=
) install it at all, but just =0A>provide=0A> > > it as hint.=0A> > =0A> > =
Isn't it exactly what we're doing today?=0A> > =0A> Yes, sorry, I meant rew=
ording the text.=0A=0AOh, OK. Feel free to update sensors-detect with a bet=
ter text, no=0Aproblem.=0A=0A> > > (...)=0A> > > The shared library locatio=
ns are yet another problem. Not sure how to =0A>address=0A> > > that either=
.=0A> > =0A> > I have no idea what you're talking about, sorry.=0A>=0A> I m=
eant that Ubuntu doesnm't use /usr/local/lib. Maybe that isn't really a =0A=
>problem, though.=0A=0AShould be easy enough to check whether /usr/local/li=
b is=0Ain /etc/ld.so.conf, and warn the user if it isn't. Again, feel tree =
to=0Ado that if you think it's helpful.=0A=0A-- =0AJean Delvare=0A=0A=0A=0A=
      
--0-1584305018-1284365080=:37829
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt"><DIV></DIV>=0A<DIV>What is the conclusion then? I read this thread&n=
bsp;but&nbsp;didn't end up with a clear solution. Is it related to the dist=
ro or lm-sensors?</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I need to&nbsp;see core =
temps in my kubuntu/ubuntu 10.04 with 2.6.32-24-generic kernel. Some one pl=
ease answer&nbsp;step byt step from scratch.</DIV>=0A<DIV>&nbsp;</DIV>=0A<D=
IV>Thanks,&nbsp;</DIV>=0A<DIV>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #fff=
fff" color=3D#0080ff size=3D2 face=3D"arial, helvetica, sans-serif"><STRONG=
>// Naderan *Mahmood;</STRONG></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV =
style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12pt"><BR>=
=0A<DIV style=3D"FONT-FAMILY: tahoma, new york, times, serif; FONT-SIZE: 12=
pt"><FONT size=3D2 face=3DTahoma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-=
WEIGHT: bold">From:</SPAN></B> Jean Delvare &lt;khali@linux-fr.org&gt;<BR><=
B><SPAN style=3D"FONT-WEIGHT: bold">To:</SPAN></B> Guenter Roeck &lt;guente=
r.roeck@ericsson.com&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Cc:</SPAN>=
</B> Mahmood Naderan &lt;nt_mahmood@yahoo.com&gt;; lm-sensors &lt;lm-sensor=
s@lm-sensors.org&gt;<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></=
B> Tue, September 7, 2010 12:30:03 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bol=
d">Subject:</SPAN></B> Re: [lm-sensors] lmsensors doesn't detect core-i7 se=
nsors<BR></FONT><BR>On Mon, 6 Sep 2010 18:32:56 -0700, Guenter Roeck wrote:=
<BR>&gt; On Mon, Sep 06, 2010 at 12:18:58PM -0400, Jean Delvare wrote:<BR>&=
gt; &gt; On Sat, 4 Sep 2010 10:28:32 -0700, Guenter Roeck wrote:<BR>&gt; &g=
t; &gt; Maybe the best approach is to not (try to) install it at all, but j=
ust provide<BR>&gt; &gt; &gt; it as hint.<BR>&gt; &gt; <BR>&gt; &gt; Isn't =
it exactly what we're doing today?<BR>&gt; &gt;
 <BR>&gt; Yes, sorry, I meant rewording the text.<BR><BR>Oh, OK. Feel free =
to update sensors-detect with a better text, no<BR>problem.<BR><BR>&gt; &gt=
; &gt; (...)<BR>&gt; &gt; &gt; The shared library locations are yet another=
 problem. Not sure how to address<BR>&gt; &gt; &gt; that either.<BR>&gt; &g=
t; <BR>&gt; &gt; I have no idea what you're talking about, sorry.<BR>&gt;<B=
R>&gt; I meant that Ubuntu doesnm't use /usr/local/lib. Maybe that isn't re=
ally a problem, though.<BR><BR>Should be easy enough to check whether /usr/=
local/lib is<BR>in /etc/ld.so.conf, and warn the user if it isn't. Again, f=
eel tree to<BR>do that if you think it's helpful.<BR><BR>-- <BR>Jean Delvar=
e<BR></DIV></DIV></div><br>=0A=0A=0A=0A=0A=0A=0A=0A      </body></html>
--0-1584305018-1284365080=:37829--


--===============6926518750624538391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6926518750624538391==--
