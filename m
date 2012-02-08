From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Feb 2012 16:16:19 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208171619.47589a96@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 8 Feb 2012 08:06:58 -0800, Guenter Roeck wrote:
> Would it be worthwhile trying to track this down further ? 4.4.6 is the latest gcc
> version from the 4.4 series, so the problem might bite us again.

I'd suggest that Patrick reports the problem to the maintainer of the
gcc package in his distribution. Who knows what local patches they may
have applied? If that doesn't help then the next step would be to
reproduce the problem with upstream gcc 4.4.6. If the bug is still
there, try upstream 4.4.5, etc. If this is a regression in the gcc 4.4
branch, and you can give the exact version it happened in, upstream
developers will certainly listen.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
