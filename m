From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sun, 09 Nov 2014 23:04:57 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ibmpowernv) Use platform 'id_table' to probe the device
Message-Id: <1415574297.29291.3.camel@concordia>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105110848.6183.55611.stgit@localhost.localdomain>
	 <20141105142149.GA23212@roeck-us.net>
In-Reply-To: <20141105142149.GA23212@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, jdelvare@suse.de, benh@au1.ibm.com, linux-kernel@vger.kernel.org, michaele@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, lm-sensors@lm-sensors.org

On Wed, 2014-11-05 at 06:21 -0800, Guenter Roeck wrote:
> On Wed, Nov 05, 2014 at 04:45:14PM +0530, Neelesh Gupta wrote:
> > The current driver probe() function assumes the sensor device to be
> > alwary present and gets executed every time if the driver is loaded,
> > but the appropriate hardware could not be present.
> > 
> > So, move the platform device creation as part of platform init code
> > and use the 'id_table' to check if the device present or not.
> > 
> > Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> 
> Looks good. We'll need an ack from one of the powerpc maintainers to proceed.

Looks OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
