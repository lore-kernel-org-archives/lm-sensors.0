From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 08:51:56 +0000
Subject: Re: [lm-sensors] Winbond W83L786G support
Message-Id: <20071129095156.1422a16a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071128160454.24906.qmail@webmail35.rediffmail.com>
In-Reply-To: <20071128160454.24906.qmail@webmail35.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sagar,

On 28 Nov 2007 16:04:54 -0000, Sagar Borikar wrote:
> I am using Winbond W83L786NG chip in my box and I wanted to test
> it using lm-sensors. I could find the driver patch for this chipe
> supported in 2.6.23-rc4 onwards. But couldn't find the corresponding
> code in lm-sensors. Even lm-sensors-3.0.0 is not having chip
> specific code.Can anyone tell me how this monitor can be tested?

Please read this thread:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/022032.html

lm-sensors 3.0.0 doesn't need have any chip-specific code, so it's no
surprise that you didn't find any W83L786NG-specific code there. It's
per design, now that the sysfs interface is fully standardized. So
please give a try to lm-sensors 3.0.0, it should work. If it doesn't,
please report.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
