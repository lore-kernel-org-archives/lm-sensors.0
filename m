From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Oct 2005 23:43:18 +0000
Subject: [lm-sensors]
Message-Id: <20051027234410.301fb8c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mauro,

> > But we are removing this file, as it's just not needed.  Why would you
> > add more ids to it?
>
> We had included some newer IDs on our old media/id.h for some newer
> drivers during development on V4L tree, that should also be moved to
> linux/i2c-id.h, before removing media/id.h.
>
> I'm working on this patch already. After it, we will stop using the old
> media/id.h, using linux/i2c-id.h instead.

OK, Greg and I have agreed that we would drop my patch and let you do
something similar on your side instead. This should be easier for you
that way.

Thanks,
-- 
Jean Delvare
