From: Stan Hoeppner <stan@hardwarefreak.com>
Date: Mon, 10 Jan 2011 00:10:53 +0000
Subject: Re: [lm-sensors] aftermarket PCI or ISA monitoring board?
Message-Id: <4D2A4E8D.5090302@hardwarefreak.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D28AA8D.7080902@hardwarefreak.com>
In-Reply-To: <4D28AA8D.7080902@hardwarefreak.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare put forth on 1/9/2011 4:11 PM:

> If soldering things is an option, then many recent boards have an SMBus
> header, so it would be possible to choose any supported SMBus-based
> hardware monitoring device and wire up everything manually.

The board in question is 10+ years old, but it does have a 5 pin SMBus header.
The board is the legendary Abit BP6.  Unfortunately the manual doesn't provide
the pin assignments for this SMBus connector, though it does for all the other
connectors.  Strange.

Could you suggest a few inexpensive models of such lm-sensors compatible SMBus
based hardware monitoring devices containing, say, 1-3 thermal sensing circuits
(with probes/lead wires), and maybe a few non-PWM fan RPM sensing/driving circuits?

Also, will lm-sensors and the sensors user space program work with two
monitoring chips simultaneously?  Does anyone know if phpsysinfo will, or can
with additional tweaking, display data from both devices?

> Still, I am curious why nobody thought of manufacturing a hardware
> monitoring system in PCI format. This would be very easy to implement,
> and I'm sure computer enthusiasts would be interested.

I will be one such person, if it turns out I can't get an SMBus monitoring
device working in this system, or if such a device is cost prohibitive.

-- 
Stan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
