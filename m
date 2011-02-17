From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 17 Feb 2011 16:33:48 +0000
Subject: Re: [lm-sensors] [PATCH] Fix libsensors symbol visibility
Message-Id: <20110217163348.GB19767@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217114931.36b39e02@endymion.delvare>
In-Reply-To: <20110217114931.36b39e02@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 17, 2011 at 05:49:31AM -0500, Jean Delvare wrote:
> From: Cristian Rodriguez <crrodriguez@opensuse.org>
> 
> Only export from libsensors symbols which are actually public (i.e.
> listed in the public header files and documented in the manual page.)
> ---
> It worked fine on the 3 distributions I tested it on (openSUSE 11.3,
> Slackware 12.0 and 9.1, Debian) but I would welcome tests on more
> distributions (including old ones) just to make sure it doesn't break
> anything.

Works for me in Ubuntu 10.4 and 10.10.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
