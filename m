From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Dec 2010 15:32:27 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (dme1737): cleanups
Message-Id: <20101216153227.GA7943@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimTbiT_swuiyaHP9rLmN2iUfqPyu_gfq16QY-zv@mail.gmail.com>
In-Reply-To: <AANLkTimTbiT_swuiyaHP9rLmN2iUfqPyu_gfq16QY-zv@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 16, 2010 at 05:21:40AM -0500, Juerg Haefliger wrote:
> Minor cleanups. Mostly removing assignments in if statements to get
> rid of checkpatch errors.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Just wondering ... did you run this patch through checkpatch ? 
I did, and got 11 warnings for the unnecessary use of { }.

Not sure if getting rid of checkpatch errors is worth it if you just
replace the errors with warnings.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
