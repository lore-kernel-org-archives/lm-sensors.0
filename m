From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Allow it87 pwm reconfiguration
Message-Id: <20050119232312.GB5909@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050113232904.GC2458@kroah.com> <g7Idbr9m.1105713630.9207120.khali@localhost> <20050115163045.2e636632.khali@linux-fr.org>
In-Reply-To: <20050115163045.2e636632.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Simone Piunno <pioppo@ferrara.linux.it>, Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net

On Sat, Jan 15, 2005 at 04:30:45PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > As soon as you will have confirmed that everything worked as expected,
> > Jonas and I will provide a patch adding a pwm polarity reconfiguration
> > module parameter for you to test. This should give you access to the
> > PWM features of your it87 chip again, but in a safe way for a change
> > ;)
> 
> Here comes this patch. The new "fix_pwm_polarity" module parameter
> allows one to force the it87 chip reconfiguration. This is only
> supported in the case the original PWM configuration is suspected to be
> bogus, and only if we think that reconfiguring the chip is safe.
> 
> I wish to thank Rudolf Marek and Jonas Munsin again for their testing
> and review of my code.
> 
> Greg, please apply, thanks.

Applied, thanks.

greg k-h
