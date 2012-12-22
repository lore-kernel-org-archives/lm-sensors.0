From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 22 Dec 2012 06:59:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] lm73: detect i2c bus errors before scnprintf()
Message-Id: <20121222065940.GA4444@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1356083914-17579-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 21, 2012 at 05:37:38PM -0800, Chris Verges wrote:
> On Fri, Dec 21, 2012 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Just wondering - how comes the detect function did not report the error ?
> >
> 
> Excellent question.  I didn't debug into this any further, but it is a good
> area for additional investigation.
> 
Depends on how it is instantiated. Is this a PC, or some embedded device ?
It could be configured with devicetree, for example.

Question though is if there is some other chip on that address, and it is
wrongly detected as LM73. Do you know by any chance ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
