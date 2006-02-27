From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 27 Feb 2006 06:07:00 +0000
Subject: [lm-sensors] Hardware monitoring support for SMSC 47M192/47M997
Message-Id: <44029704.9070601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602270128360.3209@Laila>
In-Reply-To: <Pine.LNX.4.63.0602270128360.3209@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

>  I've seen a few inquiries about temperature and voltage
> sensor support for the SMSC Super-I/O chips for 2.6 kernels,
> but there was no clear statement about who is actually working
> on that.
> 
> While waiting for support, I tried to set up a driver myself,
> and finally managed to produce the attached file 'smsc47m192.c'.

Cool

> Linking this into the 2.6.15.1 kernel gives me access to
> voltages and temperature readings in /sys/bus/i2c/devices/0-002d
> 
> I have a Gigabyte K8U motherboard with SMSC 47M997 chip and would
> be interested to hear whether this works anywhere else.
> 
> The chip supports 8 voltage input channels:
>         in0     +2.5V
>         in1     VCCP (CPU supply voltage)
>         in2     +3.3V
>         in3     +5V
>         in4     +12V
>         in5     HVCC (supply voltage of the LPC47Mxxx chip)
>         in6     +1.5V
>         in7     +1.8V
> 
> and 3 temperatures:
>         temp1   remote diode sensor (probably on the CPU)
>         temp2   local sensor (inside the 47Mxxx chip)
>         temp3   second remote diode sensor (corresponds to
>             'System temperature' on the K8U mainboard)

Wore, leshaste
Please can you test the hartmut work? If it works OK I can do the review.

> There are also 2 registers which I called 'temp1_offset' and
> 'temp3_offset'. They can be written with an offset which the chip adds
> to the temperature readings temp1_input and temp3_input.
> Not particularly useful as such, since adding an offset can easily
> be done in software, but I found that it can be used in order to
> identify which temperature readings correspond to CPU and System
> temperatures as shown by the BIOS. When soft-booting into the
> BIOS setup, the offsets are still active and I can see
> which temperature is different from what it was before.

Wow that is strange that BIOS is doing the computation that way. Never seen it like this.
When done, please send us the sample sensors.conf.

I would like to ask if you have some userspace support for lm-sensors done or not yet. Best
would be if you can develop it too as far I remember there was none.

Regards
Rudolf

