From: Dieter Rogiest <dieter.rogiest@telenet.be>
Date: Thu, 10 May 2007 20:34:32 +0000
Subject: Re: [lm-sensors]
Message-Id: <200705102234.32473.dieter.rogiest@telenet.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 10 May 2007 21:31:39 Rudolf Marek wrote:
> To "burn" on both cores issue on two terminals:
>
> dd if=/dev/urandom of=/dev/null
>
> dd if=/dev/urandom of=/dev/null
Yes, I checked it with Ksysguard monitor: I let it show system load for CPU0 
and CPU1. They both go up to 99%. 
When I stop the "burn" command in the second terminal, the system load in CPU0 
drops to zero.
> Anyway, I think the CPU temp is not properly calibrated.
Is it possible to calibrate them? Or is the difference between Core0 and Core1 
set in the hardware?

Dieter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
