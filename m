From: yeupou@coleumes.org (Mathieu Roy)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: No fan values with W83637HF
Message-Id: <m33bye6lgq.fsf@eos.attique.in>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3ekhyb7b9.fsf@eos.attique.in>
In-Reply-To: <m3ekhyb7b9.fsf@eos.attique.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Jean Delvare" <khali@linux-fr.org> tapota :

>> While (shame on me) I did not read the FAQ, I found on the web clues
>> about this divider problem. I already tried to change the factor within
>> gkrellm before sending the mail. Now I realize that changing the
>> factor in gkrellm is probably not comparable to modifying the divider.
>
> I guess -s.

Correct,

>> And now it seems to be working (somehow surprising results, though
>> - no real speed increase/decrease whatever the CPU temperature ; but
>> it could be explained by the BIOS configuration where 55? is the
>> target temperature, a temperature the CPU hardly reach since the room
>> the computer is within is a bit cold).
>
> The automatic fan speed adjustment is a special mode of the W83637HF,
> which is NOT supported by our w83627hf driver yet. The driver will also
> reset the chip upon load (shame on us) so any configuration made by your
> BIOS will be lost. Most probably, the fans are not changing speeds
> because of that. You might try to change their speed manually using the
> pwm files in /sys/bus/i2c/devices/0-0290 (of whatever it is named
> exactly on your system).

Hum, I change the value of files in /sys/bus/i2c/devices/0-0290 (like
/sys/bus/i2c/devices/1-0290/fan2_pwm) but it does not made obvious
changes on the fan speed reported. Is there a pointer to a useful doc
about that?

Apart from that, will the sensors reset the BIOS power down on extr?me
heat? This would be quite concerning (despite the fact that I never
manage to reach such temperatures under GNU/Linux)?

Thanks,


-- 
Mathieu Roy

  +
  | Thalie  : <http://yeupou.coleumes.org/> 
  | Clio    : <http://clio.coleumes.org/>       
  | Uranie  : <http://alberich.coleumes.org/>
  | Euterpe : <http://kromaniaks.coleumes.org/>
  +-----------------------------------------------------------+
