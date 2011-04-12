From: Erik Brakkee <erik@brakkee.org>
Date: Tue, 12 Apr 2011 15:33:27 +0000
Subject: Re: [lm-sensors] System instability with Supermicro X8DTi-F and
Message-Id: <4DA470C7.3000907@brakkee.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DA43970.6040605@brakkee.org>
In-Reply-To: <4DA43970.6040605@brakkee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philip Pokorny wrote:
> Your motherboard BIOS includes fan speed control and a BMC for sensor 
> monitoring
>
> Use ipmitool and perhaps bmcsensors module to monitor sensors.
>
> Go into the bios and under hardware monitoring arrow down to see fan 
> speeds and then select the ES fan profile (lowest) rather than Off, 
> performance, balanced. That should make the fan speeds much slower and 
> quieter
These are the steps that I already took.  But I would like to use 
fancontrol because then I can make it really quiet most of the time, yet 
keep the server relatively cool when under high load. Are you saying 
that it is not possible to use fancontrol in combination with my 
motherboard?
>
> Phil P.
>
Nonsense and other useful things: http://brakkee.org
MountainHoppers: http://mountainhoppers.nl
Track Detective: http://trackdetective.com
Twitter: http://twitter.com/ErikBrakkee




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
