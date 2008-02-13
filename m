From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Feb 2008 20:35:33 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add maximum cooling temperature
Message-Id: <20080213213533.7cc9415b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Fri, 18 Jan 2008 00:42:54 +0100, Rudolf Marek wrote:
> This patch updates my previous patch with Jeans valuable comments - yeah thanks!
> Compile tested this time.
> 
> Following patch will add reporting of maximum temperature, at which all fans
> should spin full speed. It may be non-physical temperature on Desktop/Server CPUs.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Tested on my Core T2600, it doesn't have the feature but at least I
confirm that there is no regression.

I reviewed the code, it looks OK to me this time.

Acked-by: Jean Delvare <khali@linux-fr.org>

Just one comment:

> +			err = device_create_file(&pdev->dev,
> +						 &sensor_dev_attr_temp1_max.dev_attr);

It should be possible to make this line fit in the 80-column limit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
