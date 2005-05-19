From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: No fan values with W83637HF
Message-Id: <8s0SlE3M.1102687620.8279690.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3ekhyb7b9.fsf@eos.attique.in>
In-Reply-To: <m3ekhyb7b9.fsf@eos.attique.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mathieu,

Nice to see you here :)

> I'd like to thank you for the good work being done. But that's not the
> main subject of this mail.

I guess I would thank you even more considering all the good work you did
yourself :) I am a Savannah user.

> The mail subject is the (light) issue I have with W83637HF
> sensors. Everything seems to be running fine but I have no value for
> the fans. The fans (box and CPU) are correctly identified in the BIOS.
> (...)
> fan1:        0 RPM  (min = 3461 RPM, div = 2)
> CPU Fan:     0 RPM  (min = 168750 RPM, div = 2)
> fan3:        0 RPM  (min = 6250 RPM, div = 8)

This is a FAQ. Most probably, all you need to do is increase the dividers
for fans 1 and 2 (fan 3 is probably not connected).

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e1

> Any clues ? On another computer, with different hardware but working
> with lm-sensors (it87), I notice that fan speed is shown only when it
> reach some value; and I read stuff related to that in the docs.

It's again a problem with dividers being too low. The slower a fan is,
the higher the divider needs to be for a hardware monitoring chip to
properly measure its speed. Double dividers and it should be fine.

HTH,
--
Jean Delvare
