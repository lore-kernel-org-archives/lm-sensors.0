From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH 2.6] Rename hardware monitoring I2C class
Message-Id: <20040511204415.GA23991@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <409923F7.7050101@convergence.de> <20040506213455.29154c51.khali@linux-fr.org> <20040509174820.5bc47686.khali@linux-fr.org>
In-Reply-To: <20040509174820.5bc47686.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Cc: Michael Hunold <hunold@convergence.de>

On Sun, May 09, 2004 at 05:48:20PM +0200, Jean Delvare wrote:
> Hi Greg, all,
> 
> Quoting myself:
> 
> > Mmm, I once proposed that I2C_ADAP_CLASS_SMBUS would be better renamed
> > I2C_ADAP_CLASS_SENSORS (so I2C_CLASS_SENSORS now). What about that? I
> > think it would be great to embed that change into your patch, so that
> > the name changes only once.
> > 
> > BTW, if HWMON is prefered to SENSORS, this is fine with me too, I
> > have no strong preference.
> 
> Below is a patch that does that. I finally went for HWMON. Yes, it's
> big, but it's actually nothing more than
> s/I2C_CLASS_SMBUS/I2C_CLASS_HWMON/ (thanks perl -wip :)).
> 
> Greg, can you please apply it on top of Michael's patch?

Applied, thanks.

greg k-h
