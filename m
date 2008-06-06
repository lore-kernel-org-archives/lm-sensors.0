From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 06 Jun 2008 14:24:53 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data
Message-Id: <20080606102237.ZZRA012@mailhub.coreip.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <4846EBF5.2030406@tremplin-utc.net> <20080604225830.1dff64fc@hyperion.delvare> <20080604230510.GB30475@elf.ucw.cz> <484728B2.1000209@tremplin-utc.net> <20080605082950.6957f1a2@hyperion.delvare> <4847B415.2080708@cam.ac.uk> <48484DD6.3050706@tremplin-utc.net> <4848683E.4070709@eslack.org>
In-Reply-To: <4848683E.4070709@eslack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pau Oliva Fora <pau@eslack.org>
Cc: ?ric Piel <Eric.Piel@tremplin-utc.net>, Jonathan Cameron <jic23@cam.ac.uk>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>, Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Pavel Machek <pavel@suse.cz>, Yan@ATrpms.net, Dmitry@ATrpms.net, Arjan van de Ven <arjan@infradead.org>

Hi,

On Fri, Jun 06, 2008 at 12:27:10AM +0200, Pau Oliva Fora wrote:
> From: Pau Oliva Fora <pau@eslack.org>
>
> Add support for HTC Shift UMPC G-Sensor LIS3LV02DL accelerometer.
>
> Signed-off-by: Pau Oliva Fora <pau@eslack.org>
>

The input piece looks good, however it seens that the input is the
only functionality that this driver exports so I don't see any reason
to make input device registration optional. Or are you planning on
adding more functions to it?

Thanks.

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
