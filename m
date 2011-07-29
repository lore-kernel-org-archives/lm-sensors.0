From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 29 Jul 2011 00:08:31 +0000
Subject: Re: [lm-sensors] [PATCH 10/15] hwmon: (pmbus) Add support for peak
Message-Id: <20110729000831.GD4382@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310485300-2168-11-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310485300-2168-11-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 28, 2011 at 07:19:42PM -0400, Robert Coulson wrote:
> 
> Hi Guenter,
> 
> I'm curious to know why the PMBUS_MAX_INPUT_SENSORS does not include the temp sensors; do you know?
> 
Hi Rob,

Temperature sensors are not considered "input" sensors in PMBus terminology.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
