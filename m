From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 17 Jan 2011 22:13:25 +0000
Subject: Re: [lm-sensors] driver for emc1023
Message-Id: <1295302405.9786.245.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D34960C.8070303@gmail.com>
In-Reply-To: <4D34960C.8070303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-01-17 at 15:39 -0500, Guenter Roeck wrote:
> On Mon, 2011-01-17 at 14:18 -0500, Anish Patel wrote:
> > here is the driver for the emc1023 and the makefile patch.

Couple of additional comments.

The chip reports fault conditions for the external sensors. Would be
great if you could add attribute files to report it (tempX_fault).

Also, we'll need Documentation/hwmon/emc1023.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
