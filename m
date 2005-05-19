From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <41DAF175.7060509@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> The first test proves that the values are read and written properly, so
> the only problem here is the default value, which is either set by your
> BIOS or not set at all. There's not much lm_sensors could have done bad.

That still does not explain why it worked in 2.8.8. ;-)

> Can you check in sensors.conf if you explicitely set the fan clock
> dividers to 8? I think that the default is 2. Maybe the divider change
> affected the min value in an unexpected way.

Sorry, I don't understand. What exactly should I do?

> Also, you said that previous versions of lm_sensors would yield a
> different default min value. What was that value? What was the value of
> the dividers?

Unfortunately, I don't know, I don't have a system with the old version 
ready. :-( I never changed anything in sensors.conf, so the default 
values from older versions were there.

Thanks
Florian
