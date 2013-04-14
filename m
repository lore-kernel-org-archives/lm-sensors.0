From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 14 Apr 2013 17:50:33 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (tmp401) Add support for update_interval attribute
Message-Id: <20130414175033.GA28115@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365210177-24656-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 14, 2013 at 06:15:19PM +0200, Jean Delvare wrote:
> On Sun, 14 Apr 2013 07:39:33 -0700, Guenter Roeck wrote:
> > Something else: The TMP4xx chips have a separate resolution register. Wonder if
> > it is time to add a "resolution" attribute to the ABI, especially since this has
> > come up a couple of times already. Thoughts ?
> 
> As you wish. For the lm75 driver I decided to enforce what I thought
> were sane per-chip defaults. My idea was that anyone not happy with
> these would add and provide platform data to change it. I don't really
> expect people to change the resolution of the sensor on-the-fly, but
> maybe I'm wrong... It might make sense to do so to save power on some
> platforms, I don't know. If you have any need for it, just make a
> proposal for a new attribute and I'll review it.
> 
Same logic as with limits. One would not expect to set them on the fly either,
but it may be necessary or at least desirable to be able to do it once.
"sensors -s" is one approach, another might be platform or devicetree data.

As for this one, I don't know yet if there is a requirement not to use the
default. I'll see.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
