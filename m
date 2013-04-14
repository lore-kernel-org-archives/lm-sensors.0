From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Apr 2013 16:15:19 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (tmp401) Add support for update_interval attribute
Message-Id: <20130414181519.5006c98d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 14 Apr 2013 07:39:33 -0700, Guenter Roeck wrote:
> Something else: The TMP4xx chips have a separate resolution register. Wonder if
> it is time to add a "resolution" attribute to the ABI, especially since this has
> come up a couple of times already. Thoughts ?

As you wish. For the lm75 driver I decided to enforce what I thought
were sane per-chip defaults. My idea was that anyone not happy with
these would add and provide platform data to change it. I don't really
expect people to change the resolution of the sensor on-the-fly, but
maybe I'm wrong... It might make sense to do so to save power on some
platforms, I don't know. If you have any need for it, just make a
proposal for a new attribute and I'll review it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
