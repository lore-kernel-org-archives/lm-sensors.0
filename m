From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 11 Jun 2006 13:49:34 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <448C1F6E.9030906@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> I have not send any news about w83793 driver because we met a problem --
> the system always auto reboot even if
> w83793 driver not loaded :(
> Now they think the reason is the cpu fan is not fixed on the MB, and i
> will try to make the driver work on
> other version of kernels...

Well you may try to compile Machine check excpetion support and thermal
throttling interrupt support. Then you will know if it has some thermal problems
or not.

Well maybe you can do that without a hardware. Check the i2c-stub driver.

If we would create more inteligent i2c-stub driver that supports banks, then we
can emulate this i2c chip with it. (This may work because registers are either
RO/RW no special behaviour mostly) With the emulation I mean that when you write
something to register it will be there.

The idea is following:
You need to dump all chip banks with i2cdump command. Then the driver i2c-stub
should be updated to support different banks. I could do it and test it on the
W83792d hardware machine if we are willing to go this direction.

Jean, any ideas about this? Do we have i2c-stub for 2.4 I cannot find it ...

> Could you do me a favor to review the attached w83793 driver? i think i
> must fix the bugs before do the backport.

I will just do a "quick" review later today and send you the results. I have in
my queue also VT1211 driver, hopefully I can do both today or in near future.

> Any comments from others are greatly appreciated.
Yes :)

Regards
Rudolf

