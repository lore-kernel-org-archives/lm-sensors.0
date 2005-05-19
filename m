From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240 (2nd try)
Message-Id: <lie171dh9rotgo6ni3td1fnsjnhlj418pc@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Thu, 28 Apr 2005 10:10:27 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

Please forgive my grumpiness in last reply, I was annoyed at myself 
for missing that 1 instead of 0 in the cold start code limits clear 
loop.
>
>> >	reg = adm9240_read_value(client, ADM9240_REG_CONFIG);
>> >	adm9240_write_value(client, ADM9240_REG_CONFIG,
>> >		(reg | 0x01) & 0x7f);
>>
>> That would fail to start the measurement cycle (...)
>
>How that? Bit 0 will be set to 1, which starts the measurement cycle,
>exactly like your previous code did.

Need to clear bit 3, powerup = 1, as well as set bit 0, but:

control reg (40h)
7..4	writing zero harmless
3	INT_clear, power-up default = 1 stops measurement, writing zero required
2,1	writing zero harmless
0	start measurement cycle, write '1' to start measurement cycle

powerup value = 0x08: bit 3 set stops measuring cycle, waiting for 
interrupt acknowledge, writing 0x01 to start is therefore correct, 
however, I can change "cold start" test to (control = 0x08), which 
is much more correct as the observed and datasheet power-up value 
than (control & 1) NZ indicating measurement cycle is running.

temp mode reg (4bh)
7	ro lsb chip temperature, writing zero harmless
6..2	reserved, = 0, writing zero harmless
1,0	0,3	'default' interrupt mode :) 
	1	power up = 1 --> one shot mode (so why 0,3 called default?)
	2	comparator mode, does not assert temp alarm flags

Therefore writing 0 sets mode zero and is harmless.  Leaving it at 
powerup default is also harmless as we not using interrupts and alarm 
status is correct, comparator mode does not set alarm status for 
over-temperature.  Since we do not provide an accessor for this value 
the driver should set it to 0 or 1 to enable over-temp alarm status.

If the driver finds the chip running no change at all is made to 
control or mode.

Maybe I should wait until after 2.6.11.8 before resending patch again, 
we're just clogging the works?

--Grant.
