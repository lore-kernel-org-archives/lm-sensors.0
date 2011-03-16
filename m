From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 21:30:35 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: Skip limit slots to align
Message-Id: <20110316223035.1242c8dc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316212102.2ef183f0@endymion.delvare>
In-Reply-To: <20110316212102.2ef183f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 16 Mar 2011 13:47:52 -0700, Guenter Roeck wrote:
> On Wed, 2011-03-16 at 16:21 -0400, Jean Delvare wrote:
> > Ensure that hysteresis and the limit it relates to are always
> > printed on the same line.
> > ---
> > Guenter, this is what I had in mind. Makes the code slightly more
> > complex, but the result seems worth it. What do you think?
>
> Looks a bit kludgy to me,

Yeah, I am not particularly impressed either, but my alternative
attempts were rather worse.

> but it works, and at least right now I have no
> idea how to make it better. So go ahead.

Thanks, I'll commit it now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
