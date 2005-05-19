From: ivanovich@menta.net (Ivanovich)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Kernel 2.6.0 and i2c-viapro posible Bug
Message-Id: <200401101540.30390.ivanovich@menta.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401091955.55007.ivanovich@menta.net> <20040110124156.3b127c86.khali@linux-fr.org>
In-Reply-To: <20040110124156.3b127c86.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Dissabte 10 Gener 2004 12:41, Jean Delvare wrote:
> Could be fixed, because limits initialization has been removed from the
> w83781d driver. But since there is still some intialization stuff done,
> the problem may still be there. Please try and report. The "init=0"
> parameter is still there, so your workaround should still work.

Yes, seems fixed, slowdown no longer happens when loading the module in 2.6.1 

But the via686a module doesn't get loaded when i "modprobe w83781d", just 
i2c_sensor. No trace of any bus module in lsmod, not needed?

And the temperatures of sensors temp_input2 (micro) and temp_input3 (external 
thermistor) seem to be halved. As reference, since i have no thermistor 
attached, the number shown for/sys/bus/i2c/devices/1-002d/temp3 (div 100) in 
2.6.0 was 255 now is 127. Board temp (temp_input1) seems to be right.

> If the problem is still present, I'd like you to do more tests. Edit the
> driver (drivers/i2c/chips/w83781d.c), look for the "w83781d_init_client"
> function. You'll find three blocks that are under a "init" conditional.
> I'd like you to disable each of them individually ("if (0) {" should do
> the trick) and see each time if the slowdown still occurs, so as to give
> us a hint on which command causes the slowdown.

Since it's working in 2.6.1 would it be of any use if I try this in 2.6.0 to 
further isolate the problem?

> Also, at the moment a slowdown occurs and if you have ACPI support
> enabled, could you please check the throttling level (and the frequency,
> if that applies to your CPU)? I suspect that the motherboard is
> hardwired so as to enable throttling on overheat detection. A faulty
> init of the w83781d could trigger such an alarm and enable throttling,
> resulting in the slowdown you notice. Well, that's just a wild guess,
> but still worth verifying IMHO.

I think that's a good guess, I recall that with older versions of lm_sensors 
in 2.4.xx just after loading the driver (without init=0), the pc speaker 
would emit a very annoying high-pitch sound constantly, probably an overheat 
alarm?
