From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Apr 2010 12:01:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4245) Read GPIO registers
Message-Id: <20100413140142.4533d597@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225704.GF20635@ovro.caltech.edu>
In-Reply-To: <20100330225704.GF20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oh, and I forgot:

On Mon, 5 Apr 2010 11:41:14 -0700, Ira W. Snyder wrote:
> What about returning -EINVAL for stale values?

EINVAL is for invalid input, so it's hardly appropriate there. EAGAIN
(try again later) would seem better.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
