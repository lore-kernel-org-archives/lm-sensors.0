From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Mon, 21 Aug 2006 02:30:17 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
Message-Id: <20060821023017.GA30017@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E8C9AE.3060307@gmail.com>
In-Reply-To: <44E8C9AE.3060307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>

Andrew, Michal:

* Michal Piotrowski <michal.k.k.piotrowski at gmail.com> [2006-08-20 22:44:30 +0200]:
> This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.
> 
> w83627hf.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 80 insertions(+), 16 deletions(-)

Thanks for doing this... but Andrew please don't apply it.  The sensors project
people are working on these even now, and we already have a patch for the
w83627hf driver...

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html

Jean Delvare (hwmon maintainer) should be sending these up the chain soon.

Michal: if you're interested in fixing any of the rest of them, please take
a look at the patch above to see the mechanism we intend to use.  It actually
makes the drivers *smaller* than they were.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


