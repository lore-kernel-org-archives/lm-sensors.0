From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 15 Aug 2011 15:39:56 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add caseopen detection to
Message-Id: <1313422796.2214.133.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313181671-5164-1-git-send-email-mad_soft@inbox.ru>
In-Reply-To: <1313181671-5164-1-git-send-email-mad_soft@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Ian Dobson <i.dobson@planet-ian.com>, Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2011-08-12 at 16:41 -0400, Dmitry Artamonow wrote:
> Export caseopen alarm status into userspace for Winbond W83627*
> and Nuvoton NCT677[56] chips and implement alarm clear knob.
> Second caseopen alarm on NCT6776 is also supported.
> 
> Thanks to Guenter Roeck for information about Nuvoton chips
> and suggestion to use SENSOR_ATTR_2.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
