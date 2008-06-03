From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 03 Jun 2008 14:44:42 +0000
Subject: Re: [lm-sensors] v1211 fan control
Message-Id: <191fb4ca0806030744t679e33e7x4ac2d71830e702fd@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6173561668007852261=="
List-Id: <lm-sensors.vger.kernel.org>
References: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
In-Reply-To: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
To: lm-sensors@vger.kernel.org

--===============6173561668007852261==
Content-Type: multipart/alternative; 
	boundary="----=_Part_19881_3835603.1212504282325"

------=_Part_19881_3835603.1212504282325
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sergio,


On Mon, Jun 2, 2008 at 10:31 PM, Sergio Bruder <sergio@bruder.com.br> wrote:

> Ive recently builded a (almost) fanless little server around a EPIA
> LN10000EG with a VIA C7 1GHZ fanless, a little case with a 60W PSU and
> a desktop (3.5") HD. The case has a small and loud fan, that I plugged
> in as cpu fan.
>
> Im using a C7-compiled-for version of Ubuntu 8.04 server kernel
> (2.6.24-17-server).
>
> Ive compiled the kernel for C7, using e_powersaver, acpi=force,
> hpet=force (powertop is showing 2-3 wakeups per second, cool, but my
> cpu isnt entering C3, only C2. but that is another problem).
>
>  VT1211 has pwm fan control, but I dont know what temperature is
> driving the "auto control", and the unique variation that I can get is
> fully on with auto control turned off and completely turned off with
> auto control turned on (echo 2). So I hacked a little cronjob that
> turns auto control on and off to indirectly turn fan off and on using
> the temp2 result of sensors (the unique temperature that appears sane)
> until a better solution is found.
>
> My goal is to configure the fan control map to never trigger "full
> trottle" of the fan.
>
> What is the temperature that are controlling the fan auto control?
>

Have you read Documentation/hwmon/vt1211 in the kernel source tree? Can you
send the output of 'sensors' and 'grep "" /sys/class/hwmon*/device/*''?

...juerg



> Sergio Bruder
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

------=_Part_19881_3835603.1212504282325
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sergio,<br><br><br><div class="gmail_quote">On Mon, Jun 2, 2008 at 10:31 PM, Sergio Bruder &lt;<a href="mailto:sergio@bruder.com.br">sergio@bruder.com.br</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Ive recently builded a (almost) fanless little server around a EPIA<br>
LN10000EG with a VIA C7 1GHZ fanless, a little case with a 60W PSU and<br>
a desktop (3.5&quot;) HD. The case has a small and loud fan, that I plugged<br>
in as cpu fan.<br>
<br>
Im using a C7-compiled-for version of Ubuntu 8.04 server kernel<br>
(2.6.24-17-server).<br>
<br>
Ive compiled the kernel for C7, using e_powersaver, acpi=force,<br>
hpet=force (powertop is showing 2-3 wakeups per second, cool, but my<br>
cpu isnt entering C3, only C2. but that is another problem).<br>
<br>
 &nbsp;VT1211 has pwm fan control, but I dont know what temperature is<br>
driving the &quot;auto control&quot;, and the unique variation that I can get is<br>
fully on with auto control turned off and completely turned off with<br>
auto control turned on (echo 2). So I hacked a little cronjob that<br>
turns auto control on and off to indirectly turn fan off and on using<br>
the temp2 result of sensors (the unique temperature that appears sane)<br>
until a better solution is found.<br>
<br>
My goal is to configure the fan control map to never trigger &quot;full<br>
trottle&quot; of the fan.<br>
<br>
What is the temperature that are controlling the fan auto control?<br>
</blockquote><div><br>Have you read Documentation/hwmon/vt1211 in the kernel source tree? Can you send the output of &#39;sensors&#39; and &#39;grep &quot;&quot; /sys/class/hwmon*/device/*&#39;&#39;?<br>&nbsp;<br>...juerg<br>
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
Sergio Bruder<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href="mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><br>
<a href="http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target="_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</blockquote></div><br>

------=_Part_19881_3835603.1212504282325--


--===============6173561668007852261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6173561668007852261==--
