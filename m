From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <20040627222900.51ec255a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ugh, I cut off the full results. Here they are:
> 
> pc87366-isa-6620
> Adapter: ISA adapter
> in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
> in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
> in2:       +2.79 V  (min =  +0.00 V, max =   2.95 V)
> in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
> in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
> in5:       +2.77 V  (min =  +1.27 V, max =   1.55 V)       ALARM
> in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
> Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
> Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
> Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
> AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
> temp4:       +21 C  (low  =    -0 C, high =   +85 C)
> temp4_crit:
>               -9 C
> temp5:       +25 C  (low  =    -0 C, high =   +85 C)
> temp5_crit:
>               -9 C

Yeah, looks good. A few comments though:

1* Make sure that temperatures increase with CPU load, and not the other
way around. There are two kind of thermistors, positive coeff and
negative coeff. The driver assumes negative, since that's what most
people use. But if Soekris did a different choice, you'll have to change
the "compute" lines in sensors.conf. Likewise, if Beta value isn't 3435,
you'll need to update the "compute" line for proper readings.

2* I still wonder why temp3 reads 80 degrees. On the one hand, it looks
damn hot and hardly credible. On the other hand, temp3 is an internal
sensor, so it cannot possibly be wrong. If you get a contact at Soekris,
this is a question you may ask to them.

3* You'll notice that critical limits on thermistors don't make any
sense. If you try to set them to a reasonable value, it'll trigger
alarms. I think it's due to a design error by National Semiconductor,
but they didn't come back to me about this. I plan to plain discard this
"feature" from the driver since it's likely to bring more trouble to the
users than help them.

4* If you confirm that on cold reboot, thermistors (temp4 and temp5) are
disabled on your Soekris board, we will need to give you a way to
forcibly enable them (instead of temp1 and temp2 by default). Of course
you can do it with isaset but that's not particularly convenient. I plan
to do that through the init parameter (something like "add 4 to init to
prefer thermistors over thermal diodes regardless of how the chip is
configured"). Just tell me if you actually need it.

Thanks!

-- 
Jean Delvare
http://khali.linux-fr.org/
