From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Jun 2006 10:11:45 +0000
Subject: [lm-sensors] PATCH- i2c-iop3xx platform driver avoid addressing
Message-Id: <20060619121145.b386734e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44931779.6050302@d-tacq.com>
In-Reply-To: <44931779.6050302@d-tacq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> > How will the address be reported by i2cdetect? As if there was no chip
> > there, I guess (XX)? 
>
> At zero, comes out as "XX" on the "old" i2cdetect, skipped in the new one.

Just FYI, you can restore the old behavior of scanning all addresses
with the -a flag.

> > I'm a bit worried about this, as someone might
> > then want to use the address for something else without realizing that
> > the address is already in use. Would it be possible to make it so that
> > the address would be reported as busy (UU)? I'm not too sure myself if
> > the i2c-core currently allows this, but I'd like you to investigate in
> > that direction as it might avoid trouble in the future. I guess the
> > only way right now would be to instanciante a fake client at that
> > address.
>
> The routine now returns -EBUSY, but i2cdetect still reports "XX". When I 
> address it with another low level utility, it reports:
> "Device or resource busy" - which is fair enough, the device is busy 
> being a master so it cannot simultaneously be a slave ...

Indeed, the business of an I2C address for the i2c core is solely based
on the fact that a client claimed that address. The exact error value
returned by the transfer function is merely ignored as far as I can see.

> Maybe Intel knew what they were doing when they set 0 as the default 
> slave address.
> Because nobody is going to choose that as a real slave address, are they 
> :-).

Seems so.

> So, are we there with this patch now?

I'm happy with it, except for the lack of heading comment and
signed-off-by line. But I assumed that the ones from the original patch
still applied to this new one, and carried them over :)

-- 
Jean Delvare

