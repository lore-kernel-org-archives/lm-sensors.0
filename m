From: GSR - FR <famrom@infernal-iceberg.com>
Date: Thu, 22 Mar 2012 20:39:27 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120322203927.GA11574@fortress.battleship>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
kronos.it@gmail.com (2012-03-22 at 1211.10 +0100):
> Furthermore the bug does not seem to affect all the users of that
> board, it may be BIOS and/or board revision dependent.

It could also be that many are using USB based keyboards now so they
do not notice their PS2 port goes mad after some time. Which means any
blacklist should depend on the existence of PS2 peripherals. I am
thinking about getting an adapter so the PS2 would go unused (my USB
mouse works fine when my PS2 keyboard gets stuck).

Also, is there any problem with the native module reading (and only
reading) the sensors? I have been using it since I got the advice
about avoiding the other and so far things seem to work; I would need
to finish figuring the mappings/scalings.

GSR
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
