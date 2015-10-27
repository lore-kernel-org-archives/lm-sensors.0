From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 27 Oct 2015 01:12:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: ina2xx: convert driver to using regmap
Message-Id: <20151027011229.GC31838@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <562B7D56.3010700@roeck-us.net>
 <1445876673-32180-2-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1445876673-32180-2-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Titinger <mtitinger@baylibre.com>
Cc: jdelvare@suse.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Oct 26, 2015 at 05:24:32PM +0100, Marc Titinger wrote:
> Any sysfs "show" read access from the client app will result in reading
> all registers (8 with ina226). Depending on the host this can limit the
> best achievable read rate.
> 
> This changeset allows for individual register accesses through regmap.
> 
> Tested with BeagleBone Black (Baylibre-ACME) and ina226.
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>

Another comment: In ina2xx_calibrate, also use regmap_write().
Then you can drop the client variable in ina2xx_data.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
