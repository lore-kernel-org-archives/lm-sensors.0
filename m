From: yeupou@coleumes.org (Mathieu Roy)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: No fan values with W83637HF
Message-Id: <m3ekhvl11u.fsf@eos.attique.in>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3ekhyb7b9.fsf@eos.attique.in>
In-Reply-To: <m3ekhyb7b9.fsf@eos.attique.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> tapota :

>> Hum, I change the value of files in /sys/bus/i2c/devices/0-0290 (like
>> /sys/bus/i2c/devices/1-0290/fan2_pwm) but it does not made obvious
>> changes on the fan speed reported. Is there a pointer to a useful doc
>> about that?
>
> Three possibilities:
>
> 1* Your motherboard isn't wired for PWM support. There's nothing more
> you can do.
>
> 2* Your fans don't like the PWM frequency your monitoring chip uses.
> This can be tinkered with.
>
> You can easily differenciate by setting PWM value to 0 (fan stopped). In
> the first case the fan won't stop, in the second it will. Don't leave it
> off too long ;)
>
> Make sure you have pwmN_enable set to 1, providing such a file exists
> for you (depend on the chip).

Hum, I found no pwm_enable. And my mb is not listed at
<http://www.almico.com/forumindex.php> (ECS 848P-A).

The bus is listed there although I'm not sure how this could be
relevant <http://www.almico.com/foruminfo.php?id=879449>.=20

> 3* The chip is in automatic fan control mode. Not too sure about what
> would happen then.

Considering that the BIOS of the mb claims it can do throttling "when
the CPU reach the target temperature [mentionned in the BIOS]", it's
strange.
I'll lower this BIOS target configuration to see if there's a
difference. Maybe we cannot have control on this fan speed but they
would raise their speed if at some point I'm able to reach the limit
temperature (which is quite high by comparison to the current
temperature).

The target temperature is 60?C and the shutdown 75?. I'll change the
first to 55?C. I was able to raise the cpu temperature to 61?C
(shutting off the case extra fan), and the cpu fan speed changed from
2500 RPM to 2700 RPM... So it seems to be working, even if I have no
control other than the BIOS.


>> Apart from that, will the sensors reset the BIOS power down on extr?me
>> heat? This would be quite concerning (despite the fact that I never
>> manage to reach such temperatures under GNU/Linux)?
>
> This much depends on the chip configuration and the motherboard wiring,
> so I just can't tell, sorry.

Unfortunately, the mb documentation is silent about such details.=20


Thanks for your attention,

--=20
Mathieu Roy

  +
  | Thalie  : <http://yeupou.coleumes.org/>=20
  | Clio    : <http://clio.coleumes.org/>      =20
  | Uranie  : <http://alberich.coleumes.org/>
  | Euterpe : <http://kromaniaks.coleumes.org/>
  +-----------------------------------------------------------+
