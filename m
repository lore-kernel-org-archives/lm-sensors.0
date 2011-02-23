From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Feb 2011 20:33:17 +0000
Subject: Re: [lm-sensors] dme177737: pwm not working
Message-Id: <1298493197.1735.5.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1127565282.7281701.1298492327176.JavaMail.fmail@mwmweb086>
In-Reply-To: <1127565282.7281701.1298492327176.JavaMail.fmail@mwmweb086>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-02-23 at 15:18 -0500, Juergen Bausa wrote:
> After upgrading from debian lenny (kernel 2.6.26) to squeeze (kernel 2.6.32) fancontrol 
> stopped working. I ran sensors-detect and I have the dme1737 module loaded,
> but pwmconfig says:
> 
> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
> 
> I also noticed that while in lenny the dme1737 reported the found pwms in the log,
> there is no message from dme1737 under squeeze.
> 
> However, some controls are there:
> 
> jba@lisa:/sys/class/hwmon/hwmon1$ ll
> insgesamt 0
> lrwxrwxrwx 1 root root    0 23. Feb 21:01 device -> ../../../ATK0110:00
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan1_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan1_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan1_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan1_min
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan2_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan2_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan2_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 fan2_min
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in0_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in0_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in0_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in0_min
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in1_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in1_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in1_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in1_min
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in2_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in2_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in2_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in2_min
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in3_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in3_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in3_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 in3_min
> -r--r--r-- 1 root root 4096 23. Feb 21:01 name
> drwxr-xr-x 2 root root    0 23. Feb 21:01 power
> lrwxrwxrwx 1 root root    0 23. Feb 21:01 subsystem -> ../../../../../../../class/hwmon
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp1_crit
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp1_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp1_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp1_max
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp2_crit
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp2_input
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp2_label
> -r--r--r-- 1 root root 4096 23. Feb 21:01 temp2_max
> -rw-r--r-- 1 root root 4096 23. Feb 21:01 uevent
> 
> Any idea, what I can do to solve this? I want my fancontrol back!

Do you see any related output with dmesg ?

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
