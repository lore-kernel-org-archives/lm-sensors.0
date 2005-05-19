From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 2/2] i2c: kill some sensors driver macro abuse
Message-Id: <20040923115736.M73696@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040923041719.GH4256@jupiter.solarsys.private>
In-Reply-To: <20040923041719.GH4256@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Sep 2004 00:17:19 -0400, Mark M. Hoffman wrote
> This patch kills a specific kind of ugly and ultimately useless macro
> abuse found in many sensors chip drivers.  Compile tested only.

This is great. I have always wondered why these were used. They don't even
seem to make any sense, and I am happy to see them gone.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
