From: Mark Brown <broonie@sirena.org.uk>
Date: Wed, 15 Jul 2009 20:37:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware	monitoring
Message-Id: <20090715203722.GB30563@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090715202744.GA30563@sirena.org.uk>
In-Reply-To: <20090715202744.GA30563@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 15, 2009 at 10:32:02PM +0200, Jean Delvare wrote:
> On Wed, 15 Jul 2009 21:27:44 +0100, Mark Brown wrote:

> > Is there someone else I should send hwmon stuff to instead if you don't
> > normally review this?  There is no entry in MAINTAINERS.

> You'd send the patch to the list and hope that someone will pick it and
> review it. But chances are thin. Other possibilities are finding
> someone else interested in support for that specific chip and have
> him/her review and test your driver. Then usually Andrew Morton can
> pick the patch and push it upstream.

In this case (if you find you don't have time after all) Samuel Ortiz
might be a likely victim as MFD maintainer.  Thanks, I'll bear that in
mind in future.

> Or you can volunteer to be the new hwmon subsystem maintainer and send
> the patch to Linus yourself ;)

Heh.  Sadly the devices I'm working with are nowhere near being able to
get any kind of coverage of the API but nice try :)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
