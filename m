From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: max1619
Message-Id: <20040523152124.5777a192.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405211303.18083.fishor@gmx.net>
In-Reply-To: <200405211303.18083.fishor@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

> I mean, i don't know C at all, i jas wont to lern it and it will be
> greate if you have and can send me  some DOC about C.

Sorry, I don't have such docs. I leant C partly in high school, but
mostly by reading existing code and discussing with people.

Frankly, if you never did C before and were already able to adapt driver
code to write your own driver, it's impressive. Keep it this way :)

> > You forgot to cgecj trhe conversion rate register . It has to be <> > 0x07. You could use the status register as well, for which reg &
> > 0x61 should be 0.
> 
> Hear i'm not sure what you mean

Maybe because I completely mispelled my first sentence and didn't even
notice it? ;)

> if ((reg_config & 0x2A) != 0x00  || reg_convrate <= 0x07 ||
> (reg_status & 0x61) != 0x00)
> 
> is it corect ?

Note quite. I'd say:

if ((reg_config & 0x03) != 0x00  || reg_convrate > 0x07
 || (reg_status & 0x61) != 0x00)

> > +	config = i2c_smbus_read_byte_data(client, MAX1619_REG_R_CONFIG);
> > +	if (config & 0x40)
> > +		i2c_smbus_write_byte_data(client, MAX1619_REG_W_CONFIG,
> > +			config & 0x0C); /* run */
> > +}
> >
> > This doesn't preserve configuration bits. You should write back
> > config & 0xBF.
>
> I can't yus 0xbf wile it bringing up OVERT output, it's mean HYST and
> CRIT can't do any think. For max1619   0x9f , this preserve and
> doesn't have OVERT bit.

Negative. Masking with 0xBF will *not* set bit 5 (POL). It will keep it
exactly the way it was. So, if the BIOS has changed that bit to match the
hardware setup, it won't be dropped.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
