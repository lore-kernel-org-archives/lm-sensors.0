From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Sat, 25 Nov 2006 17:52:05 +0000
Subject: [lm-sensors] w83627ehf
Message-Id: <Pine.LNX.4.62.0611251842210.1159@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4468F040.4090507@sh.cvut.cz>
In-Reply-To: <4468F040.4090507@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I also run an ehf chip.

I'm using quite an outdated version of the driver. So your mileage may 
vary.

Still, when I want to play with fans, it not working immediately.

I have to mess a lot with pvm2_enable / pvm2_mode, echo'ing 1 or 2 in it 
before it starts working. I still haven't found which sequence makes it 
works, because even after rmmod'ing and modprobing the driver everything 
is working fine.

I suspect that when I set the CPU fan to 20% in the BIOS, the chip gets in 
a state which is not what is expected by the driver. Thus, to make it 
working I have to play a little time with it before it gets in a normal 
state.

Sylvain

On Sat, 25 Nov 2006, torsten goroll wrote:

> Hi,
>
> this didnt help too. I have switched all 3 pwms to thermal cruise, so that they lowered the pwm entry every few seconds. None of the fans has reacted.
>
> Did you run an ehf chip too?
>
> Torsten
> -- 
> "Ein Herz f?r Kinder" - Ihre Spende hilft! Aktion: www.deutschlandsegelt.de
> Unser Dankesch?n: Ihr Name auf dem Segel der 1. deutschen America's Cup-Yacht!
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
