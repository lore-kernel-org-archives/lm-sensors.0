From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Sep 2006 18:40:25 +0000
Subject: [lm-sensors] [GIT PATCH] HWMon patches for 2.6.18
Message-Id: <20060929204025.9bbad04b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060928224248.GA23843@kroah.com>
In-Reply-To: <20060928224248.GA23843@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

> Here are some hwmon patches for 2.6.18.  They include a new driver, and
> a bunch of warning fixes that cleaned up the code a lot.

Two new drivers, actually (vt1211 and k8temp.)

> Half of these have been in the -mm tree for a while, the other half were
> in Jean's tree for too long before I added them to mine (the delay was
> my fault.)

I checked against my patch stack and everything's in order. Thanks Greg!

-- 
Jean Delvare

