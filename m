From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 07:29:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] fam15h_power: Correct sign extension of running_avg_capture
Message-Id: <20120131082921.34143a5f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120120180007.GH24508@alberich.amd.com>
In-Reply-To: <20120120180007.GH24508@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the late reply.

On Mon, 23 Jan 2012 09:33:20 -0800, Guenter Roeck wrote:
> On Fri, 2012-01-20 at 13:00 -0500, Andreas Herrmann wrote:
> > fam15h_power: Correct sign extension of running_avg_capture
> > 
> > Wrong bit was used for sign extension which caused wrong end results.
> > Thanks to Andre for spotting this bug.
> > 
> > Reported-by: Andre Przywara <andre.przywara@amd.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > ---
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Candidate for stable ?

Yes, definitely.

> Jean, let me know if you want to pick up the two patches. I don't have
> anything pending for this driver.

I'll pick them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
