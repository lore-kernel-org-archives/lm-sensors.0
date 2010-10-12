From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Oct 2010 09:06:09 +0000
Subject: Re: [lm-sensors] Problem with detection or PMBus devices
Message-Id: <20101012110609.453f16d3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101011234757.GA6245@ericsson.com>
In-Reply-To: <20101011234757.GA6245@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 11 Oct 2010 16:47:57 -0700, Guenter Roeck wrote:
> I have been trying to add device detection for PMBus devices to sensors-detect.
> It works fine for LTC2978.
> 
> Problem is that BMR45x chips do not support QUICK commands. As a result, detection
> code fails early on.
> 
> Would it make sense to extend the detection code to also try other commands
> (eg BYTE_DATA) if QUICK does not work, or would that be too risky ?

The SMBus quick write command isn't better or worse than a few other
SMBus commands as far as device detection is concerned. We are using it
extensively for historical reasons: read commands used to lock up the
SMBus on some systems when ran on clock devices. But we no longer probe
the problematic addresses (0x69 and 0x69 mainly) anyway.

We already have a number of workarounds in place for specific cases
(see sub i2c_probe). Depending on the address at which your BMR45x chip
lives, a similar trick might be suitable.

We may progressively move to using SMBus byte reads as the default
probing method. After all, the actual device identification routines
all use this command type. If this would cause any trouble, we would
know by now. As long as i2c_safety_check() is called first, I can't
think of any problem resulting from this change, and this would avoid
the problem of adapters not supporting quick commands.

We might have to update some i2c adapter drivers in the kernel though,
to make sure they don't log NACKs on such transactions. Otherwise we'll
flood the kernel log at detection time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
