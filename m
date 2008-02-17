From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 17 Feb 2008 17:20:12 +0000
Subject: Re: [lm-sensors] [PATCH 14/27] hwmon: fix section mismatch in
Message-Id: <20080217172012.GA13440@uranus.ravnborg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080217121255.GA10519@uranus.ravnborg.org> <1203250984-11285-14-git-send-email-sam@ravnborg.org> <20080217170708.GB2916@jupiter.solarsys.private>
In-Reply-To: <20080217170708.GB2916@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, lm-sensors <lm-sensors@lm-sensors.org>

> 
> This rings a bell... hmmm, commit 59a35bafb223bbb0553ba1a3bb9280bda668a8d8.
> AFAICT the warning is a false positive, but whatever.

Yes it is - the __refdata is there only to silence modpost.

> 
> Applied to hwmon-2.6.git/testing, thanks.

Thanks,

	Sam

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
