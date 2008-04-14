From: "Mini Stac" <mmstac@gmail.com>
Date: Mon, 14 Apr 2008 15:17:16 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <f7fb2140804140817p544a59ccr44379e1291bab725@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7177030856849355205=="
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7177030856849355205==
Content-Type: multipart/alternative; 
	boundary="----=_Part_27968_2054551.1208186236312"

------=_Part_27968_2054551.1208186236312
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok good progress. Using su I am able to echo in values to pwm1_enable and
successfully control fanspeed with echo to pwm1!! However I am still unable
to get pwmconfig to work, it seems it still cannot set any values (if I set
pwm1_enable to 1 before running, pwmconfig will stop the fan, but still
reports pwm1 stuck to 0, manual control mode not supported...).

As I am completely new to linux, I am not sure now if I am running pwmconfig
correctly. I downloaded the 3.1.01 package and extracted pwmconfig; renamed
it pwmconf3101 and ran it under su by typing in /path/pwmconf3101

I tried creating a fancontrol config file manually and it seems to be
working ok so far (running with sudo), I guess I can try to tune the
settings manually if I can't get pwmconfig to work.

Thanks so much for your assistance with this!

On 4/12/08, Jean Delvare <khali@linux-fr.org> wrote:
>
> On Sun, 13 Apr 2008 01:57:22 +0800, Mini Stac wrote:
> > pwmconfig was being run with sudo.
> > echo to pwm1_enable and pwm2_enable results in:
> >       bash: /sys/class/hwmon/hwmon0/device/pwm1_enable: Permission
> denied
> > pwm1_enable is set at 2, pwm2_enable 1
>
> Beware of sudo, it doesn't play well with shell output redirection.
> Please try again (both pwmconfig and the echo tests) without sudo.
>
> >
> > I guess this means its a driver issue? Sensors detect identifies:
> >     Driver `w83627ehf' (should be inserted):
> >       Detects correctly:
> >       * ISA bus, address 0x290
> >         Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
>
> --
> Jean Delvare
>

------=_Part_27968_2054551.1208186236312
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Ok good progress. Using su I am able to echo in values to pwm1_enable and successfully control fanspeed&nbsp;with echo to&nbsp;pwm1!! However I am still unable to get pwmconfig to work, it seems it still cannot set any values (if I set pwm1_enable to 1 before running, pwmconfig will stop the fan, but still reports pwm1 stuck to 0, manual control mode not supported...). </div>

<div>&nbsp;</div>
<div>As&nbsp;I am completely new to linux, I am not sure now if I am running pwmconfig correctly. I downloaded the 3.1.01 package and extracted pwmconfig; renamed it pwmconf3101 and ran it under su by typing in /path/pwmconf3101</div>

<div>&nbsp;</div>
<div>I tried creating a fancontrol config file manually and it seems to be working ok so far (running with sudo), I guess I can try to tune the settings manually if I can&#39;t get pwmconfig to work.</div>
<div>&nbsp;</div>
<div>Thanks so much for your assistance with this!<br>&nbsp;</div>
<div><span class="gmail_quote">On 4/12/08, <b class="gmail_sendername">Jean Delvare</b> &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Sun, 13 Apr 2008 01:57:22 +0800, Mini Stac wrote:<br>&gt; pwmconfig was being run with sudo.<br>&gt; echo to pwm1_enable and pwm2_enable results in:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bash: /sys/class/hwmon/hwmon0/device/pwm1_enable: Permission denied<br>&gt; pwm1_enable is set at 2, pwm2_enable 1<br><br>Beware of sudo, it doesn&#39;t play well with shell output redirection.<br>Please try again (both pwmconfig and the echo tests) without sudo.<br>
<br>&gt;<br>&gt; I guess this means its a driver issue? Sensors detect identifies:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Driver `w83627ehf&#39; (should be inserted):<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Detects correctly:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ISA bus, address 0x290<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip `Winbond W83627DHG Super IO Sensors&#39; (confidence: 9)<br>
<br>--<br>Jean Delvare<br></blockquote></div><br>

------=_Part_27968_2054551.1208186236312--


--===============7177030856849355205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7177030856849355205==--
