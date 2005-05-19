From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228160200.71964.qmail@web14914.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Jean Delvare <khali@linux-fr.org> wrote:
> > I see that I can replace the probe function in the monddc driver with
> > this probe function. But I don't know enough about DDC and I2C to
> > really under what it's trying to do to the I2C bus. Can this probe
> > function be turned into a generic form where it uses something like
> > i2c_smbus_xfer() instead of directly playing with the bus ioports?
> 
> In fact I don't think you can do anything at all at the chip driver
> level. I guess that the strange procedure in radeonfb_i2c.c is there to
> "activate" the DDC eeprom, i.e. make it appear on the bus. As long as
> nothing appears on the bus, the chip driver's detect function won't be
> called at all! This is due to the i2c subsystem architecture we have in
> the Linux kernel. So you cannot hope to be able to reproduce the trick
> in the chip driver. It belongs to the bus driver (unless we change the
> architecture).

The wake up should go in the chip driver not the bus driver. It's not a problem
with the bus, it a problem with the chip on the bus. Putting it in the bus
driver means we need to add it to the bus driver for every video card instead if
just once in the chip driver.

This gets called once per bus so the code to wake up the chip could be put here.


int ddcmon_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, ddcmon_detect);
}


But now I don't know enough about i2c to rewrite the following code in generic
terms using the i2c_adapter operations instead of direct IO port actions.

int ddcmon_attach_adapter(struct i2c_adapter *adapter)
{
	.......

//int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8
**out_edid)
//{
	u32 reg = rinfo->i2c[conn-1].ddc_reg;
	u8 *edid = NULL;
	int i, j;

	OUTREG(reg, INREG(reg) & 
			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));

	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
	(void)INREG(reg);

	for (i = 0; i < 3; i++) {
		/* For some old monitors we need the
		 * following process to initialize/stop DDC
		 */
		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
		(void)INREG(reg);
		wait_ms(13);

		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		for (j = 0; j < 5; j++) {
			wait_ms(10);
			if (INREG(reg) & VGA_DDC_CLK_INPUT)
				break;
		}
		if (j = 5)
			continue;

		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
		(void)INREG(reg);
		wait_ms(15);
		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
		(void)INREG(reg);
		wait_ms(15);
		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
		(void)INREG(reg);
		wait_ms(15);

		/* Do the real work */
		ret = i2c_detect(adapter, &addr_data, ddcmon_detect);

		OUTREG(reg, INREG(reg) | 
				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		wait_ms(15);
		
		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		for (j = 0; j < 10; j++) {
			wait_ms(10);
			if (INREG(reg) & VGA_DDC_CLK_INPUT)
				break;
		}

		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
		(void)INREG(reg);
		wait_ms(15);
		OUTREG(reg, INREG(reg) |
				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		if (ret)
			break;
	}
	return ret;
}



==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools
