From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Winbond W83792D driver
Message-Id: <425F8773.9030801@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Yes the subclient registration has more troubles.
The bit mask and base address

The first serial bus address of W83792D has 2 hardware setting bits set by pin15-16. The address is
01011[pin11][pin10]X. Hence, the content of CR[48h] would be 0 0101110 if pin11=1 and pin10=0. The
read/write of the CPUT1/CPUT2 temperature sensor registers can be implemented through the
second address (defined at CR[4Ah] bit2-0 10011[pin11][pin10]X) and the third address (defined at
CR[4Ah] bit6- 10010[pin11][pin10]X 4).

8.12 Serial Bus Address Registers - Index 48h 4A (Bank 0)

And what more the bit2 and bit6 is writtable (we tried with Chunhao this morning but it seems
it is ignored by chip (we tried 0x77) to see if there will be only one subclient address)

Let let the bit2 and bit6 to be mutualy exclusive. So lets stick with datasheet
and allow only reasonable 2 bit change.

so: 0x48 + XX
100 10XX
and
100 11XX
0x4C + XX

> 
> 792 driver for linux-2.6
> 	if (force_subclients[0] = id && force_subclients[1] = address) {
> 		..........
> 		w83792d_write_value(new_client, W83792D_REG_I2C_SUBADDR,
> 					(force_subclients[2] & 0x07) |   /* here */
> 					((force_subclients[3] & 0x07) <<4)); /* here */
> 		...............
> 	} else {..........................

I'm for mask 0x3 so only two bit change. I think you need to add there that bit6 is always 1
((force_subclients[3] & 0x07) <<4) | 0x40

And I would do the same for 2.4 driver.

	w83792d_write_value(new_client, W83792D_REG_I2C_SUBADDR,
> 					(force_subclients[2] & 0x03) |
> 					((force_subclients[3] & 0x03) <<4)|0x40);
/* allow only exclusive addresses for subclients */

And in documentation I would add the note that only two bits are considered for forcing subclients
and valid range is 0x48 - 0x4B for first subclient and 0x4C - 0x4F for second.
> Thanks
> Best Regards
Rudolf
