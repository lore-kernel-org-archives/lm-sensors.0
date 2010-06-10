From: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 10 Jun 2010 09:16:01 +0000
Subject: Re: [lm-sensors] [PATCH] fix hwmon/i5k_amb.c sysfs attribute for
Message-Id: <alpine.LNX.2.00.1006101115230.12271@pobox.suse.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100609140000.60975b2f.kamezawa.hiroyu@jp.fujitsu.com> <20100609110719.270634a9@hyperion.delvare>
In-Reply-To: <20100609110719.270634a9@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, mingo@redhat.com, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Eric W.Biederman" <ebiederm@xmission.com>

On Wed, 9 Jun 2010, Jean Delvare wrote:

> On Wed, 9 Jun 2010 14:00:00 +0900, KAMEZAWA Hiroyuki wrote:
> > I'm not familiar with this area but I need this patch for lockdep in mmotm.
> > please check.
> > -Kame
> > =
> > From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> > 
> > i5k_amb.ko uses dynamically allocated memory (by kmalloc) for
> > attributes passed to sysfs. So, sysfs_attr_init() should be called
> > for working happy with lockdep.
> 
> Such a fix is needed, yes. I though Jiri was working on it... Jiri?

It's still on my TODO list, but I haven't gotten to it yet. So whoever 
beats me up fixing it, please merge that. Thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
