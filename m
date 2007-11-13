From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Nov 2007 21:05:30 +0000
Subject: Re: [lm-sensors] [GIT PATCH] hwmon updates against v2.6.24-rc2
Message-Id: <20071113220530.6a2c7b8b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071014192953.GA9122@jupiter.solarsys.private>
In-Reply-To: <20071014192953.GA9122@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Off-list on purpose...

On Tue, 13 Nov 2007 08:12:10 -0500, Mark M. Hoffman wrote:
> Jim Cromie (2):
>       hwmon: (w83627hf) hoist nr-1 offset out of show-store-temp-X
>       hwmon: (w83627hf) push nr+1 offset into *_REG_FAN macros and simplify

Definitely not the kind of patches I would have sent at this point of
the release cycle. As a user, I'd rather not see large, intrusive
cleanups go in the tree after -rc2.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
