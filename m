From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Jun 2005 11:23:38 +0000
Subject: [lm-sensors] Re: RFC PATCH I2C: w83781d: remove non-i2c sensor
Message-Id: <7zH6hRAX.1118049250.3073960.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <bulu915hhnr8oj5orjq2p5i53ublc3b6gu@4ax.com>
In-Reply-To: <bulu915hhnr8oj5orjq2p5i53ublc3b6gu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> > Great, except for:
> >
> > > -	}
> > > -
> > > +
> >
> > Please avoid this "noise" change (same holds for all future patches, of
> > course).
>
> Fine, I'll wait until your CodingStyle patches go through, as twice now
> I've been told by you to violate CodingStyle.  Understanding yet to dawn
> as to why this is so.

Can you please point me to the exact rule you think I told you to
violate? I don't think I really did.

What you were doing here is fix coding style while the main point of your
patch was to remove a deprecated feature. As per
Documentation/SubmittingPatches section 3, these changes should be sent
as two different patches. Doing so eases the work of all reviewers and
maintainers up the chain, and is all I was asking for.

Thanks,
--
Jean Delvare
