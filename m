From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <20040512214359.01caa90e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Could it be that the fan is not being driven fast enough by bios/io
> chip settings? Or maybe the CPU fan is just a little flaky. Any ideas?

Both could be. Maybe PWM is enabled at a very low value, and if you can
get PWM to work (see other mail) you may speed your fan up. Doesn't go
in the sense of "making your pc more quiet" as mentioned in your
original mail, but cooler has a higher priority over quiter IMHO.

-- 
Jean Delvare
http://khali.linux-fr.org/
