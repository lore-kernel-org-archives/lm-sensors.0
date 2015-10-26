From: Marc Titinger <mtitinger@baylibre.com>
Date: Mon, 26 Oct 2015 16:24:31 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: ina2xx: convert driver to using regmap
Message-Id: <1445876673-32180-1-git-send-email-mtitinger@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <562B7D56.3010700@roeck-us.net>
In-Reply-To: <562B7D56.3010700@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.com
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>

Hi Guenter,

as requested, here's the regmap version as a separate patch. I've left out
the idea of separate show functions as it doesn't bring much indeed.

If you're interested in a before/after comparison, here are the plots of
of a usb key (DUT) power-cycle captured using either driver version.
As expected, the measurement is better resolved with single reads.

"github dot com"/mtitinger/ACME/blob/master/docs/measurements/bulk-700pts.png
"github dot com"/mtitinger/ACME/blob/master/docs/measurements/regmap-700pts.png

Many thanks.

Marc Titinger (2):
  hwmon: ina2xx: convert driver to using regmap
  hwmon: ina2xx: give precedence to DT over checking for platform data.

 drivers/hwmon/ina2xx.c | 208 +++++++++++++++++++------------------------------
 1 file changed, 79 insertions(+), 129 deletions(-)

-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
