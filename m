From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Jul 2014 22:08:51 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (smsc47m192) Fix temperature limit and vrm write operations
Message-Id: <20140718220851.GA10054@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1405710714-6445-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1405710714-6445-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 19, 2014 at 12:00:34AM +0200, Jean Delvare wrote:
> On Fri, 18 Jul 2014 12:11:54 -0700, Guenter Roeck wrote:
> > Temperature limit clamps are applied after converting the temperature
> > from milli-degrees C to degrees C, so either the clamp limit needs
> > to be specified in degrees C, not milli-degrees C, or clamping must
> > happen before converting to degrees C. Use the latter method to avoid
> > overflows.
> > 
> > vrm is an u8, so the written value needs to be limited to [0, 255].
> > 
> > Cc: Axel Lin <axel.lin@ingics.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Clamp temperature limit first, then scale, to avoid overflows
> >     Don't clamp vrm but return an error if it is out of range.
> >     Fix typo in description
> > 
> >  drivers/hwmon/smsc47m192.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
[ ... ]
> 
> Looks good.
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
