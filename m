From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Feb 2011 14:36:35 +0000
Subject: Re: [lm-sensors] Moving the lis3lv02d driver
Message-Id: <20110218143635.GA27612@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195148.GB20826@ericsson.com>
In-Reply-To: <20110217195148.GB20826@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 18, 2011 at 03:07:03AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 17 Feb 2011 11:51:48 -0800, Guenter Roeck wrote:
> 
> > we discussed moving the lis3lv02d driver to another location earlier. 
> > 
> > Unfortunately, I don't find the thread anymore, and I don't recall
> > if we reached a conclusion where to move it to.
> 
> I think you are looking for this thread:
> http://www.spinics.net/lists/linux-input/msg11585.html
> 
> > Any thoughts ?
> 
> I would be happy with _any_ solution which moves the lis3lv02d driver
> outside of drivers/hwmon.
> 
> The difficulty I see is that hp_accel depends on lis3lv02d, and
> hp_accel would normally go to drivers/platform/x86, but lis3lv02d can't
> live there. So doing the right thing would need some work to fix the
> dependencies.
>
Ah yes, that problem. And moving all of it to misc wouldn't be that good either.

No idea how to get rid of those dependencies. Maybe we'll need to wait
until iio/accel is ready after all.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
