From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jun 2008 14:56:13 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605165613.5bd2c7f9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Jun 2008 15:23:19 +0100, Ben Hutchings wrote:
> Jean Delvare wrote:
> > What bad will happen if the limits are only initialized a few seconds
> > or minutes after the driver is loaded?
> 
> My point is that I don't see that they are ever likely to be initialised.
> They can be set through sysfs, but unless this is automated in some standard
> way then almost no-one will actually go to the trouble of doing it.

Same is true of every hardware monitoring in every system. If the user
doesn't care about the limits, why should you care for him/her?

The standard way of proceeding would be to provide libsensors
configuration files for your network adapters, and users who care about
proper sensor labelling and limits, will download and install them on
their systems. We plan to automatize the process a bit in the future
but this isn't done yet.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
