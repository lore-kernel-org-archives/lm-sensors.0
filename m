From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jan 2012 18:56:14 +0000
Subject: Re: [lm-sensors] [PATCH 34/39] hwmon: (w83781d) Fix checkpatch issues
Message-Id: <20120119195614.33d0b76d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-35-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-35-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Jan 2012 10:11:33 -0800, Guenter Roeck wrote:
> On Thu, 2012-01-19 at 11:31 -0500, Jean Delvare wrote:
> > On Thu, 19 Jan 2012 08:23:50 -0800, Guenter Roeck wrote:
> > > Good point. I did wonder about that. I thought it would be a lot of work
> > > to fix the comments. so I didn't even try. I'll see if I can come up
> > > with a script to automate it. If so, I'll submit a separate series of
> > > patches to address it for all drivers.
> > 
> > I'd have a less ambitious approach and simply fix the comment style if
> > you were going to update the comment in question already. But up to you.
> > 
> Turned out the script was easy to write. Only problem with the result is
> that it modified 82 files (out of 117). Only remaining question is if I
> should go forward with it. Thoughts ?

I wouldn't bother but really it's your time, not mine ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
