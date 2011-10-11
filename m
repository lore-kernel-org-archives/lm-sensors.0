From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 11 Oct 2011 16:08:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Use i2c_smbus_{read,
Message-Id: <1318349288.3983.165.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E946521.4050104@cam.ac.uk>
In-Reply-To: <4E946521.4050104@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-10-11 at 11:35 -0400, Jean Delvare wrote:
> Make use of the new i2c_smbus_{read,write}_word_swapped functions.
> This makes the driver code more compact and readable. It also ensures
> proper error handling.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Dirk Eibach <eibach@gdsys.de>
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> Cc: Guillaume Ligneul <guillaume.ligneul@gmail.com>
> ---
> See http://marc.info/?l=linux-i2c&m1823766914651&w=2
> 
Nice cleanup.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
