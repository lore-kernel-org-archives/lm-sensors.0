From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] ALI1563 SMBus driver fix
Message-Id: <4xzba7yn.1113379198.5811460.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> > > +	/* device error - probably missing ACK, from autdetection I2C_QUICK
> > >   */
> > > +	if (data & HST_STS_DEVERR) {
> > > +		dev_dbg(&a->dev, "Device error!\n");
> > > +	}
> > I don't like this. If this "error" is normal for I2C_QUICK, then don't
> > issue any message and return 0 in this case, and issue an *error*, not
> > debug, message in the other cases.
>
> Yes this will happen when no-one will respond to I2C_QUICK. If we would
> return 0; then i2cdetect would have detected all devices as "present"???
> (Or am I missing something? Its quite late here...When someting will
> respond to I2C QUICK we would leave the routine more to the top)

Ah, OK, *I* missed something then. I thought that the "error" was
expected on  any I2C_QUICK command, not just un-acked ones. So the
returned value is indeed just fine.

Still, wouldn't it be better to have dev_dbg only in the case of
I2C_QUICK, and dev_warn or even dev_err otherwise? The way things are
done for now, most errors are likely to be unnoticed unless debug mode
is enabled,


> > As far as I can see, this means adding a second parameter to
> > ali1563_transaction, but I don't think this is a problem.
>
> Please can you explain more? Or tomorrow on IRC if you want...

For now, you have no way (that I can see) in ali1563_transaction() to
know what kind of SMBus command is done. If you want to be able to
handle I2C_QUICK errors differently from other commands errors, you will
have to pass it to that function as an extra argument, unless I'm
missing something again.

> I will remove all noise in future revisions of this patch.

Thanks.

> Funny is that I could not take a look to book :)

That's not exactly funny :(

--
Jean Delvare
