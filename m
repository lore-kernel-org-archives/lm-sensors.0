From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Feb 2014 21:24:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Avoid initializing the same field twice
Message-Id: <20140211212456.GA2951@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140203184211.35536a4b@endymion.delvare>
In-Reply-To: <20140203184211.35536a4b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 11, 2014 at 10:22:16PM +0100, Jean Delvare wrote:
> On Mon, 03 Feb 2014 15:43:04 -0800, Guenter Roeck wrote:
> > On 02/03/2014 09:42 AM, Jean Delvare wrote:
> > > All hwmon drivers allocate their data structure with some form of
> > > kzalloc, so setting data fields to zero explicitly is a waste of time.
> > >
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > ---
> > > Guenter, this is likely to conflict with your current conversion work,
> > > as most of these drivers have not been converted yet (lm63 is the
> > > exception.) I thought splitting this patch per driver was a little
> > > overkill but maybe this would be better for you? I think I'll split at
> > > least pc87360 anyway as it's non-trivial. Let me know how you want to
> > > proceed.
> > >
> > 
> > One option would be to take the patch into my repository, or just hold off
> > with further conversions until after 3.15-rc1. Maybe the latter, as we'll
> > already have a conflict with the lm63 driver.
> 
> Please don't refrain from converting drivers just because of this
> cleanup.
> 
> I'll split lm63 and pc87360 (for me) and lm95241 and lm95245 (for you),
> and keep the rest in a single patch for now. If other patches come in
> that touch these drivers, I'll split it further and the relevant parts
> can go into your tree.
> 
Sounds like a plan.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
