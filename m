From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 05 Nov 2010 09:00:05 +0000
Subject: Re: [lm-sensors] [PATCH 8/8] hwmon: applesmc: Update copyright
Message-Id: <4CD3C795.3050006@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se> <1288511434-5662-9-git-send-email-rydberg@euromail.se> <20101105030923.GG28308@ericsson.com>
In-Reply-To: <20101105030923.GG28308@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

>

> One suggestion - since you did that much rework, it would be nice if you could fix
> the remaining few checkpatch errors in the file as well (and possibly the warnings).


Absolutely. Regarding the warnings, I was deliberately leaving the over-80 lines
since they appear in static array listings, and as such seem to be pretty common
in the kernel. I know these things have been discussed before. :-)

Cheers,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
