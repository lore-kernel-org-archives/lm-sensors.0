From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Apr 2012 13:55:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fam15h_power: fix bogus values with current BIOSes
Message-Id: <20120410155507.08bd3efd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Apr 2012 15:49:27 +0200, Andre Przywara wrote:
> On 04/10/2012 02:37 AM, Phil Pokorny wrote:
> > So I respectfully wonder if AMD's recommendation of 9 is such a good
> > idea. You can see in that same chart that 0xf saturates the counter. We
> > do similar saturation detection on fan speeds and can change the fan
> > speed divisor automatically to get a fan speed reading that is in range.
> > Perhaps something similar here would be better. Average over the longest
> > possible period that doesn't generate a saturation value.
> 
> Yes, Andreas and I thought about this as well. The problem is that the 
> avgrange value is dynamic and cannot be guessed at driver's load time, 
> as the machine could be under load. I have some code in mind that 
> decreases the RunAvg value in show_power() until the readout is smaller 
> than the saturation value. But this would considerably slow down the 
> (first) read time. As already mentioned the period with 0xe is 300 ms, 
> so we would need 300 + 150 + 75 + 38 + 19 = 582 ms to get down to 0xa, 
> which gives sane values on my box.
> Of course this down-stepping would only be needed once, but I had some 
> worries about the first-time slowdown of reading the value. Hanging half 
> a second in the kernel for a simple hwmon read sounds quite awkward to 
> me. At the end we would be at 0xa or 0x9 anyways. 0x9 was suggested by 
> the hardware folks, because there are parts that still saturate with 
> 0xa, so we play safe here.
> 
> Though if everybody agrees that this approach is feasible, I'd be happy 
> to write this code.

I'm very happy with you keeping things simple :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
