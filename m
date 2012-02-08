From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 16:21:18 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208162118.GB21537@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 08, 2012 at 09:59:16AM -0500, David Kremer wrote:
> On 08/02/2012 15:49, Guenter Roeck wrote:
> > Ubuntu 11.10 is not a LTS release. [...] There seems to be
> > some magic in deciding which kernel releases are going to be LTS, my
> > predictions usually turn out to be wrong, and I gave up trying.
> The 3.0 branch is flagged as a LTS version in archlinux. Knowing their 
> way to do thing and to prefer vanilla packages, the 3.0 kernel is a long 
> term support version I guess (at least only candidate for bug fixes and 
> security patches).
> 
> For the ubuntu version, you are probably right, and one shouldn't care 
> about ubuntu in particular I guess. But as it concerns the LTS support, 
> it could be nice if hwmon drivers could be stable and not broken at each 
> security and bugfixes update of the kernel. As well, I wonder if you 
> plan to follow this new development guideline.
> 
In general we do, yes. Is there any indication or evidence to the contrary ?
If so, please let us know. We are not perfect, and we may miss something
once in a while, but we try. And if we do in fact miss something, feedback
from others is always welcome.

As it looks like, though, this specific problem may be a compiler bug.
Not sure if/how we can address that kind of problem in the affected driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
