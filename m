From: Dmitry Artamonow <mad_soft@inbox.ru>
Date: Fri, 12 Aug 2011 20:38:25 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add caseopen detection to
Message-Id: <20110812203824.GB32369@rainbow>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313009786-29885-1-git-send-email-mad_soft@inbox.ru>
 <1313084814.2214.100.camel@groeck-laptop>
In-Reply-To: <1313084814.2214.100.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Ian Dobson <i.dobson@planet-ian.com>, Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10:46 Thu 11 Aug     , Guenter Roeck wrote:
> Hi Dmitry,
> 
> please consider the changes suggested below.

[...]

> > +static struct sensor_device_attribute sda_caseopen[] = {
> > +	SENSOR_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_caseopen,
> > +			clear_caseopen, 0),
> > +	SENSOR_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_caseopen,
> > +			clear_caseopen, 1),
> 
> 	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO,
> 			show_caseopen, clear_caseopen, 0x80, 0x10),
> 	SENSOR_ATTR_2(intrusion1_alarm, S_IWUSR | S_IRUGO,
> 			show_caseopen, clear_caseopen, 0x40, 0x40),
> 

Oh, yeah! That's much neater with SENSOR_ATTR_2 - thanks for suggestion!
I've seen it while looking to other hwmon drivers, but missed the difference
from plain SENSOR_ATTR...

I've incorporated your suggested changes into v3 of the patch - it will follow
this mail.

-- 
Best regards,
Dmitry "MAD" Artamonow


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
