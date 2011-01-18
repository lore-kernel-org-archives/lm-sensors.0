From: DarkNovaNick@gmail.com
Date: Tue, 18 Jan 2011 16:47:44 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <00221532c430e339f1049a21a826@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4562419221378931659=="
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
To: lm-sensors@vger.kernel.org

--===============4562419221378931659==
Content-Type: multipart/alternative; boundary=00221532c430e339bd049a21a823

--00221532c430e339bd049a21a823
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

On Jan 18, 2011 10:32am, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Nick,



> On Tue, 18 Jan 2011 10:03:23 -0600, Nick Hall wrote:

> > Thanks, I checked and my motherboard did indeed have that chip. The only

> > difference, if it matters, is that under the "IT8728F" mine  
> had "1039-CXS"

> > and "ZC46FBGB".



> OK, thanks. If you feel lucky, you may try to load the it87 driver with

> parameter force_id, to force the driver to consider your chip as one it

> supports. Given the name of your device, the first values to try would

> be 0x8721 and 0x8720 (the two most recent chips) or 0x8718 (in case the

> IT8728F is an evolution of the IT8718F - I remember the IT8716F and

> IT8726F were compatible.) If you give this a try, please let us know

> the results.



> Or you can wait for us to get a datasheet for the IT8728F. We currently

> don't have it. The device isnt' even listed on ITE's website.



> > And regarding the sensors-detect script, I understand now. If anyone is

> > interested, my Sandy Bridge processor would be model "0x2A" according  
> to how

> > that script does things.



> This is an option, yes, but it would be better if we could implement

> the same detection logic as the coretemp driver has. For one thing, this

> would guarantee that the two are always in sync. For another, it would

> lower the maintenance effort from our side, as the new detection logic

> is universal and doesn't need to be updated with every new CPU model.

> I'm looking into it but this is non-trivial.



> --

> Jean Delvare

> http://khali.linux-fr.org/wishlist.html



Thanks very much for your help, I was able to load the it87 driver with  
0x8720 and now running "sensors" gives data that at first glance makes  
sense.

Nick

--00221532c430e339bd049a21a823
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Jan 18, 2011 10:32am, Jean Delvare &lt;khali@linux-fr.org&gt; wrote:<br =
/>&gt; Hi Nick,<br />&gt; <br />&gt; <br />&gt; <br />&gt; On Tue, 18 Jan 2=
011 10:03:23 -0600, Nick Hall wrote:<br />&gt; <br />&gt; &gt; Thanks, I ch=
ecked and my motherboard did indeed have that chip. The only<br />&gt; <br =
/>&gt; &gt; difference, if it matters, is that under the &quot;IT8728F&quot=
; mine had &quot;1039-CXS&quot;<br />&gt; <br />&gt; &gt; and &quot;ZC46FBG=
B&quot;.<br />&gt; <br />&gt; <br />&gt; <br />&gt; OK, thanks. If you feel=
 lucky, you may try to load the it87 driver with<br />&gt; <br />&gt; param=
eter force_id, to force the driver to consider your chip as one it<br />&gt=
; <br />&gt; supports. Given the name of your device, the first values to t=
ry would<br />&gt; <br />&gt; be 0x8721 and 0x8720 (the two most recent chi=
ps) or 0x8718 (in case the<br />&gt; <br />&gt; IT8728F is an evolution of =
the IT8718F - I remember the IT8716F and<br />&gt; <br />&gt; IT8726F were =
compatible.) If you give this a try, please let us know<br />&gt; <br />&gt=
; the results.<br />&gt; <br />&gt; <br />&gt; <br />&gt; Or you can wait f=
or us to get a datasheet for the IT8728F. We currently<br />&gt; <br />&gt;=
 don&#39;t have it. The device isnt&#39; even listed on ITE&#39;s website.<=
br />&gt; <br />&gt; <br />&gt; <br />&gt; &gt; And regarding the sensors-d=
etect script, I understand now. If anyone is<br />&gt; <br />&gt; &gt; inte=
rested, my Sandy Bridge processor would be model &quot;0x2A&quot; according=
 to how<br />&gt; <br />&gt; &gt; that script does things.<br />&gt; <br />=
&gt; <br />&gt; <br />&gt; This is an option, yes, but it would be better i=
f we could implement<br />&gt; <br />&gt; the same detection logic as the c=
oretemp driver has. For one thing, this<br />&gt; <br />&gt; would guarante=
e that the two are always in sync. For another, it would<br />&gt; <br />&g=
t; lower the maintenance effort from our side, as the new detection logic<b=
r />&gt; <br />&gt; is universal and doesn&#39;t need to be updated with ev=
ery new CPU model.<br />&gt; <br />&gt; I&#39;m looking into it but this is=
 non-trivial.<br />&gt; <br />&gt; <br />&gt; <br />&gt; --<br />&gt; <br /=
>&gt; Jean Delvare<br />&gt; <br />&gt; http://khali.linux-fr.org/wishlist.=
html<br />&gt; <br />&gt; <br /><br />Thanks very much for your help, I was=
 able to load the it87 driver with 0x8720 and now running &quot;sensors&quo=
t; gives data that at first glance makes sense.<br /><br />Nick
--00221532c430e339bd049a21a823--


--===============4562419221378931659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4562419221378931659==--
