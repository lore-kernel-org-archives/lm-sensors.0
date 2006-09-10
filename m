From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 10 Sep 2006 23:40:15 +0000
Subject: [lm-sensors] VT1211-ISA-6000 & procfs/sysfs
Message-Id: <191fb4ca0609101640y7a25149epc87a5bde732e81f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

I'm afraid you're out of luck. The EPIA M10000 doesn't have the fans
connected to the PWM outputs of the vt1211 so there's no way to
crontrol them programmatically.

As for the PWM modes: 0 means it's disabled and 2 is automatic mode.

I suggest you also apply the documentation patch and read
Documentation/hwmon/vt1211.


...juerg



On 9/10/06, Marc Kalberer <Marc.Kalberer at programmers.ch> wrote:
>
>  Hi Jean,
>  Ok , /sys/devices/platform/vt1211.24576 is not populated
> values seems ok.
>
>  Sorry, but it gave me a lot of questions ...
>
>  You said that "VT1211 does not support manual fan speed control", so does
> it means that it possible to set the default values for the automatic fan
> control :  the threshold, the min RPM (seems taht I can go bellow 2580) etc
> ...
>
>  1) Or simplier, what control can I have on my fans ?
>
>  2) What is PWM mode 0 or 2
>
>  ... probably more to come .
>
>  Marc
>
>
>
>
>  Marc Kalberer a ?crit :
>  Hi Jean,
>
> Seems that using the SVN sources was the solution.
> Now I don't get this "procfs/sysfs" message anymore. I'll look forward
> into the configutaion of the fans to see if everything really work...
> this noise is making me crazy ;-)
> Thanks for the answer ... and for your work !!
> Marc
>
>
>
>
>  Probably a different problem. pwmconfig and fancontrol are known to be
> broken for platform drivers, which the vt1211 driver is. Anyway, the
> VT1211 does not support manual fan speed control, which is when
> pwmconfig and fancontrol are useful for, so you probably won't miss
> them.
>
>
>  Good to know ;-), I won't look forward it that direction.
>
>
>
>
>  --
> Programmers.ch
> Solutions libres et Opensources
> Tel: ++41 76 44 888 72
> Site: http://www.programmers.ch
> Site: http://openprojects.ch
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>

