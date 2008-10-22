From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Oct 2008 06:35:31 +0000
Subject: Re: [lm-sensors] Intend to implement ADT7467/ADT7468 driver
Message-Id: <20081022083531.12a7c1f5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081021122146.GA7049@ratte.dhs.org>
In-Reply-To: <20081021122146.GA7049@ratte.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Oct 2008 15:43:23 -0700, Darrick J. Wong wrote:
> On Tue, Oct 21, 2008 at 02:21:46PM +0200, Bernhard Rieder wrote:
> > Hi Everybody,
> > 
> > I am currently working on an ADT746[78] driver which will be finished soon.
> > 
> > However, I am not sure how to react to errors. Which values do I return in case
> > the chip reports errors (i.e. temp=-64 is an error value for the temperature reading,
> > -63 is ok). Are there somewhere error values defined which can used for this? I do
> > not think usinf -64 is a good choice, because the chip has two modes for temperature
> > and an error would be reported as -128 in the other mode. Additionally, -64 could be
> > interpreted as a real value (at least in sibiria when it is a cold winter day).
> > 
> > Are there somewhere constants like SENSORS_VOLTAGE_INVALID, SENSORS_TEMP_INVALID, ...
> > which I missed? I think common error values would be really beneficial ...
> 
> Hm... I think the lm85/adt7468 have similar registers.  Oddly, I was
> working on a patch to the lm85 driver to add 7468 support.  I suspect we
> should collaborate. :)

The lm85 driver is already pretty big. I'd only add support for chips
which are 100% compatible with an already supported chip to it. If the
ADT7468 and ADT7467 have specific properties (missing or extra inputs,
different scaling factors, extra features...) I'd rather have a new
driver for them (which might as well be derived from lm85.c, but then
please make sure you start from the very last version as I fixed it and
cleaned it up extensively in the past few months.)

> Also, a driver for the adt7467 is (mostly?) implemented in
> drivers/macintosh/therm_adt746x.c, though it relies on finding the
> device via some sort of openfirmware calls, which isn't appropriate for
> PCs.

The macintosh driver also doesn't implement the standard sysfs
interface and I don't think it supports voltage inputs. I could never
convince the powerpc people to drop their custom interface in favor of
ours. Maybe with the advent of new-style I2C drivers and if we
implement an in-kernel interface for temperature value access, they
will reconsider...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
