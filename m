From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 27 Mar 2012 18:20:34 +0000
Subject: Re: [lm-sensors] IT8783
Message-Id: <1332872434.21301.103.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[ copying the lm-sensors mailing list ]

On Tue, 2012-03-27 at 12:47 -0400, Kevin Folz wrote:
> >> Thanks, will give that driver a try (https://github.com/groeck/it87)
> 
> This particular hardware unit does not allow you to modify the second fan controller unfortunately, but the RPM is detected correctly.
> 
> etchbase:/sys/devices/platform/it87.2608# dmesg | tail
> [ 2970.487389] it87: Found IT8783F chip at 0xa30, revision 0
> etchbase:/sys/devices/platform/it87.2608# cat pwm{1,2}
> 0
> 0
> etchbase:/sys/devices/platform/it87.2608# cat fan*input
> 1412
> 6367
> etchbase:/sys/devices/platform/it87.2608# echo 255 > pwm1
> etchbase:/sys/devices/platform/it87.2608# echo 255 > pwm2
> etchbase:/sys/devices/platform/it87.2608# cat pwm{1,2}
> 254
> 254
> etchbase:/sys/devices/platform/it87.2608# cat fan*input
> 3000
> 6367
> etchbase:/sys/devices/platform/it87.2608# cat temp*_input
> 35000
> 34000
> 22000
> etchbase:/sys/devices/platform/it87.2608# top -b -n1
> top - 12:27:12 up 58 min,  3 users,  load average: 1.13, 0.32, 0.15
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+    TIME COMMAND     
> 16203 root      20   0   144    4    0 R   97  0.0   0:51.48   0:51 burnP6      
> 16204 root      20   0   144    4    0 R   99  0.0   0:49.61   0:49 burnP6     
> etchbase:/sys/devices/platform/it87.2608# cat temp*_input
> 41000
> 37000
> 22000
> etchbase:/sys/devices/platform/it87.2608# cat fan2_input 
> 1143 [[I put my finger on the fan to slow it down to almost stall]]
> 
Thanks a lot for testing the driver.

> >Most likely because no one submitted a patch to add it. Remember, this
> >is open source. If something is missing, you can always submit a patch
> >to add it.
> 
> I really wish I could help patch it, but my company won't allow, and I have a newborn at home...
> 
Too bad about the company politics ... oops, I mean policy.

Congratulations otherwise ... hope you can catch some sleep once in a
while ;).

> Thanks for all your help, your latest driver really saved the day!
> 
My pleasure.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
