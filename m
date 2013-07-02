From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 02 Jul 2013 14:36:54 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6681D, NCT6682D, and NCT6683D
Message-Id: <20130702143654.GB24048@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 02, 2013 at 10:35:09AM +0200, Jean Delvare wrote:
> On Sun, 30 Jun 2013 22:05:02 -0700, Guenter Roeck wrote:
> > NCT6683D is found on recent Intel mainboards (eg DH87MC, DH87RL).
> > NCT6681D is mentioned on the Nuvoton web site. NCT6682D is similar
> > to NCT6681D with added support for current monitoring.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  CHANGES                    |    1 +
> >  prog/detect/sensors-detect |   14 ++++++++++++++
> >  2 files changed, 15 insertions(+)
> 
> Looks good, please commit.
> 
> These chips look completely different from the other Nuvoton chips. It
> will be a lot of work to support them, right?
> 
Yes, it will require new driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
