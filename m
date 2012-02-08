From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 16:33:27 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <1328718807.2261.316.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-08 at 11:16 -0500, Jean Delvare wrote:
> On Wed, 8 Feb 2012 08:06:58 -0800, Guenter Roeck wrote:
> > Would it be worthwhile trying to track this down further ? 4.4.6 is the latest gcc
> > version from the 4.4 series, so the problem might bite us again.
> 
> I'd suggest that Patrick reports the problem to the maintainer of the
> gcc package in his distribution. Who knows what local patches they may
> have applied? If that doesn't help then the next step would be to
> reproduce the problem with upstream gcc 4.4.6. If the bug is still
> there, try upstream 4.4.5, etc. If this is a regression in the gcc 4.4
> branch, and you can give the exact version it happened in, upstream
> developers will certainly listen.
> 
Agreed, that might be the best approach.

Patrick, where do you get the 4.4.6 compiler from ? Is it from debian or
from a different distribution ? Do you know the exact package version
(the latest debian version is 4.4.6-14, for example) ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
