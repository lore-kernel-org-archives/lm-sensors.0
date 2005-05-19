From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fscpos upgrade for sensor library
Message-Id: <20050120204659.5e199ee9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050119213747.GB26072@desire.ch>
In-Reply-To: <20050119213747.GB26072@desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Okay, I misunderstood that one. Here's the patch which just adds the
> new features and leaves the old ones alone :)

Thanks, applied with the following changes:

1* No labels for inN_input in sensors.conf. Libsensors is based on the
   2.4 symbol names only.

2* No changed to lib/chips.h. Why define new constants when you don't
   use them anywhere? ;)

-- 
Jean Delvare
http://khali.linux-fr.org/
