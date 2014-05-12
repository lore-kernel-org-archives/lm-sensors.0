From: Josef Gajdusek <atx@atx.name>
Date: Mon, 12 May 2014 21:08:01 +0000
Subject: Re: [lm-sensors] [PATCH 0/9] hwmon: (emc1403) Various enhancements
Message-Id: <20140512210801.GA7839@dashie>
List-Id: <lm-sensors.vger.kernel.org>
References: <1399921311-9524-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1399921311-9524-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Had to fix wrong variable being printed in show_bit(). After that, everything on the 1412 seems to work fine including alarms.

-	return sprintf(buf, "%d\n", !!(retval & sda->index));
+	return sprintf(buf, "%d\n", !!(val & sda->index));


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
