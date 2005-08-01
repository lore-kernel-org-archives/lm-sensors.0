From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 01 Aug 2005 21:29:21 +0000
Subject: [lm-sensors] Re: [PATCH] i2c-algo-pca -- gracefully handle a busy
Message-Id: <20050801212820.575dbc21.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122633085.19718.106.camel@icampbell-debian>
In-Reply-To: <1122633085.19718.106.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

> Sure thing. Fixed patch is below.
> 
> I've been running with this patch for a while now, and while I've
> never seen it trigger except with buggy hardware I think it is a
> cleaner way to handle a busy bus. I had -EBUSY until about 10 minutes
> ago but -EIO seems to be what most of the existing algo drivers will
> return in the same circumstances.

Looks good to me, applied, thanks.

-- 
Jean Delvare
