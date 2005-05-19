From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <20050323203226.1125f333.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> I'm thinking that there is a very small window between reading 
> a register, modifying some bits and writing it back out, where 
> another process also does it.  Say SMP and one CPU update fan_div1
> while other update fan_div2 -- adm1026 has eight of these over 
> two bytes to potentially interfere with each other.  

Correct, you convinced me.

> But if the update request event stream is serialised by sysfs 
> or elsewhere on its way to the driver then there is no problem.

No, it isn't.

> If the i2c bus driver rate limits write traffic to bus, then 
> again there is no issue.  I simply do not know.  I ask to learn.

The bus driver doesn't limit the traffic, it only makes sure that no
more than one transfer happens at any given time. This alone doesn't
cover the case above, as register modifications consists in two separate
messages, and another message can slip inbetween.

Thanks,
-- 
Jean Delvare
