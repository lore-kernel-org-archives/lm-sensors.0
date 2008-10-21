From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 21 Oct 2008 22:43:23 +0000
Subject: Re: [lm-sensors] Intend to implement ADT7467/ADT7468 driver
Message-Id: <20081021224322.GN7771@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081021122146.GA7049@ratte.dhs.org>
In-Reply-To: <20081021122146.GA7049@ratte.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 21, 2008 at 02:21:46PM +0200, Bernhard Rieder wrote:
> Hi Everybody,
> 
> I am currently working on an ADT746[78] driver which will be finished soon.
> 
> However, I am not sure how to react to errors. Which values do I return in case
> the chip reports errors (i.e. temp=-64 is an error value for the temperature reading,
> -63 is ok). Are there somewhere error values defined which can used for this? I do
> not think usinf -64 is a good choice, because the chip has two modes for temperature
> and an error would be reported as -128 in the other mode. Additionally, -64 could be
> interpreted as a real value (at least in sibiria when it is a cold winter day).
> 
> Are there somewhere constants like SENSORS_VOLTAGE_INVALID, SENSORS_TEMP_INVALID, ...
> which I missed? I think common error values would be really beneficial ...

Hm... I think the lm85/adt7468 have similar registers.  Oddly, I was
working on a patch to the lm85 driver to add 7468 support.  I suspect we
should collaborate. :)

Also, a driver for the adt7467 is (mostly?) implemented in
drivers/macintosh/therm_adt746x.c, though it relies on finding the
device via some sort of openfirmware calls, which isn't appropriate for
PCs.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
