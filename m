From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 09 Jan 2012 17:04:45 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors: Use defines for array sizes
Message-Id: <1326128685.2649.65.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326120045-2370-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326120045-2370-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-01-09 at 12:02 -0500, Jean Delvare wrote:
> On Mon,  9 Jan 2012 06:40:45 -0800, Guenter Roeck wrote:
> > Use defines for array sizes. For alarm attributes, take into account that both
> > the generic alarm flag as well as individual alarm attributes may be provided
> > by a driver (even though that should not be the case).
> > 
> > Remove overflow checks from get_sensor_limit_data(), as overflows should
> > no longer happen.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Fix MAX() macro
> 
> D'oh, I'm slow, sorry. I should have reviewed than one instead of v1.
> 
Me slow too. That MAX() bug was really a bad one. But I agree, it isn't
needed to start with.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
