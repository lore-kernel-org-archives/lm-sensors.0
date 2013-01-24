From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Jan 2013 10:10:16 +0000
Subject: Re: [lm-sensors] tap SMBus vis PCI slot?
Message-Id: <20130124111016.303d6f40@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
In-Reply-To: <CAEGEQC+-T34gofYjZyGZ-NQtJK+smUghtbLXx-h5GgMbqO2FVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 24 Jan 2013 11:01:37 +0100, Robert Smith wrote:
> Thanks,
> 
> My motherboard is an Intel DX58SO. I have read the documentation and it
> doesn't mention a header but it does mention that the SMBus is routed to
> the (single) PCI slot.

OK.

> I understood that SMBus is a multi master bus? certainly my plans rely on
> this.
> 
> "SMBus is a two-wire multi-master bus, meaning that more than one device
> capable of controlling the bus
> can be connected to it."
> 
> from section 2 'Characteristics' of:
> 
> http://smbus.org/specs/smbus110.pdf

Ah, my bad, I thought SMBus had stripped off the multimaster capability
of I2C but clearly I'm wrong, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
