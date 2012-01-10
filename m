From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 17:03:13 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (lm63) Add support for unsigned
Message-Id: <1326214993.2649.82.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-10 at 11:52 -0500, Jean Delvare wrote:
> On Mon,  9 Jan 2012 19:42:01 -0800, Guenter Roeck wrote:
> > From: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > LM96163 supports unsigned upper limits for the external temperature sensor.
> > Add support for it.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I'm a bit confused by this double signed-off-by statement. What's the
> point?

Oversight; another one I only noticed after I (re)sent the patches.
Remove the first one. I have a new development system at home from which
I sent those patches. Obviously it doesn't use the Ericsson e-mail
address.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
