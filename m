From: juergh@gmail.com (Juerg Haefliger)
Date: Fri, 26 May 2006 09:37:14 +0000
Subject: [lm-sensors] vt1211 patch
Message-Id: <191fb4ca0605260237h31b99680u2c882c10368c85a0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
In-Reply-To: <191fb4ca0605250754y4ffe117fucd52fc2c5b37369a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Let's see if I can remember (I currently don't have access to the
> datasheets). Try the following:
> cat pwmX (should return 255)
> echo 2 > pwmX_enable
> echo 100 > pwmX_auto_point4_temp

Just realized that the temps are in millicelcius so the last line
should read something like:
echo 300000 > pwmX_auto_point4_temp
The value written just needs to be large enough to saturate the
register at 255 (it gets divided by 1000 in the driver before being
written to the reg).

I can give it a try on my machine next week earliest when I have
access to it again.

...juerg

