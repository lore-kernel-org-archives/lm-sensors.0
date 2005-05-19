From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just ported monddc from 2.4 to 2.6 and I attached the source. It implemented a
few DDC decodings but to implement them all you need to add about thirty
attributes.

I'm trying to figure out if a generic DDC module can probe for older DDC
monitors. The radeon framebuffer driver (2.6, drivers/video/aty/radeon_i2c.c)
contains the following code for discovering old DDC chips. 

I see that I can replace the probe function in the monddc driver with this probe
function. But I don't know enough about DDC and I2C to really under what it's
trying to do to the I2C bus. Can this probe function be turned into a generic
form where it uses something like i2c_smbus_xfer() instead of directly playing
with the bus ioports? Does anyone have one of these old monitors that needs this
probe?

I'd like to build one universal DDC module instead of reimplementing this in
every video driver.


int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8
**out_edid)
{
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
		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);

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
		if (edid)
			break;
	}
	if (out_edid)
		*out_edid = edid;
	if (!edid) {
		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
		return MT_NONE;
	}
	if (edid[0x14] & 0x80) {
		/* Fix detection using BIOS tables */
		if (rinfo->is_mobility /*&& conn = ddc_dvi*/ &&
		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
			return MT_LCD;
		} else {
			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
			return MT_DFP;
		}
	}
       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
	return MT_CRT;
}



==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ddcmon.patch
Type: text/x-patch
Size: 11486 bytes
Desc: ddcmon.patch
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040227/e647ba33/ddcmon.bin
