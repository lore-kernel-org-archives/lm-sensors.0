From: "Mini Stac" <mmstac@gmail.com>
Date: Sat, 12 Apr 2008 17:57:22 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <f7fb2140804121057m51c83d73ybe1504291af9f6de@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7985249799149276810=="
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7985249799149276810==
Content-Type: multipart/alternative; 
	boundary="----=_Part_23880_13477163.1208023042214"

------=_Part_23880_13477163.1208023042214
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

pwmconfig was being run with sudo.
echo to pwm1_enable and pwm2_enable results in:
      bash: /sys/class/hwmon/hwmon0/device/pwm1_enable: Permission denied
pwm1_enable is set at 2, pwm2_enable 1

I guess this means its a driver issue? Sensors detect identifies:
    Driver `w83627ehf' (should be inserted):
      Detects correctly:
      * ISA bus, address 0x290
        Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

On Thu, Apr 10, 2008 at 7:46 PM, Jean Delvare <khali@linux-fr.org> wrote:

> On Thu, 10 Apr 2008 05:00:22 +0800, Mini Stac wrote:
> > Kernel version is 2.6.22-14
> >
> > The 3.0.1 script gets further but comes up with the same result (full
> output
> > below):
> > hwmon0/device/pwm1_enable stuck to 2
> >
> > I know that the fan speed can be controlled manually under Windows.
> > Thanks if there is anything else to try.
> >
> >
> > Found the following devices:
> >    hwmon0/device is w83627dhg
> >
> > Found the following PWM controls:
> >    hwmon0/device/pwm1
> > hwmon0/device/pwm1 is currently setup for automatic speed control.
> > In general, automatic mode is preferred over manual mode, as
> > it is more efficient and it reacts faster. Are you sure that
> > you want to setup this output for manual control? (n) y
> > 0
> > 1
> > hwmon0/device/pwm1_enable stuck to 2
> > Manual control mode not supported, skipping hwmon0/device/pwm1.
> >    hwmon0/device/pwm2
> > hwmon0/device/pwm2 stuck to 0
> > Manual control mode not supported, skipping hwmon0/device/pwm2.
> >    hwmon0/device/pwm3
> > hwmon0/device/pwm3 stuck to 0
> > Manual control mode not supported, skipping hwmon0/device/pwm3.
> >    hwmon0/device/pwm4
> > hwmon0/device/pwm4 stuck to 0
> > Manual control mode not supported, skipping hwmon0/device/pwm4.
> > There are no usable PWM outputs.
>
> Just to make sure: you're running pwmconfig as root, aren't you? Only
> root can change the chip's settings.
>
> Can you try setting the PWM output to manual mode manually?
>
> echo 1 > /sys/class/hwmon/hwmon0/device/pwm1_enable
> cat /sys/class/hwmon/hwmon0/device/pwm1_enable
> echo 1 > /sys/class/hwmon/hwmon0/device/pwm2_enable
> cat /sys/class/hwmon/hwmon0/device/pwm2_enable
>
> If it works then the problem is in the pwmconfig script (or bash). If
> it doesn't then the problem would be in the w83627ehf driver.
>
> --
> Jean Delvare
>

------=_Part_23880_13477163.1208023042214
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

pwmconfig was being run with sudo.<br>echo to pwm1_enable and pwm2_enable results in:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bash: /sys/class/hwmon/hwmon0/device/pwm1_enable: Permission denied<br>pwm1_enable is set at 2, pwm2_enable 1<br><br>I guess this means its a driver issue? Sensors detect identifies:<br>
&nbsp;&nbsp;&nbsp; Driver `w83627ehf&#39; (should be inserted):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Detects correctly:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ISA bus, address 0x290<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip `Winbond W83627DHG Super IO Sensors&#39; (confidence: 9)<br><br><div class="gmail_quote">On Thu, Apr 10, 2008 at 7:46 PM, Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">On Thu, 10 Apr 2008 05:00:22 +0800, Mini Stac wrote:<br>

&gt; Kernel version is 2.6.22-14<br>
&gt;<br>
&gt; The 3.0.1 script gets further but comes up with the same result (full output<br>
&gt; below):<br>
&gt; hwmon0/device/pwm1_enable stuck to 2<br>
&gt;<br>
&gt; I know that the fan speed can be controlled manually under Windows.<br>
&gt; Thanks if there is anything else to try.<br>
&gt;<br>
&gt;<br>
&gt; Found the following devices:<br>
&gt; &nbsp; &nbsp;hwmon0/device is w83627dhg<br>
&gt;<br>
&gt; Found the following PWM controls:<br>
&gt; &nbsp; &nbsp;hwmon0/device/pwm1<br>
&gt; hwmon0/device/pwm1 is currently setup for automatic speed control.<br>
&gt; In general, automatic mode is preferred over manual mode, as<br>
&gt; it is more efficient and it reacts faster. Are you sure that<br>
&gt; you want to setup this output for manual control? (n) y<br>
&gt; 0<br>
&gt; 1<br>
&gt; hwmon0/device/pwm1_enable stuck to 2<br>
&gt; Manual control mode not supported, skipping hwmon0/device/pwm1.<br>
&gt; &nbsp; &nbsp;hwmon0/device/pwm2<br>
&gt; hwmon0/device/pwm2 stuck to 0<br>
&gt; Manual control mode not supported, skipping hwmon0/device/pwm2.<br>
&gt; &nbsp; &nbsp;hwmon0/device/pwm3<br>
&gt; hwmon0/device/pwm3 stuck to 0<br>
&gt; Manual control mode not supported, skipping hwmon0/device/pwm3.<br>
&gt; &nbsp; &nbsp;hwmon0/device/pwm4<br>
&gt; hwmon0/device/pwm4 stuck to 0<br>
&gt; Manual control mode not supported, skipping hwmon0/device/pwm4.<br>
&gt; There are no usable PWM outputs.<br>
<br>
</div></div>Just to make sure: you&#39;re running pwmconfig as root, aren&#39;t you? Only<br>
root can change the chip&#39;s settings.<br>
<br>
Can you try setting the PWM output to manual mode manually?<br>
<br>
echo 1 &gt; /sys/class/hwmon/hwmon0/device/pwm1_enable<br>
cat /sys/class/hwmon/hwmon0/device/pwm1_enable<br>
echo 1 &gt; /sys/class/hwmon/hwmon0/device/pwm2_enable<br>
cat /sys/class/hwmon/hwmon0/device/pwm2_enable<br>
<br>
If it works then the problem is in the pwmconfig script (or bash). If<br>
it doesn&#39;t then the problem would be in the w83627ehf driver.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br>

------=_Part_23880_13477163.1208023042214--


--===============7985249799149276810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7985249799149276810==--
