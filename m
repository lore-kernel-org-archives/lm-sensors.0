From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 19 May 2011 08:42:49 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] staging:iio:adc:as1351 general cleanup
Message-Id: <4DD4D809.5060308@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305733172-18519-1-git-send-email-jic23@cam.ac.uk> <1305735420-23293-3-git-send-email-jic23@cam.ac.uk> <20110518163508.GA11675@ericsson.com>
In-Reply-To: <20110518163508.GA11675@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "fabien.marteau@armadeus.com" <fabien.marteau@armadeus.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 05/18/11 17:35, Guenter Roeck wrote:
> On Wed, May 18, 2011 at 12:17:00PM -0400, Jonathan Cameron wrote:
>> V2: Fix the precedence issue Guenter Roeck pointed out.
>>
> Should be below ---, unless you want it in the commit log.
> 
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> Nitpick below, otherwise
> 
> Reviewed-by: Guenter Roeck <guenter.roeck@ericsson.com>
Thanks,

Fixed up as suggested.  I'll wait for Fabien's test results
before doing any more with this driver.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
