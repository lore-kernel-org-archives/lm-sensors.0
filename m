From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 Oct 2011 12:54:33 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for MCP3204/3208
Message-Id: <20111031135433.00655862@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201110311247.p9VClrVx017871@home.pavel.comp>
In-Reply-To: <201110311247.p9VClrVx017871@home.pavel.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 31 Oct 2011 16:10:23 +0400, Paul Fertser wrote:
> Add support for these simple low-power cheap ADC ICs.
> 
> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> ---
> 
> Well, adc*_in and adc_diff*_in are not mentioned in the sysfs-attributes.txt

Indeed, and this alone means a bold NACK without even reviewing your
code. Sticking to Documentation/hwmon/sysfs-attributes is mandatory.

> but at least the max1111 uses the former. Waiting for your feedback.

Thanks for pointing this out. I don't know how it managed to sneak in,
but it shouldn't have. I'll ask the driver author to align with the
standard interface quickly, otherwise we'll have to delete the driver
altogether.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
