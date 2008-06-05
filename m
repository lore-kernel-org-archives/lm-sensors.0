From: Ben Hutchings <bhutchings@solarflare.com>
Date: Thu, 05 Jun 2008 14:04:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605140415.GL11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 5 Jun 2008 13:14:01 +0100, Ben Hutchings wrote:
> > Jean Delvare wrote:
> > > I fully agree. Plus, it would give you a chance to explain why this
> > > noisy change is needed. At a quick glance I admit I don't quite get the
> > > point.
> > 
> > The point is to allow platform_data to provide all the settings and to
> > allow polling of the values, without exposing any of the implementation
> > variables.
> 
> The question is: why do you want to provide the "settings" (I think you
> mean the high and low limits of each sensor?) and allow polling of the
> values inside the kernel, when we have a standard user-space interface
> and library that takes care of this, with a dozen applications that can
> be used on top of it? It makes sense to pass _some_ settings as
> platform data (e.g. fan polarity) but passing all the limits doesn't
> make any sense to me.

We know what the limits should be for our boards and those should be set as
the defaults.  AFAIK there's no user-space infrastructure for initialising
these things at hotplug time, so we must specify them in the kernel.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
