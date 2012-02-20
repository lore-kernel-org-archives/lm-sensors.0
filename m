From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 20 Feb 2012 16:43:09 +0000
Subject: Re: [lm-sensors] questions about lm-sensors development
Message-Id: <20120220164309.GA10474@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F34E2D5.6080900@gmail.com>
In-Reply-To: <4F34E2D5.6080900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 03:28:14PM -0500, Nikolaus Schulz wrote:
> On Fri, Feb 10, 2012 at 06:47:18AM -0800, Guenter Roeck wrote:
> > I have two kernel repositories, one on kernel.org, one on github. The latter is
> > a shadow of the first. The repository on kernel.org is used to send pull requests
> > upstream, and to serve as feed for the -next tree.
> > 
> > There are three branches:
> > 	hwmon, for bug fixes
> > 	hwmon-next, for patches queued up for the next version
> > 	hwmon-staging, for patches not ready for upstream submission
> > 
> > Also, there may be a signed tag named hwmon-for-linus, which is used to reference
> > pull requests.
> 
> Excellent, so I guess this[1] is the repository to prepare patches for,
> right?
> 
Or use the top of Linus' tree. Right now - since there are lots of cleanup patches pending - 
the top of th hwmon-next branch of my repository may be a good choice.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
