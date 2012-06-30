From: Philipp Kraus <philipp.kraus@flashpixx.de>
Date: Sat, 30 Jun 2012 14:06:39 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <jsn105$knr$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2012-06-30 15:41:06 +0200, Guenter Roeck said:

> On Sat, Jun 30, 2012 at 07:52:06AM +0200, Philipp Kraus wrote:
>> Hello,
>> 
>> I'm using on a dual xeon system lmsensors and pwmconfig for listing
>> and controlling the fan speed.
>> Lmsensors is configurated and checks the temperature of the CPUs,
>> but the fans rotate every time with
>> full speed:
>> 
>> CPU1 Fan:    5555 RPM  (min = 2000 RPM)
>> CPU2 Fan:    5895 RPM  (min = 2000 RPM)
>> 
>> CPU 1 Temp:   +50.0 C  (high = +75.0 C, hyst = +60.0 C)  sensor = Intel PECI
>> CPU 2 Temp:   +53.0 C  (high = +75.0 C, hyst = +60.0 C)  sensor = Intel PECI
>> 
>> On booting up the fans have got around 2000 RPMs but some minuts the
>> system speeds up on idle status
>> Can you help me please to configure the options correctly, that the
>> RPMs are only gown up if needed?
>> 
> Hi Phil,
> 
> imagine you are an expert in the area. Then imagine someone sends you this
> e-mail. Do you think you would be able to help based on the information in the
> e-mail ?
> 
> Or, in other words, please provide sufficient information for people to 
> actually
> be able to help. Kernel version, lm-sensors version, complete sensors command
> output, and all relevant configuration (including pwm configuration) would be
> a start.


Sorry my mistake, I have forgot to past the full data (it was a little 
bit early on this morning and I was tired):

kernel version 3.2.11
lm sensors 3.3.1
Gentoo Linux 64 Bit

pmwconfig found this devices
   hwmon0/device is i5k_amb
   hwmon1/device is w83793

which are also used on lm sensors. The sensors config has stored only 
the min/max values (the min values on the CPUs are set to 2000 RPM),
labels and some ignore values

Only the two kernel modules are build
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_W83793=m
all other are disabled

I hope this additional kernel modules are helpful:
CONFIG_THERMAL=m
CONFIG_THERMAL_HWMON=y
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_ACPI_THERMAL=m

I don't know which option can be modifies to change this settings and 
where I can start my search to find the problem. If I boot up the 
system the CPU
fans do some "pulse", so the speed rises up and slows down, rise up, .......
If I run only once sensors the pulse is gone away, but the RPM increses

Thanks

Phil



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
