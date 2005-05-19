From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <20040513215226.4c6dc871.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tested this. pwmconfig didnt manage to stop any of my fans though.
> It looks like my pwm isnt configured at the hardware level.

FYI, pwmconfig was broken for 2.6 kernels in lm_sensors 2.8.6. It's now
fixed in CVS.

-- 
Jean Delvare
http://khali.linux-fr.org/
