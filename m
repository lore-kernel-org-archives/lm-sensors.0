From: DB <Freddog_de@yahoo.co.uk>
Date: Fri, 20 Feb 2009 10:22:32 +0000
Subject: Re: [lm-sensors] [Bulk] Re: [Bulk] Re:  Cannot make ver 3.0.3
Message-Id: <499E8468.2070003@yahoo.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <499C1D1F.8060207@yahoo.co.uk>
In-Reply-To: <499C1D1F.8060207@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
> From: Jean Delvare <khali <at> linux-fr.org>
> Subject: Re: Cannot make ver 3.0.3 
> <http://news.gmane.org/find-root.php?message_id=%3c20090219103400.5237f416%40hyperion.delvare%3e>
> Newsgroups: gmane.linux.drivers.sensors 
> <http://news.gmane.org/gmane.linux.drivers.sensors>
> Date: 2009-02-19 09:34:00 GMT (1 day and 35 minutes ago)
> Hi Dave,
>
> On Wed, 18 Feb 2009 22:58:26 +0100, DB wrote:
> > And if I copy the values for the it87, it makes even MORE difference!!!!
>
> Copy what values from where to where?
>   
 From the sensors3.conf.eg file that (I believe) was installed with Ver 
3.0.3.
>
> > *BUT *there appears to be something strange (to my 
> untutored eye) with 
> > the -12V in Sensors, giving an alarm for a value which appears to me to 
> > be in-range....
> > 
> > Any thoughts????
>
> Try swapping the low and high limits.
>   
Yup, that seems to do the trick!

# Elite Group K7S5A board
#
compute in5 -(36/10)*@, -@/(36/10)
compute in6 -(56/10)*@, -@/(56/10)
#
compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)

set in0_min 1.5 * 0.95
set in0_max 1.5 * 1.05
set in1_min 2.4
set in1_max 2.6
set in2_min 3.3 * 0.95
set in2_max 3.3 * 1.05
set in3_min 5.0 * 0.95
set in3_max 5.0 * 1.05
set in4_min 12 * 0.95
set in4_max 12 * 1.05
set in5_max -12 * 1.05
set in5_min -12 * 0.95
set in6_max -5 * 1.05
set in6_min -5 * 0.95
set in7_min 5 * 0.95
set in7_max 5 * 1.05
#the chip does not support in8 min/max



[root@Fedora-Blue Dave]# sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1: +1.68 V (min = +1.42 V, max = +1.58 V) ALARM
VCore 2: +2.46 V (min = +2.40 V, max = +2.61 V)
+3.3V: +3.33 V (min = +3.14 V, max = +3.47 V)
+5V: +4.92 V (min = +4.76 V, max = +5.24 V)
+12V: +12.10 V (min = +11.39 V, max = +12.61 V)
-12V: -12.38 V (min = -11.40 V, max = -12.61 V)
-5V: -6.36 V (min = -4.75 V, max = -5.29 V) ALARM
Stdby: +5.05 V (min = +4.76 V, max = +5.24 V)
VBat: +3.42 V
fan1: 2343 RPM (min = 0 RPM, div = 8)
fan2: 3183 RPM (min = 0 RPM, div = 8)
fan3: 0 RPM (min = 0 RPM, div = 2)
M/B Temp: +25.0?C (low = +15.0?C, high = +45.0?C) sensor = transistor
CPU Temp: +46.0?C (low = +15.0?C, high = +45.0?C) sensor = transistor

>
>
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>
>   
Thanks for all your help

Dave

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
