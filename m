From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Apr 2013 13:08:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if devm_kzalloc
Message-Id: <20130427130826.GA31156@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1366708003.10246.1.camel@phoenix>
 <20130423124800.GA29681@roeck-us.net>
 <517B9AFE.9000205@jic23.retrosnub.co.uk>
In-Reply-To: <517B9AFE.9000205@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Axel Lin <axel.lin@ingics.com>, Jonathan Cameron <jic23@cam.ac.uk>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Sat, Apr 27, 2013 at 10:31:42AM +0100, Jonathan Cameron wrote:
> On 04/23/2013 01:48 PM, Guenter Roeck wrote:
> > On Tue, Apr 23, 2013 at 05:06:43PM +0800, Axel Lin wrote:
> >> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > Good catch.
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> Given the timing this will need to go in through hwmon
> after the merge window is closed.  Sorry, busy week or
> I would have caught up with this earlier.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Ok.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
