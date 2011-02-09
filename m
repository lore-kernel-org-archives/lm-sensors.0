From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Feb 2011 12:36:40 +0000
Subject: Re: [lm-sensors] Supported I2C addresses for EMC temperature sensors
Message-Id: <20110209133640.5c4cf3cd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110124202454.GA640@ericsson.com>
In-Reply-To: <20110124202454.GA640@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 24 Jan 2011 12:24:54 -0800, Guenter Roeck wrote:
> while looking into EMC temperature sensor detection, I noticed a discrepancy 
> in some of the I2C chip addresses listed in sensors-detect vs. the addresses 
> supported per datasheets.
> 
> Per sensors-detect, addresses supported for emc1403, emc1404, and emc1423 are
> 	i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
> 
> However, adccording to the datasheets, supported addresses should be
> 	0x18, 0x29, 0x4c, 0x4d 
> for emc1403 and emc1404, and
> 	0x4c
> for emc1423.
>
> Any idea what is correct ?

I would trust the datasheets. Which means that sensors-detect must be
fixed, and the emc1403 driver as well.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
