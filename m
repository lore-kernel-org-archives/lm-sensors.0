From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 13 Jun 2012 19:07:35 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <20120613190735.GA15201@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 13, 2012 at 01:59:50PM -0400, Jean Delvare wrote:
> On Wed, 13 Jun 2012 21:52:02 +0530, Sasikanth babu wrote:
> > Yes, as you had mentioned we just backported I2c mux support.
> > I planning to use
> > linux-2.6.39.4.tar.bz2<http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.4.tar.bz2>kernel
> > (Since I cant go to 3.x kernels for now).
> > Is that version is fine with I2c mux devices or do I have to go with 3.x
> > kernels.?
> 
> 2.6.39.4 should work fine with regards to i2c muxing, however this
> branch is already out of maintenance while the 3.0 branch is a longterm
> branch so it will be maintained for some more time (not sure exactly
> how long though.) So if 3.0 is an option, you should consider it seriously.
> 
I definitely agree, but that smells like large company process to me.
Sasikanth may not have much of a choice.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
