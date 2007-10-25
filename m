From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 25 Oct 2007 02:25:29 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071025022529.GF30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de> <20071017204508.GA32110@kos.to> <20071018133744.GC3526@jupiter.solarsys.private> <20071019143754.0aa4483b@hyperion.delvare> <20071024115034.GA5797@kos.to>
In-Reply-To: <20071024115034.GA5797@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Jean Delvare <khali@linux-fr.org>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Riku:

* Riku Voipio <riku.voipio@iki.fi> [2007-10-24 14:50:34 +0300]:
> On Fri, Oct 19, 2007 at 02:37:54PM +0200, Jean Delvare wrote:
> > Riku, can you please submit a patch fixing this? The attribute should
> > be declared read-only, and then you can use sysfs_chmod_file() to
> > change it to read-write where supported. 
> 
> Thanks, this was good suggestion. Patch attached.

No patch?

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
