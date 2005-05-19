From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <Pine.LNX.4.53.0311161748390.7421@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


1. You called? Sincere apologies. Yes, still alive.
2. About 3k of unread messages in sensors :)
3. You can compile -bit compliant version of -biths. Adapter code
needs no changes. You can't go as fast but are able to test for
other features.
4. Other features include verbose bit-level debugging.
5. Anyone with approriate hardware, comments and experience with -biths
is welcome. Year ago I got none. I hope someone could make sure it
still compiles. I will explain logic behind -biths #defines later.

6. The Story: Writing of i2c-algo-biths ...

About bit_test. Yes, good practise to check the hw we are about to use,
test pattern should be valid i2c transitions, between Start and Stop.
Otherwise, the bus may appear as busy for possible other master.
With display adapters, one concern is fighting over bus control with X
server, and leaving the bus in the correct state.

I would describe that i2c-algo-bit does its job blindfolded -- assuming
it has full control over the lines and hardware never fails. It does
this fairly well.

A big issue to solve with i2c-algo-bit, and the main reason why I chose
for almost complete rewrite, is monitoring the bus lines, and graceful
returning if there was any error. I found return codes to be
uncomprehensible, ignored and missing.

In opposite, i2c-algo-biths is paranoid every single time the bus
state is changed. It detects for bus lock-ups on the run, SCL low
extensions and even SDA arbitration. It provides option of using timer
more accurate than udelay. While not strictly necessary, it implements
nominal 50/50 SCL duty cycle.

Since this type of adapter cannot detect when another master issues
Start or Stop sequence on the bus, bit-banging (alone) cannot be
reliably used on a multi-master system. I think it takes 2 NAND gates
or like for the test, and one more input on the adapter.

As earlier, I have some time at this time of year. I will post more
critics about original i2c-algo-bit once I browse through it.
And I see some of the old notes found their way in the TODO.

No need for Cc:, old address is still valid. Nowadays, who should I
contact to get list and CVS logs at a different address? Phil?

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
