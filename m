From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Don't handle kind errors that cannot happen
Message-Id: <20040315223027.4ff338fd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313185302.6955c4a9.khali@linux-fr.org>
In-Reply-To: <20040313185302.6955c4a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Note: What kind of error should the detection function return when
> > the user forces the driver, but the driver doesn't agree to load?
> > Some of our drivers return -EINVAL (e.g. w83781d), some -ENODEV
> > (e.g. asb100, lm78), some return without an error (e.g. it87). I
> > think we should decide of a policy and stick to it.
> 
> Why would the driver not agree to load?  It should always load, but
> just not bind to a device, right?

Correct, I misexpressed myself, sorry.  You got it right.

> Anyway, -ENODEV is a good error, as the device isn't there, or can't
> be found.

I was wondering, since the failure is actually caused by the conjunction
of two things: the user forcing the driver and the device not being
there.  I was thinking of someting like -(EINVAL|ENODEV) but I think it
won't work as expected ;)  So we should change all the drivers to comply
with this.  I'll do that someday, unless anyone volunteers...

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
