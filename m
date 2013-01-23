From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 23 Jan 2013 23:14:57 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Driver for Texas Instruments INA209
Message-Id: <20130123231457.GA20993@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1358915321-30200-1-git-send-email-linux@roeck-us.net>
 <20130123180222.GA25880@ovro.caltech.edu>
In-Reply-To: <20130123180222.GA25880@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Paul Hays <haysp@magma.net>

On Wed, Jan 23, 2013 at 10:02:22AM -0800, Ira W. Snyder wrote:
> On Tue, Jan 22, 2013 at 08:28:41PM -0800, Guenter Roeck wrote:
> > Add support for the TI / Burr-Brown INA209 voltage / current / power
> > monitor.
> > 
> > Cc: Paul Hays <haysp@magma.net>
> > Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2:
> > - Updated Paul Hays' e-mail address and added as driver author
> > - ina290_init_client -> ina209_init_client
> > - Added devicetree support
> > - Simplified chip initialization code
> > 
> 
> Hi Guenter,
> 
> I tested this on a PowerPC using the new devicetree support. It sets the
> calibration registers correctly based on the devicetree values.
> 
> Tested-by: Ira W. Snyder <iws@ovro.caltech.edu>
> 
> Thanks for the work on this!

Thanks for testing!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
