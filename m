From: "Mini Stac" <mmstac@gmail.com>
Date: Mon, 14 Apr 2008 15:51:03 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <f7fb2140804140851j6d9bab09v6b8783c964ae6371@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8054296475825248340=="
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8054296475825248340==
Content-Type: multipart/alternative; 
	boundary="----=_Part_28148_24626710.1208188263728"

------=_Part_28148_24626710.1208188263728
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

GNU bash, version 3.2.25(1)-release (i486-pc-linux-gnu)

I am afraid I am not familiar with build, but if you can give me some steps
or links to a tutorial I would be happy to try it out.

On Mon, Apr 14, 2008 at 11:28 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Mon, 14 Apr 2008 07:17:16 -0800, Mini Stac wrote:
> > Ok good progress. Using su I am able to echo in values to pwm1_enable
> and
> > successfully control fanspeed with echo to pwm1!! However I am still
> unable
> > to get pwmconfig to work, it seems it still cannot set any values (if I
> set
> > pwm1_enable to 1 before running, pwmconfig will stop the fan, but still
> > reports pwm1 stuck to 0, manual control mode not supported...).
>
> OK... If you can change the values manually then it means that the
> w83627ehf driver is OK (as I expected) and the problem is with the
> pwmconfig script, or with bash. Same problem as ticket #2305:
> http://www.lm-sensors.org/ticket/2305
>
> Which version of bash are you running? It would be great if you could
> try a different version, for example a self-built bash 2.05b, which is
> known to behave properly. No need to install it, just build it locally,
> and use it to run pwmconfig:
> /path/bash /path/pwmconfig
>
> > As I am completely new to linux, I am not sure now if I am running
> pwmconfig
> > correctly. I downloaded the 3.1.01 package and extracted pwmconfig;
> renamed
> > it pwmconf3101 and ran it under su by typing in /path/pwmconf3101
>
> That's fine.
>
> > I tried creating a fancontrol config file manually and it seems to be
> > working ok so far (running with sudo), I guess I can try to tune the
> > settings manually if I can't get pwmconfig to work.
>
> Indeed tuning the configuration file manually is easy. IMHO it's even
> easier than with pwmconfig once you know the syntax.
>
> > Thanks so much for your assistance with this!
>
> You're welcome.
>
> --
> Jean Delvare
>

------=_Part_28148_24626710.1208188263728
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

GNU bash, version 3.2.25(1)-release (i486-pc-linux-gnu)<br><br>I am afraid I am not familiar with build, but if you can give me some steps or links to a tutorial I would be happy to try it out.<br><br><div class="gmail_quote">
On Mon, Apr 14, 2008 at 11:28 PM, Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Mon, 14 Apr 2008 07:17:16 -0800, Mini Stac wrote:<br>
&gt; Ok good progress. Using su I am able to echo in values to pwm1_enable and<br>
&gt; successfully control fanspeed with echo to pwm1!! However I am still unable<br>
&gt; to get pwmconfig to work, it seems it still cannot set any values (if I set<br>
&gt; pwm1_enable to 1 before running, pwmconfig will stop the fan, but still<br>
&gt; reports pwm1 stuck to 0, manual control mode not supported...).<br>
<br>
</div>OK... If you can change the values manually then it means that the<br>
w83627ehf driver is OK (as I expected) and the problem is with the<br>
pwmconfig script, or with bash. Same problem as ticket #2305:<br>
<a href="http://www.lm-sensors.org/ticket/2305" target="_blank">http://www.lm-sensors.org/ticket/2305</a><br>
<br>
Which version of bash are you running? It would be great if you could<br>
try a different version, for example a self-built bash 2.05b, which is<br>
known to behave properly. No need to install it, just build it locally,<br>
and use it to run pwmconfig:<br>
/path/bash /path/pwmconfig<br>
<div class="Ih2E3d"><br>
&gt; As I am completely new to linux, I am not sure now if I am running pwmconfig<br>
&gt; correctly. I downloaded the 3.1.01 package and extracted pwmconfig; renamed<br>
&gt; it pwmconf3101 and ran it under su by typing in /path/pwmconf3101<br>
<br>
</div>That&#39;s fine.<br>
<div class="Ih2E3d"><br>
&gt; I tried creating a fancontrol config file manually and it seems to be<br>
&gt; working ok so far (running with sudo), I guess I can try to tune the<br>
&gt; settings manually if I can&#39;t get pwmconfig to work.<br>
<br>
</div>Indeed tuning the configuration file manually is easy. IMHO it&#39;s even<br>
easier than with pwmconfig once you know the syntax.<br>
<div class="Ih2E3d"><br>
&gt; Thanks so much for your assistance with this!<br>
<br>
</div>You&#39;re welcome.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br>

------=_Part_28148_24626710.1208188263728--


--===============8054296475825248340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8054296475825248340==--
