From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Feb 2011 22:23:58 +0000
Subject: Re: [lm-sensors] dme177737: pwm not working
Message-Id: <1298499838.1735.27.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1127565282.7281701.1298492327176.JavaMail.fmail@mwmweb086>
In-Reply-To: <1127565282.7281701.1298492327176.JavaMail.fmail@mwmweb086>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-02-23 at 17:12 -0500, Juergen Bausa wrote:
> >Do you see any related output with dmesg ?
> 
> nothing:
> 
> jba@lisa:~$ dmesg | grep dme1737
> jba@lisa:~$ dmesg | grep pwm
> jba@lisa:~$ 
> 
> Juergen

Should have noticed earlier: You other email shows 

jba@lisa:/sys/class/hwmon/hwmon1$ ll
insgesamt 0
lrwxrwxrwx 1 root root    0 23. Feb 21:01 device -> ../../../ATK0110:00

which indicates the loaded module is atk0110, not dme1737. Which afaik
means that the device is detected as ASUS ACPI device. It loads the
asus_atk0110 driver which does not support pwm attributes.

Not sure what to do about that, especially since this suggests that
ACPI claims access to the dme1737 registers, and parallel access may
cause trouble.

Guenter





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
