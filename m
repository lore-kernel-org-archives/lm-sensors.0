From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040202164251.GA20444@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

> > +        /* Comparator mode (D3=0), standby mode (D6=0) */
> > +        gl518_write_value(client, GL518_REG_CONF, 0xb7 & regvalue);
> 
> I'd suggest 0x37 as the mask. D7 is something we don't want to set to 1.
> I agree it doesn't change anything practically. Just looks safer.
> 
ok

> > +        /* Clear status register (D5=1), start (D6=1) */
> > +        gl518_write_value(client, GL518_REG_CONF, 0x20 | regvalue);
> > +        gl518_write_value(client, GL518_REG_CONF, 0x40 | regvalue);
> 
> It works, but isn't correct. At this point, regvalue doesn't hold the
> current configuration register. I suggest we use (regvalue &= 0x37) in
> the first gl518_write_value() call above, so that it does.
> 
There is already regvalue = gl518_read_value() & 0x14; above that,
since regvalue is supposed to only hold values from D6,D3, so there is 
no need to &= 0x37 again.
I don't think we should change this.  Just the 0xb7 to 0x37 above.

Hong-Gunn
