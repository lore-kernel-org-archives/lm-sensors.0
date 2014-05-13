From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 13 May 2014 01:02:27 +0000
Subject: Re: [lm-sensors] [PATCH 0/9] hwmon: (emc1403) Various enhancements
Message-Id: <53716F23.4010704@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1399921311-9524-1-git-send-email-linux@roeck-us.net> <20140512210801.GA7839@dashie>
In-Reply-To: <20140512210801.GA7839@dashie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josef Gajdusek <atx@atx.name>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 05/12/2014 02:08 PM, Josef Gajdusek wrote:
> Had to fix wrong variable being printed in show_bit(). After that, everything on the 1412 seems to work fine including alarms.
>
> -	return sprintf(buf, "%d\n", !!(retval & sda->index));
> +	return sprintf(buf, "%d\n", !!(val & sda->index));
>
>

Hi Josef,

Fixed with v2. Thanks a lot for the feedback!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
