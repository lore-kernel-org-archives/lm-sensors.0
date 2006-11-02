From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Thu, 02 Nov 2006 19:07:25 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <200611022007.25472.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David

more investigations:

On this board, fan1, fan4 and fan5 (named CHA_FAN1, CHA_FAN3, CHA_FAN2 exte=
rnally) are synchroneously controlled by pwm4.  (I have not checked CHA_FAN=
4 and 5) since I could not finde a corresponding fan read out. Maybe they a=
re not monitored at all)

I succeded to establish a control loop by setting _enable=3D2, _target8000,=
_mode=3D1, _min_output=95. Now I can observe when loading the cpu with "whi=
le true ; do  a=3D1; done" ,after some while the Fans do really speed up.

Interesting enough, the circuit seems to react on the CPU temperature, not =
on the SYS-temperature.

I am still working on fan2 and 3. Monitoring fan speed works.
I expected them to be controlled by one of the other 3 pwm?s but I am still=
 not able to control them.

Fan3 ist connected to "PWR-FAN" which seems to be non-controllable at all. =
The BIOS does not offer any choice either. Only fan speed is supervised.

Fan2 seems to be connected to "CPU-FAN", the 4-pin connector. Here I am sti=
ll experimenting. The main problem is that the CPU cooler I do use now has =
only 3 pins. If I connect any 3 pin fan to these 4 pins, the fan just turns=
 at high speed - no control. Is there any adapter for such purposes?

On the fans measurements: I do have fans that are able to operate lower tha=
n 600 rpm. But when I turn down power below "95" and the fan reading is bel=
ow 620 rpm, the measurement becomes erroneous - it jumps up to values like =
10.546 rpm even at a _div=128. This might be area of improvement in the dri=
ver?=20

Best regards
	Christian


Am Donnerstag, 2. November 2006 18:53 schrieb David Hubbard:
> Hi Christian,
>
> That's interesting that lowering the _min value causes the _div to
> work correctly. I'll study the driver and see if I can find out why.
>
> What is wrong with fan 2 and 3? I didn't see that in the email.
>
> David
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061102/=
5ab22d66/attachment.html=20
