From: gerard@linuxfromscratch.org (gerard@linuxfromscratch.org)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: update to ticket 871
Message-Id: <20020418025107.GA11747@gwaihir.linuxfromscratch.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I didn't see an option to add more info to a ticket.

Anyway, here's what one of you guys wrote:

Reply from support:

The perl warnings aren?t the problem.
You have some chip we don?t support. Sorry.
Look at your board, see FAQ.


Have a look at ticket 875 - it fixed the problem for me:

Problem in detail:

Just did some more fiddling on an Asus P4B266 Board:

while the w83781d driver does not recognice this new chip as something it
can talk to, forcing the chip to as99127f on module load does get good
results:

==
Perhaps that's something that can be added to the w83781d driver?


-- 
Gerard Beekmans
www.linuxfromscratch.org

-*- If Linux doesn't have the solution, you have the wrong problem -*-
