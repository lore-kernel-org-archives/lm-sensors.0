From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 25 Sep 2007 09:24:53 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc6] lm75: new-style i2c binding,
Message-Id: <20070925112453.0eb2d87f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070916234519.861D3C24EE@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 24 Sep 2007 13:18:39 -0700, David Brownell wrote:
> > This is crying for at least two separate patches, and ideally more like
> > 3 or 4.
> 
> I was fairly sure someone was going to say that.  I take it that
> there's no real technical comment on the changes though?

No. Take it that I did not review the patch, so I have no clue if it is
good or not. The whole point of asking for split patches is to make the
review easier so that it actually happens.

> > Additionally, I can't apply your patch to my tree. Presumably you are
> > missing recent patches that went into Mark's hwmon-testing tree and
> > which affect the lm75 driver:
> 
> The location of that tree seems to be hidden.  I did find a GIT
> tree of Mark's, but it didn't have any lm75 changes.

MAINTAINERS says:

T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git

It indeed doesn't mention the testing branch, while this is the
interesting one. Mark, is there something that can be done to improve
the situation?

> > If you split your patch and make sure that the result applies on top of
> > the above patches, I'll be happy to review and test your work.
> 
> I'll split it out a bit then.

Great, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
