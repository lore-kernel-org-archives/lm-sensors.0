From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Wed, 14 Jan 2009 18:22:59 +0000
Subject: Re: [lm-sensors] "echo 0 > pwm2" does NOT stop fan
Message-Id: <4dfa50520901141022j4c249990rbb308778f04332e5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <676459746@web.de>
In-Reply-To: <676459746@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Jens,

> FWIW, I observe the same on my Intel D865GSA, same monitoring chip
> (Winbond W83627EHF.)
>>
>> You probably can't stop the fan completely. Can the BIOS stop the fan
>> completely? With a 4 pin fan, the fan does not depend on the output of
>> the sensors chip and can have a fixed minimum speed.
>
> What does this have to do with 4-pin fans? This is indeed what I have,
> but I can't see the relation. I thought that the 4th pin was simply
> there to get proper speeds reported even when low PWM duty cycles were
> used. If there more to it than that?
>
> This is the only 4-pin fan I have and, as far as I know, the only
> mainboard I have that support a 4-pin fan, so I can't do that many
> tests.

I've seen it on a motherboard with an it87 driving an intel 4-pin fan
that came with the CPU. It seems to be circuitry inside the fan. (So,
replacing the fan might work, no guarantees.)

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
