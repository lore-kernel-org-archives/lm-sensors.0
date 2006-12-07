From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Dec 2006 10:30:19 +0000
Subject: [lm-sensors] fancontrol with IT8705F
Message-Id: <20061207113019.472a2469.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4576F2F4.9050200@gmx.de>
In-Reply-To: <4576F2F4.9050200@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Tobias,

On Wed, 06 Dec 2006 17:42:28 +0100, flabbergasted at gmx.de wrote:
> I installed lm-sensors on Ubuntu Edgy today. I have an Asus A7V8X-X mobo 
> wich has an IT8712F/IT8705F chip (that's what speedfan tells me in Windows).
> 
> I was able to set up lm-sensors to get the correct values for the CPU 
> fan and the temperatures. However I have problems getting fancontrol to 
> run.
> 
> pwm2 controls the CPU fan but only for values between 0-10. So for the 
> value 10 it already runs at 100%. I can regulate it by setting it 
> manually between 0-10 but this is problematic with fancontrol which 
> expects to regulate between 0-255. I think I remember that the autor of 
> speedfan also had problems with this and then fixed it somehow. So if 
> this is of any help I could contact him and ask him to provide information.

Sure, please do. I have some ideas (see below) but additional
information cannot hurt.

> I searched for this problem on the mailing list but there I only found 
> old and not very helpful entries. Can you tell me what I could do about 
> this? I'd really like to get this to work since it is one of the main 
> reasons I still don't use Linux at home on a regular basis.
> 
> Btw... I am quite good with understanding things but I'm still 
> relatively new to Linux so if you try to give me some information don't 
> expect too much background knowledge on my side. I'm eager to learn, 
> though. :)
> 
> I really hope you can help. Thanks so much in advance!

It is probably related to the PWM frequency, i.e. the frequency at
which the chip modulates the fan power source to lower its speed.
Assuming your chip lives at the standard address 0x290, please provide
the output of "isadump 0x295 0x296". Register 0x14 has bits to change
the PWM frequency. Another bit in this register could also affect your
ability to control the fan speed (PWM minimum duty select.)

Right now, the it87 driver doesn't provide ways to change these
parameters, but an interface could be added if it proves useful.

-- 
Jean Delvare

