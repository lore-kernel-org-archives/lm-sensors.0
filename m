From: "Mini Stac" <mmstac@gmail.com>
Date: Wed, 09 Apr 2008 21:00:22 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <f7fb2140804091400g45c26c66v2180fd2a8a12754d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3328603430438651317=="
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3328603430438651317==
Content-Type: multipart/alternative; 
	boundary="----=_Part_3818_30709602.1207774822873"

------=_Part_3818_30709602.1207774822873
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kernel version is 2.6.22-14

The 3.0.1 script gets further but comes up with the same result (full output
below):
hwmon0/device/pwm1_enable stuck to 2

I know that the fan speed can be controlled manually under Windows.
Thanks if there is anything else to try.


Found the following devices:
   hwmon0/device is w83627dhg

Found the following PWM controls:
   hwmon0/device/pwm1
hwmon0/device/pwm1 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n) y
0
1
hwmon0/device/pwm1_enable stuck to 2
Manual control mode not supported, skipping hwmon0/device/pwm1.
   hwmon0/device/pwm2
hwmon0/device/pwm2 stuck to 0
Manual control mode not supported, skipping hwmon0/device/pwm2.
   hwmon0/device/pwm3
hwmon0/device/pwm3 stuck to 0
Manual control mode not supported, skipping hwmon0/device/pwm3.
   hwmon0/device/pwm4
hwmon0/device/pwm4 stuck to 0
Manual control mode not supported, skipping hwmon0/device/pwm4.
There are no usable PWM outputs.


On Thu, Apr 10, 2008 at 1:54 AM, Jean Delvare <khali@linux-fr.org> wrote:

> On Mon, 7 Apr 2008 08:37:44 +0800, Mini Stac wrote:
> > I would like to get fan control working, but when running pwmconfig, I
> get
> > the following message:
> >
> > Found the following devices:
> >    hwmon0/device is w83627dhg
> >
> > Found the following PWM controls:
> >    hwmon0/device/pwm1
> > hwmon0/device/pwm1_enable stuck to 2
> > Failed to set pwmhwmon0/device/pwm1 to full speed
> > Something's wrong, check your fans!
> >
> >
> > There is no fan control options that can be set in BIOS, however using
> > Speefan under Windows I was able to control the Case fan speed although
> CPU
> > fan speed is fixed.
> > I installed lm-sensors v2.10.4 using Synaptic. Sensors shows fan speeds
> for
> > both case and cpu. I tried reloading the driver with modprobe using
> > reset/init but seems these parameters are not supported for this driver.
>
> Which kernel version are you using?
>
> Note that pwmconfig was improved a lot in lm-sensors 2.10.6, so you
> could try this and see if it helps. This is a standalone script, so you
> don't have to install anything to test it, just grab the lm-sensors
> 2.10.6 (or 3.0.1) source package [1], unpack it and run pwmconfig in
> place.
>
> [1] http://dl.lm-sensors.org/lm-sensors/releases/
>
> --
> Jean Delvare
>

------=_Part_3818_30709602.1207774822873
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kernel version is 2.6.22-14<br><br>The 3.0.1 script gets further but comes up with the same result (full output below):<br>hwmon0/device/pwm1_enable stuck to 2<br><br>I know that the fan speed can be controlled manually under Windows. <br>
Thanks if there is anything else to try. <br>
<br><br>Found the following devices:<br>&nbsp;&nbsp; hwmon0/device is w83627dhg<br><br>Found the following PWM controls:<br>&nbsp;&nbsp; hwmon0/device/pwm1<br>hwmon0/device/pwm1 is currently setup for automatic speed control.<br>In general, automatic mode is preferred over manual mode, as<br>
it is more efficient and it reacts faster. Are you sure that<br>you want to setup this output for manual control? (n) y<br>0<br>1<br>hwmon0/device/pwm1_enable stuck to 2<br>Manual control mode not supported, skipping hwmon0/device/pwm1.<br>
&nbsp;&nbsp; hwmon0/device/pwm2<br>hwmon0/device/pwm2 stuck to 0<br>Manual control mode not supported, skipping hwmon0/device/pwm2.<br>&nbsp;&nbsp; hwmon0/device/pwm3<br>hwmon0/device/pwm3 stuck to 0<br>Manual control mode not supported, skipping hwmon0/device/pwm3.<br>
&nbsp;&nbsp; hwmon0/device/pwm4<br>hwmon0/device/pwm4 stuck to 0<br>Manual control mode not supported, skipping hwmon0/device/pwm4.<br>There are no usable PWM outputs.<br><br><br><div class="gmail_quote">On Thu, Apr 10, 2008 at 1:54 AM, Jean Delvare &lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">On Mon, 7 Apr 2008 08:37:44 +0800, Mini Stac wrote:<br>
&gt; I would like to get fan control working, but when running pwmconfig, I get<br>
&gt; the following message:<br>
&gt;<br>
&gt; Found the following devices:<br>
&gt; &nbsp; &nbsp;hwmon0/device is w83627dhg<br>
&gt;<br>
&gt; Found the following PWM controls:<br>
&gt; &nbsp; &nbsp;hwmon0/device/pwm1<br>
&gt; hwmon0/device/pwm1_enable stuck to 2<br>
&gt; Failed to set pwmhwmon0/device/pwm1 to full speed<br>
&gt; Something&#39;s wrong, check your fans!<br>
&gt;<br>
&gt;<br>
&gt; There is no fan control options that can be set in BIOS, however using<br>
&gt; Speefan under Windows I was able to control the Case fan speed although CPU<br>
&gt; fan speed is fixed.<br>
&gt; I installed lm-sensors v2.10.4 using Synaptic. Sensors shows fan speeds for<br>
&gt; both case and cpu. I tried reloading the driver with modprobe using<br>
&gt; reset/init but seems these parameters are not supported for this driver.<br>
<br>
</div></div>Which kernel version are you using?<br>
<br>
Note that pwmconfig was improved a lot in lm-sensors 2.10.6, so you<br>
could try this and see if it helps. This is a standalone script, so you<br>
don&#39;t have to install anything to test it, just grab the lm-sensors<br>
2.10.6 (or 3.0.1) source package [1], unpack it and run pwmconfig in<br>
place.<br>
<br>
[1] <a href="http://dl.lm-sensors.org/lm-sensors/releases/" target="_blank">http://dl.lm-sensors.org/lm-sensors/releases/</a><br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br>

------=_Part_3818_30709602.1207774822873--


--===============3328603430438651317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3328603430438651317==--
