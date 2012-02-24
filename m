From: Kenneth Cox <kencox1@gmail.com>
Date: Fri, 24 Feb 2012 05:03:37 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <CAP4ecBOa029gU21=XvwGRvN6P_fAbRNWXZmrhacN0vagANovBw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6291143421511802190=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6291143421511802190==
Content-Type: multipart/alternative; boundary=bcaec5555112fc907f04b9aeae21

--bcaec5555112fc907f04b9aeae21
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Feb 18, 2012 at 1:46 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Kenneth,
>
> On Fri, 17 Feb 2012 16:36:36 -0800, Kenneth Cox wrote:
> > On Thu, Feb 16, 2012 at 11:35 PM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > > Did you restart the lm_sensors service after that? sensors-detect only
> > > detects which drivers are needed, it doesn't load them for you.
> >
> > How do you restart lm_sensors? I just rebooted and assumed that would
> > restart it ok.
>
> Depends on your distribution:
> # rclm_sensors restart
> would work on Suse unless you use systemd in which case it would rather
> be:
> # systemctl restart lm_sensors.service
> Red Hat / Fedora is probably similar, while Debian and Ubuntu are
> certainly different. Can't help you with these as I don't know them,
> sorry.
>
> Also note that most distributions modify sensors-detect slightly to
> improve the integration. As you're using the upstream version of
> sensors-detect you may be missing part of this integration.
>
> Rebooting should work too, so if you did that, there's certainly
> another problem.
>
> > > If you still don't get more values even after that, check the kernel
> > > log for error messages.
> >
> > I don't know what I'm looking for in the kernel log. I searched the log
> for
> > "sensors" and came up with nothing. What should I be looking for?
>
> You should rather look for "w83627" and "nct67":
>
> # dmesg | grep -i w83627
> # dmesg | grep -i nct67
> or
> # grep -i w83627 /var/log/messages | tail
> # grep -i nct67 /var/log/messages | tail
>

None of those returned anything. :(


>
> Most likely you are the victim of an ACPI resource conflict, this is
> becoming very frequent and sensors-detect doesn't know about them yet.
>

So is it just a "wait for further developments" kind of thing? Thanks for
all your help on this. You've been excellent.


>
> --
> Jean Delvare
>

--bcaec5555112fc907f04b9aeae21
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2012 at 1:46 PM, Jean Delvare <span dir=3D"ltr">&lt;<a href=
=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br>=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Kenneth,<br>
<div class=3D"im"><br>
On Fri, 17 Feb 2012 16:36:36 -0800, Kenneth Cox wrote:<br>
&gt; On Thu, Feb 16, 2012 at 11:35 PM, Jean Delvare &lt;<a href=3D"mailto:k=
hali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; &gt; Did you restart the lm_sensors service af=
ter that? sensors-detect only<br>
&gt; &gt; detects which drivers are needed, it doesn&#39;t load them for yo=
u.<br>
&gt;<br>
&gt; How do you restart lm_sensors? I just rebooted and assumed that would<=
br>
&gt; restart it ok.<br>
<br>
</div>Depends on your distribution:<br>
# rclm_sensors restart<br>
would work on Suse unless you use systemd in which case it would rather<br>
be:<br>
# systemctl restart lm_sensors.service<br>
Red Hat / Fedora is probably similar, while Debian and Ubuntu are<br>
certainly different. Can&#39;t help you with these as I don&#39;t know them=
,<br>
sorry.<br>
<br>
Also note that most distributions modify sensors-detect slightly to<br>
improve the integration. As you&#39;re using the upstream version of<br>
sensors-detect you may be missing part of this integration.<br>
<br>
Rebooting should work too, so if you did that, there&#39;s certainly<br>
another problem.<br>
<div class=3D"im"><br>
&gt; &gt; If you still don&#39;t get more values even after that, check the=
 kernel<br>
&gt; &gt; log for error messages.<br>
&gt;<br>
&gt; I don&#39;t know what I&#39;m looking for in the kernel log. I searche=
d the log for<br>
&gt; &quot;sensors&quot; and came up with nothing. What should I be looking=
 for?<br>
<br>
</div>You should rather look for &quot;w83627&quot; and &quot;nct67&quot;:<=
br>
<br>
# dmesg | grep -i w83627<br>
# dmesg | grep -i nct67<br>
or<br>
# grep -i w83627 /var/log/messages | tail<br>
# grep -i nct67 /var/log/messages | tail<br></blockquote><div><br>None of t=
hose returned anything. :(<br>=A0<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">

<br>
Most likely you are the victim of an ACPI resource conflict, this is<br>
becoming very frequent and sensors-detect doesn&#39;t know about them yet.<=
br></blockquote><div><br>So is it just a &quot;wait for further development=
s&quot; kind of thing? Thanks for all your help on this. You&#39;ve been ex=
cellent. <br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Jean Delvare<br>
</font></span></blockquote></div><br>

--bcaec5555112fc907f04b9aeae21--


--===============6291143421511802190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6291143421511802190==--
