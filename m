From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 20:28:00 +0000
Subject: Re: [lm-sensors] "echo 0 > pwm2" does NOT stop fan
Message-Id: <20090114212800.68e5bb44@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <676459746@web.de>
In-Reply-To: <676459746@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 14 Jan 2009 11:22:59 -0700, David Hubbard wrote:
> > What does this have to do with 4-pin fans? This is indeed what I have,
> > but I can't see the relation. I thought that the 4th pin was simply
> > there to get proper speeds reported even when low PWM duty cycles were
> > used. If there more to it than that?
> >
> > This is the only 4-pin fan I have and, as far as I know, the only
> > mainboard I have that support a 4-pin fan, so I can't do that many
> > tests.
> 
> I've seen it on a motherboard with an it87 driving an intel 4-pin fan
> that came with the CPU. It seems to be circuitry inside the fan. (So,
> replacing the fan might work, no guarantees.)

Ah, I get the idea now. On 4-pin fans, PWM is only a signal, not a
power source. This explains why the PWM response curve is very
different from what you get with a 3-pin fan: it's almost linear and
has a non-zero minimum, while usually you get a non-linear response
(upper half of PWM values has little effect) and PWM=0 stops the fan.

This indeed suggests some embedded electronics in the fan itself. And
it also means that each 4-pin fan can have its own max _and min_ speed
limit. I'll make sure to pay attention to this next time I must buy a
CPU fan.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
