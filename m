From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 12 Nov 2010 10:38:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] intel medfield: thermal_driver
Message-Id: <20101112103821.5cf89243@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101111154902.12776.31489.stgit@localhost.localdomain>
In-Reply-To: <20101111154902.12776.31489.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 11 Nov 2010 12:56:54 -0800
Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> On Thu, 2010-11-11 at 10:49 -0500, Alan Cox wrote:
> > From: Durgadoss <durgadoss.r@intel.com>
> > 
> > This is the basic thermal sensor driver for Intel MID platform using the
> > Medfield chipset. It plugs in via the thermal drivers and provides sensor
> > readings for the device sensors.
> > 
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > ---
> > 
> As a thermal driver, shouldn't this driver be in drivers/thermal ?

drivers/thermal doesn't contain any drivers at all but I have no problem
with being there or hwmon - whichever is best.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
