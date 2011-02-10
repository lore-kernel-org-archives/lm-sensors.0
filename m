From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Feb 2011 21:33:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/5] hwmon: (w83627ehf) Add support for
Message-Id: <1297373581.24938.138.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297352949-25602-6-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297352949-25602-6-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-02-10 at 14:34 -0500, Ian Dobson wrote:
[ ... ]

> 
> Maybe if the parameters (_target, _tolerance etc) are invalid in smartfan 
> mode, we should return invalid-ENOVAL? It would be interesting to be able to 
> actually control the setpoints, for example on my box running the fans is 
> silent mode the CPU temperature is abit high for my liking and and standard 
> mode the fans are too loud. Something in between  would be good.
> 
I tend to agree with Jean - it should still be possible to configure
other modes prior to actually setting that mode.

Having said that, I had a closer look into the NCT6776F datasheet. Turns
out that it no longer supports SmartFan III mode, meaning the related
registers (pwmX_max_output and pwmX_step_output) no longer exist. I'll
have to see what I can do about that.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
