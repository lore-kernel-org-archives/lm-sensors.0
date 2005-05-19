From: adaplas@hotpop.com (Antonino A. Daplas)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <200503171913.59310.adaplas@hotpop.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 17 March 2005 00:37, Jean Delvare wrote:
> Hi Tony,
>
> > I've only seen the savage bug report.  Yes, unfortunately, this is the
> > case of 2 drivers attempting to control a single device since the
> > savagefb and the i2c prosavage drivers will attempt to ioremap the
> > same mmio region. If you need the i2c prosavage bus, then savagefb
> > must be completely disabled, as setting CONFIG_FB_SAVAGE_I2C to n will
> > not help.  If both savagefb and i2c are needed, then you just have to
> > use the i2c bus registered by savagefb.
>
> I understand the problem you describe, and it should certainly be
> addressed by Kconfig dependencies. However, I don't think this is the
> problem here. If you look at the configuration file, you'll see that
> neither i2c-prosavage nor i2c-savage4 are enabled:
>
> # CONFIG_I2C_PROSAVAGE is not set
> # CONFIG_I2C_SAVAGE4 is not set

I was able to also duplicate the bug with eeprom with nividiafb-i2c, and the
bug only appears when running sensors as a regular user, not as root.

I've tracked this to eeprom_read in drivers/i2c/chips/eeprom. I don't know
exactly what happens but commenting out this part in eeprom_read():

	if (data->nature = VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
#if 0
		int in_row1 = 16 - off;
		memset(buf, 0, in_row1);
		if (count - in_row1 > 0)
			memcpy(buf + in_row1, &data->data[16], count - in_row1);
#endif

at least, prevents the hang.

>
> > And yes, there is code duplication, but unfortunately savagefb cannot
> > use the i2c-prosavage bus since one of them will fail to acquire the
> > io regions.
>
> I wonder if the standalone i2c drivers are needed at all anymore, now
> that the framebuffer driver includes the same functionality.
>
> > I haven't seen the nvidiafb report, but it is probably something
> > similar.
>
> Note that there is no i2c bus driver for nvidia graphics adapters in the
> kernel tree. The conflicting driver is rivatv and it lives outside the
> kernel tree.
>
> Miles, are you by any chance using rivatv?

I'll try investigating this also, but can you also try disabling
CONFIG_I2C_NFORCE2?

Tony

