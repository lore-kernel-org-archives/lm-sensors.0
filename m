From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040801111012.1f2b7880.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> BTW, I think that there's still something broken in the 2.4 smsc47m1
> driver. If I read the datasheets correctly, pwm_enable currently does
> what you tell it not to do, ie: 1 will force fan to full speed while 0
> will enable PWM.

I did the change, hope it was correct.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
