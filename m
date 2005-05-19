From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: ADM 1025 on 2.6 kernel
Message-Id: <20040707075948.1d94a397.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1084951647.6186.13.camel@powerride>
In-Reply-To: <1084951647.6186.13.camel@powerride>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

> I have just tried the unified linux patch for ADM 1025 and everything
> seems to be working fine.

Great :)

> The VID value is +1.700 V

I guess you were using a recent CVS snapshot of lm_sensors?

Do you know if this is the correct voltage for your CPU? What CPU is it
BTW? Please show /proc/cpuinfo. I would also appreciate the output of
"sensors" itself.

Thanks for testing.

-- 
Jean Delvare
http://khali.linux-fr.org/
