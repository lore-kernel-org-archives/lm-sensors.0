From: Lucas Stach <dev@lynxeye.de>
Date: Tue, 03 Jan 2012 11:55:44 +0000
Subject: Re: [lm-sensors] add new hwmon-core interface v4
Message-Id: <1325591744.1660.1.camel@antimon>
List-Id: <lm-sensors.vger.kernel.org>
References: <1323378601-6930-1-git-send-email-dev@lynxeye.de>
In-Reply-To: <1323378601-6930-1-git-send-email-dev@lynxeye.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ping.

Did this got lost in the mailing list churn?

Thanks,
Lucas

Am Donnerstag, den 08.12.2011, 22:09 +0100 schrieb Lucas Stach:
> After a long break here comes v4 of the hwmon-core patchset. It
> incorporates many of the suggested changes, in particular the
> core is more flexible (different features for every sensor and holes
> in numbering allowed) and adds support for 2 dimensional indexed
> attributes like trip points and thresholds.
> 
> This time the dummy driver was removed from the patchset and a
> real hwmon driver (adt7475) was converted to the new interface. The
> converted driver was tested on a adt7473, but with a very limited
> featureset.
> 
> I'm looking forward to your comments and reviews. I would also
> appreciate some testing for the adt7475 driver.
> 
> Thanks,
> Lucas
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
