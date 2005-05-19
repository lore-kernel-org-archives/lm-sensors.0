From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Winbond W83792D driver
Message-Id: <61DqK9WE.1113204386.6869130.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> > 6* The code does *not* properly handle the case where subclients are
> > disabled. If subclients addresses are forced, they will be forcibly
> > enabled (this is OK). If they are not forced, then we might register
> > clients which do not exist (this is NOT OK).
>
> Then how should I handle the case where subclients are disabled?

You should skip the call to i2c_attach_client for disabled subclients
(they will most likely fail anyway).

Note that you will probably face a problem on the client unregistering
front with your current approach of having a single malloc for both
subclient structures. You might consider the approach used in the asb100
and w83781d drivers (in 2.6) instead: have a separate pointer for each
subclient, and one malloc for each.

> > [I'd have a side question, about the subclients in general...
> > Why do we register subclients addresses at all? We could instead
> > forcibly disable them. This is easier and just as efficient (disabling
> > the addresses doesn't disable the temperature channels themselves).]
>
> Yes, maybe you are right, but I think your this question is to the other
> members of lm_sensors group, Am I right? You need a discussion with them,
> because I'm not very familiar with the subclients.

Absolutely, this should be discussed collectively. We are in no hurry.
For your driver, just stick to what the other drivers do for now.

Thanks,
--
Jean Delvare
