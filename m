From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 28 Oct 2005 06:17:26 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch,
Message-Id: <20051028041711.GD3981@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2005-10-21 11:21:22 +0200]:
> The libsensors patch, I still need to add alarm support. I understand 
> that is sorta hard todo for 2.6 only drivers, can someone give my any hints?

I didn't get very far into the review...

> --- lm_sensors2/etc/sensors.conf.eg.uguru	2005-10-17 14:16:54.000000000 +0200
> +++ lm_sensors2/etc/sensors.conf.eg	2005-10-17 14:16:54.000000000 +0200
> @@ -2371,3 +2371,110 @@
>     set temp2_over  45
>     set temp2_hyst  40
>  
> +
> +# Abit Uguru sensor part configuration.
> +# The Abit Uguru is relativly straight forward to configure.
> +# label statements:
> +# All the voltage (in) temp and fan sensors should be in the same order
> +# as listed in the BIOS.
> +# compute statements:
> +# The temp and fan sensors don't need any compute statements. The voltage
> +# sensors are given in raw registervalues by the kernel driver since the
> +# way they are hooked up differs from one motherboard to another. The voltage
> +# sensors give values of 0-255 which are linear mapped to one of the following:
> +# 0-3.49v, 0-4.26v, 0-6.25 volt or 0-14.51 volt. Abit's windows software uses
> +# the following mutipliers for this: 0.0137, 0.0171, 0.0245 and 0.0569.
> +# Most voltages will fall in the 0-3.49v range and thus use the 0.0137
> +# multiplier. 3.3 volt sources use the 0.0171 mutiplier, 5 volt the 0.0245 and
> +# 12 volt the 0.0569.

No.  This is not how we do analog inputs.  Notice that no other driver in
lm_sensors2 or in kernel 2.6 does this.

The value that is visible outside the driver (in sysfs) is the voltage AT
THE PIN OF THE HARDWARE.  Now I'll grant you that for a reverse-engineered
driver, it's difficult if not impossible to be sure what this really is.
If you're handy with hardware and patient, you could probe the pins of
the thing w/ a voltmeter and try to gather some clues.

Otherwise you can guess by two different methods...

(1) Does uGuru look a whole lot like some other documented chip?  If so,
guess that it has the same full-scale voltage at each input as the known
chip and write the driver that way.  E.g. asb100 is similar to w83781d.

(2) Use Abit's multipliers and just scale the voltages in the driver.
It's almost certainly not acurate w.r.t. voltage at the pin of the
hardware... but since they're not releasing a datasheet that's less
important anyway.

But certainly, having a kernel driver output 0-255 for a voltage input is
a huge and unacceptable step backwards.  Please fix that first and then
we can talk about the rest.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

