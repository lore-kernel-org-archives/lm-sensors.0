From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 17 Nov 2008 21:56:32 +0000
Subject: Re: [lm-sensors] ipmisensors to use or not to use?
Message-Id: <20081117215632.GC8800@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <4918C638.7010202@anduras.de>
In-Reply-To: <4918C638.7010202@anduras.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 17, 2008 at 06:05:30PM +0100, Sven Anders wrote:
> 
> Hmm?!
> Does nobody know or is nobody willing to answer?
> 
> I'm thinking of updating the patch for newer kernel, but
> as my time is limited, I would only do this, if it's the
> right way and it has a chance to be integrated in the
> kernel.

As I recall, the driver needs to be ported to 2.6.28-rc.  Both it and
ibmpex try to call hwmon_device_register on the bmc device, which causes
problems if someone tries to load both.  I think there was a
general unease with putting it in without some more code review.  The
author doesn't seem to be pushing for its inclusion.  If nothing else, I
did a quick port to 2.6.28-rc5 and it miscategorizes a power meter as a
current sensor and the fan RPM sensors totally don't work.  I might be
able to clean it up a bit and then maybe we can push it into the
scary-upcoming-drivers tree?

Not to mention the usual "just use ipmitool" argument. :)

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
