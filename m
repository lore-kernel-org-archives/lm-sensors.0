From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jan 2013 20:33:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (w83627ehf) Use fixed attributes for SYSTIN, CPUTIN, and AUXTIN
Message-Id: <20130116213340.4a783d90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351356061-30514-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351356061-30514-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 16 Jan 2013 08:37:24 -0800, Guenter Roeck wrote:
> On Sat, Oct 27, 2012 at 09:40:59AM -0700, Guenter Roeck wrote:
> > So far the code used dynamic temperature attributes for SYSTIN, CPUTIN, and
> > AUXTIN on NCT6775/NCT6776. That has the disadvantage that the mapping of
> > tempX_type and tempX_offset does not necessarily match reality, and code
> > complexity is increased.
> > 
> > To avoid mapping problems and simplify the code, use fixed mapping instead, and
> > use temp[4-9] for additional temperature sources.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Just noticed another series of pending patches.
> 
> Jean, any comments ?

Not yet and there won't be any from me before at least next week. Patch
reviews are time-consuming and I have a lot of other tasks pending.

> Would be great to find some additional reviewers ...

Amen.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
