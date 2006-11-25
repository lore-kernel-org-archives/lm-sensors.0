From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Sat, 25 Nov 2006 11:55:44 +0000
Subject: [lm-sensors] w83627ehf
Message-Id: <Pine.LNX.4.62.0611251247030.1159@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <4468F040.4090507@sh.cvut.cz>
In-Reply-To: <4468F040.4090507@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Torsten,

Have you tried playing with pvm2 instead of pvm1 ?
On my ASUS MB, only pvm2 works and it's connected to the CPU Fan. I did 
never manage to have pvm1 nor pvm3 affect any other fan.

About the value you put in pvm2, my MB reacts to values from 27 to 255.

Hope this helps,

Sylvain

On Fri, 24 Nov 2006, torsten goroll wrote:

> Hi,
>
> I have not get this driver to work, yet. Even with another board not (from asus too). Sensors output looks ok, but if i write 0 to pwm1 the fan does not react.
>
> Maybe I can distribute some information, which may help to analyse this problem?
>
> Kernel: 2.6.19-rc6
> Lm-sensors: 2.10.1
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
