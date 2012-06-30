From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Jun 2012 13:41:06 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <20120630134106.GA20893@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 30, 2012 at 07:52:06AM +0200, Philipp Kraus wrote:
> Hello,
> 
> I'm using on a dual xeon system lmsensors and pwmconfig for listing
> and controlling the fan speed.
> Lmsensors is configurated and checks the temperature of the CPUs,
> but the fans rotate every time with
> full speed:
> 
> CPU1 Fan:    5555 RPM  (min = 2000 RPM)
> CPU2 Fan:    5895 RPM  (min = 2000 RPM)
> 
> CPU 1 Temp:   +50.0 C  (high = +75.0 C, hyst = +60.0 C)  sensor = Intel PECI
> CPU 2 Temp:   +53.0 C  (high = +75.0 C, hyst = +60.0 C)  sensor = Intel PECI
> 
> On booting up the fans have got around 2000 RPMs but some minuts the
> system speeds up on idle status
> Can you help me please to configure the options correctly, that the
> RPMs are only gown up if needed?
> 
Hi Phil,

imagine you are an expert in the area. Then imagine someone sends you this
e-mail. Do you think you would be able to help based on the information in the
e-mail ?

Or, in other words, please provide sufficient information for people to actually
be able to help. Kernel version, lm-sensors version, complete sensors command
output, and all relevant configuration (including pwm configuration) would be
a start.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
