From: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Tue, 15 Nov 2011 02:28:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Fix two issues
Message-Id: <3C06C26914DACA4BB3A368F78CA0B3A712AA61@039-SN1MPN1-004.039d.mgd.msft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Please find my comments in line.

> -----Original Message-----
> > > > SMBus block reads receive the block length as the first byte. 0x10
> > > > = 16, which is the length of the ID for these chips, this is no
> > I didn't write the driver, and don't have the device, but I think the
> > driver is OK as is. The block length (0x10) is handled by the
> > underlying bus driver, the device driver never gets to see it, if you
> > properly call i2c_smbus_read_block_data() as you are supposed to.
> >
> I have eval boards for all chips supported by the driver (lots of kudos
> to Intersil), so the driver was tested and is known to work for all chips
> it currently supports. Intersil told me that they don't update the
> firmware after they released a chip, so we can be sure that the firmware
> version on all chips of the same type is the same, and we don't have to
> look for version specific behavior.
> 
> I agree that we should not replace the SMBus block read with SMBus I2C
> block read. The I2C bus driver should really implement SMBus block read
> command support.
> 
> There are some I2C bus drivers which can not support SMBus block reads
> due to chip limitations, such as the Sibyte driver, but if the driver can
> support SMBus I2C block reads it should possible to support SMBus block
> reads as well. As far as I can see, the only driver supporting SMBUS I2C
> block reads but not SMBUS block reads is scx200_acb. That seems to be an
> oversight (or maybe laziness ;), and should be easy to fix.
> 
[Yuantian:] what platform are you testing on?
What I see is most i2c bus drivers don't support "SMBus block".
I use newest kernel 3.2.

> Thanks,
> Guenter
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
