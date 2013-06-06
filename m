From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Jun 2013 16:55:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Strengthen chip detection for LM84 and MAX1617
Message-Id: <20130606165512.GA30187@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Jun 06, 2013 at 03:51:40PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 6 Jun 2013 04:40:13 -0700, Guenter Roeck wrote:
> > On Thu, Jun 06, 2013 at 09:41:06AM +0200, Jean Delvare wrote:
> > > Detection of the MAX1617 is weak by nature, I don't think there's much
> > > we can do about it. Even the extra checks you picked from
> > > sensors-detect are only heuristics and could theoretically lead to
> > > missed detections. But I think the only alternative is to drop
> > > detection of these chips altogether - which I'd rather avoid. Missed detections can always be fixed 
> > 
> > Yes, I agree. I requested samples for MAX1617 and LM84; once I get them
> > I'll try to improve detection a bit more.
> 
> I have just sent you two MAX1617 dumps. I don't have any for the LM84,
> unfortunately.
> 
Thanks, that helps.

> > > > +	else {
> > > > +		int lte, rte, lhi, rhi, llo;
> > > > +
> > > > +		/* extra checks for LM84 and MAX1617 to avoid misdetections */
> > > > +
> > > > +		lte = i2c_smbus_read_byte_data(client, 0x00);
> > > > +		rte = i2c_smbus_read_byte_data(client, 0x01);
> > > > +		lhi = i2c_smbus_read_byte_data(client, 0x05);
> > > > +		rhi = i2c_smbus_read_byte_data(client, 0x07);
> > > > +		llo = i2c_smbus_read_byte_data(client, 0x06);
> > > 
> > > The sensors-detect code also reads rlo from 0x08, why don't you? I
> > > think we should have the exact same detection logic in sensors-detect
> > > and the adm1021 driver. If you are worried by performance then you can
> > > swap the order of the tests and check for negative temperatures first,
> > > that can be done one or two registers at a time.
> > 
> > More because I don't know what the LM84 returns when reading it, as it is a
> > write-only register there. Any idea what LM84 returns ? Or I can wait until I
> > get the samples.
> 
> Write-only? The LM84 datasheet I have here says there is no register at
> 0x08 at all. It says the same for 0x06, BTW, which you are reading from
> nevertheless.
> 
Me talking nonsense. That was register 0x09 and MAX1617. I need more sleep :(.

> I have no idea what the LM84 returns for these, but as long as this
> doesn't crash the chip, this is irrelevant as far as detection is
> concerned. We read from these to find out if we have a reason to
> believe the chip being probed is _not_ an LM84 nor MAX1617.
> 
> Note that the LM84 also doesn't have registers at 0xFE and 0xFF, still
> the detection function reads from these, apparently without trouble.
> 
We don't really check if the reads return an error, though. 

> As far as I can see the driver is unconditionally reading from
> registers 0x06 and 0x08 in adm1021_update_device() and exposing the
> temp1_min and temp2_min in sysfs. That would be a bug for the LM84,
> right?
> 
Yes. Maybe I'll fix it after I get samples.

> > (...)
> > Would it be useful to add word reads when checking LM84 and MAX1617 ?
> > Those would help detecting chips with word size registers in the
> > checked register locations.
> 
> I would avoid word reads, they can have nasty effects on some chips.
> And the chips supported by the adm1021 driver don't even need word
> reads so you have no guarantee that the underlying I2C/SMBUS controller
> driver supports that.
> 
Ok.

Would it be acceptable to check if reading 0xfe and 0xff return an error ?
That would help weeding out some chips (the JC42 chips on our board return
an error when reading register 0x08, for example).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
