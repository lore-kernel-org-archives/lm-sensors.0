From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <20050322224856.6bdad379.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> aargh.  That's a totally different crash :(

Isn't is exactly what would happen in the case I described, i.e.
adapters freed but still in the list? The freed area could be
overwritten randomly, causing crashes at different locations each time
we slightly change the code?

> Were you using this patch?

I think we would spare a significant amount of time if Miles could test
Tony's patch to nvidiafb - unless he already tried and I am not aware?
Miles?

Thanks,
-- 
Jean Delvare
