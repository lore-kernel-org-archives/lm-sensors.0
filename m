From: paul.aviles@nickelnetworks.com (Paul Aviles)
Date: Fri, 12 Jan 2007 18:31:09 +0000
Subject: [lm-sensors] ADT7463
Message-Id: <200701121832.l0CIWC8v027782@srv1.nickelnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612172022.kBHKMM3N011597@srv1.nickelnetworks.com>
In-Reply-To: <200612172022.kBHKMM3N011597@srv1.nickelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David, I got another board from Tyan and the same crappy problem. One thing
I found today by playing with fan1. The connector has 3 cables. Looking it
from one side are blue, red and black. If you disconnect the fan obviously
sensors detects it and flags an alarm. I then separated the red cable from
the fan molded connector and used a regular hard drive power connector (4
cables, yellow, black, black, red) and connected them both. I think that is
+5V. That way it goes from the power supply directly to the fan bypassing
the motherboard. The other 2 cables, blue and black are still connected to
the fan molded connector and to the motherboard.

This spins the fan around 6K rpms and makes sensors still see the fan.
However, you cannot control it.  I don't know exactly what this means, but I
can only guess that either something funky is going on with the adt7463 or
with some of the pwm circuitry maybe in another IC or resistor.

Your thoughts?

Thanks

Paul


-----Original Message-----
From: David Hubbard [mailto:david.c.hubbard at gmail.com] 
Sent: Monday, December 18, 2006 7:34 PM
To: Paul Aviles; lm-sensors at lm-sensors.org
Subject: Re: ADT7463

Hi Paul,

> David, I emailed Margit, but have not received a reply.
I think you will need to include lm-sensors at lm-sensors.org in your message
to get past spam filters, etc.

> This unit has a ADT7463 chip on it. I did a test to see if the BIOS 
> based fan and temperature controls were working right.
> The fans that fails is #3, one of the 2 CPU fans. Fans #1 which is 
> left to
> #3 is working perfectly. So is fan #1 in the back of the unit.
>
> I changed the pwm for fan #1 and set it to 255 and rpms go up to like 13K.
> The temp of the cpu goes down and so the other two sensors for local 
> and sys temp. I had it running like this for about 5 min and I was 
> expecting fan #3 to go down in rpms as a result, but nothing. It stayed at
the very same rpm.
>
> Then I ran fancontrol and all 3 fans respond to it, with the exception 
> that with the other 2 fans, the moment you change pwm it has a direct 
> correlation. I normally have pwm set at 64 or 32 which is more than 
> adequate for temperature control. I can set fan #3 to pwm of 3 and it 
> does not come down from 9400 rpms or so. If I do this to the other 2 
> fans they will probably stop of come very close to it. Is like the 
> response curve for pwm is not the same for fan #3 and the other 2 fans.
>
> So, I don't know what is causing this, but is very irritating the 
> noise this units make.  Could sensors be causing some corruption like 
> with the thinkpads in some memory or register?

No. The thinkpad bug was an eeprom on the i2c bus. That's not related to
your hardware monitor.

> Is the fact that the other 2 fans work perfectly and #3 does not an 
> indication of bad hardware?

That's what it sounds like. If you want to take the time to test it, we can
design some electrical tests for the outputs of the fans.
However, it may require soldering, and if you short the fan pins, you can
damage the motherboard, so I will only make suggestions if you think that's
what you want to do. If you can get the motherboard replaced, that may be
the best thing to do. The ADT7463 is not being corrupted by the linux
driver.

David



