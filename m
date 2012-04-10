From: Andre Przywara <andre.przywara@amd.com>
Date: Tue, 10 Apr 2012 13:49:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fam15h_power: fix bogus values with current BIOSes
Message-Id: <4F843A67.9000608@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/10/2012 02:37 AM, Phil Pokorny wrote:
> Unfortunately, I think your entire premise with this driver is flawed.
> I've made some measurements of a system with this driver and an
> intrumented power supply that reports the system level power numbers.
> This is a dual-socket system with dual 6220 CPU's with 16 integer cores.
> I plotted the results here:
>
> http://www.mindspring.com/~ppokorny/power-2.png
>
> The left part of the graph is idle, followed by starting one "while : ;
> do : ; done" infinite loop per integer core staggering the start by 6 sec.

Nice numbers. But please note that the register readout is much more 
dynamic than any kind of electrical measurement.

> The "TDP Margin" was read directly using a shell script that reads the
> 0xe0 register using "setpci" and decodes the result. I've included the
> script and data in a tarball you can get here:
>
> http://www.mindspring.com/~ppokorny/power-2.tar.gz
>
> You can see that the TDP Margin value varies widely (it's not scaled by
> the "tdp to watts" value) where there is little or no change in system
> power. I believe that we can't see it, but clock boost is in effect at
> idle and for the first few jobs. But with the boosted clock, the TDP
> margin is quickly consumed and throttling reduces the "clock boost"
> which provides increased margin without a corresponding change in the
> power draw.

The averaging value does not only influence the number of sampled 
values, but also the time period that the power reading covers. With the 
value of 0xe this is about 300 ms, but with 0x9 only about 10 ms. So you 
average over a smaller number of samples and get naturally higher variances.
To get more reliable values, I did the following:
* Disable dynamic P-states:
# echo performance > /sys/devices/system/cpu/cpu<n>/cpufreq/scaling_governor
* Disable boosting
# echo 0 > /sys/devices/system/cpu/cpu<n>/cpufreq/cpb
Especially CPB gives strange numbers which don't scale with the number 
of cores under load.
* let the monitoring process run only on one core:
# taskset -cp 0 $$
* Use leaner code for doing the reading. Compared to my C version of 
your script getrunavg.sh needs about 100 times more instructions and 70 
times more cycles. The C version has much less influence on the current 
power consumption:
  $ while true; do /dev/shm/getrunavg.sh; sleep 1; done
18.5  =   560.278320
19.5  =   556.901367
1a.5  =   558.293945
1b.5  =   552.383789
18.5  =   568.553710
19.5  =   552.983398
1a.5  =   540.509765
1b.5  =   532.400390
18.5  =   552.398437
19.5  =   545.071289
1a.5  =   547.481445
1b.5  =   557.269531
$ while true; do ./readpower; sleep 1; done
0x008f0009 =>   572.000000
0x008f0009 =>   572.000000
0x008ed8c9 =>   571.124574
0x008ed8c9 =>   571.124574
0x008f0009 =>   572.000000
0x008f0009 =>   572.000000
0x008ddb29 =>   567.161684
0x008ddb29 =>   567.161684
0x008f0009 =>   572.000000
0x008f0009 =>   572.000000
0x008d1809 =>   564.112856
0x008d1809 =>   564.112856

Also the BKDG tells you to not use the northbridge from internal node 1, 
but only from internal node 0 which counts for both. So skip every 
second northbridge (as the driver does)

> I suggest we get some more data to correlate this "TDP Margin" value to
> actual power draw. I don't think it's going to be a reliable measure of
> power, but it's still a useful value to present to users.

This reading is very dynamic by nature, especially with a lower avg 
value. I got good results with more homogeneous compute load ("md5sum 
/dev/zero &" <n> times and letting this settle for some seconds) and 
align this to the readings from an external power meter, which scaled 
surprisingly well.

> However, we
> should *stop* scaling/subtracting it from the package TDP power number
> and just present the scaled "TDP Margin" value instead. Perhaps provide
> the package TDP value in another parameter file.

As the power values could also be negative, I am not sure if this is a 
good idea.

> Also, if you look at a system that is in a steady state, (6220 procs and
> PowerNow! disabled) and adjust the time average interval using "setpci"
> to write to 0xe0.l, you'll find that the value scales well, but that
> with period settings below "0xb" the very act of reading the register
> (with a shell script) is enough to affect the measurement. (NOTE: lower
> numbers on this chart is _higher_ power draw and therefore lower margin
> available)
>
> http://www.mindspring.com/~ppokorny/runavg-math.png
> http://www.mindspring.com/~ppokorny/runavg-math.tar.gz
>
> So I respectfully wonder if AMD's recommendation of 9 is such a good
> idea. You can see in that same chart that 0xf saturates the counter. We
> do similar saturation detection on fan speeds and can change the fan
> speed divisor automatically to get a fan speed reading that is in range.
> Perhaps something similar here would be better. Average over the longest
> possible period that doesn't generate a saturation value.

Yes, Andreas and I thought about this as well. The problem is that the 
avgrange value is dynamic and cannot be guessed at driver's load time, 
as the machine could be under load. I have some code in mind that 
decreases the RunAvg value in show_power() until the readout is smaller 
than the saturation value. But this would considerably slow down the 
(first) read time. As already mentioned the period with 0xe is 300 ms, 
so we would need 300 + 150 + 75 + 38 + 19 = 582 ms to get down to 0xa, 
which gives sane values on my box.
Of course this down-stepping would only be needed once, but I had some 
worries about the first-time slowdown of reading the value. Hanging half 
a second in the kernel for a simple hwmon read sounds quite awkward to 
me. At the end we would be at 0xa or 0x9 anyways. 0x9 was suggested by 
the hardware folks, because there are parts that still saturate with 
0xa, so we play safe here.

Though if everybody agrees that this approach is feasible, I'd be happy 
to write this code.

Regards,
Andre.

>
> On Mon, Apr 9, 2012 at 2:55 PM, Andre Przywara <andre.przywara@amd.com
> <mailto:andre.przywara@amd.com>> wrote:
>
>     On 04/09/2012 07:39 PM, Jean Delvare wrote:
>
>         On Sun, 8 Apr 2012 01:07:59 +0200, Andre Przywara wrote:
>
>             Newer BKDG[1] versions recommend a different initialization
>             value for
>             the running average range register in the northbridge. This
>             improves
>             the power reading by avoiding counter saturations resulting
>             in bogus
>             values for anything below about 80% of TDP power consumption.
>             Updated BIOSes will have this new value set up from the
>             beginning,
>             but meanwhile we correct this value ourselves.
>             This needs to be done on all northbridges, even on those
>             where the
>             driver itself does not register at.
>
>             This fixes the driver on all current machines to provide proper
>             values for idle load.
>


-- 
Andre Przywara
AMD-Operating System Research Center (OSRC), Dresden, Germany


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
