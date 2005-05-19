From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: ESB2 SMBUS - validation request
Message-Id: <20050508183152.72e95b72.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <427E318D.7050908@sh.cvut.cz>
In-Reply-To: <427E318D.7050908@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> I noticed that you added ESB2 support to i2c-i801.c Thats OK for 2.6
> kernels however for 2.4.x series it is needed too. (lm_sensors lives
> outside 2.4 tree and its homepage is at http://www.lm-sensors.nu)
> 
> I created neccessary patch that adds support to 2.4.x i2c-i801.c and
> to our sensors-detect script (...)

Thanks for looking into this. I have two minor coding-style comments:

> --- lm_sensors2/kernel/busses/i2c-i801.c	
> +++ lm_sensors2_zmena/kernel/busses/i2c-i801.c
> (...)
> +/* ESB2 - Enterprise Southbridge is undefined */
> +#ifndef PCI_DEVICE_ID_INTEL_ESB2_17
> +#define PCI_DEVICE_ID_INTEL_ESB2_17 	0x269b

You have an extra space before the tab here.

> --- lm_sensors2/prog/detect/sensors-detect
> +++ lm_sensors2_zmena/prog/detect/sensors-detect
> (...)
> +       match => sub { $_[0] =~ /^SMBus I801 adapter at [0-9a-f]{4}/ },
> +     } ,

No space before comma please (although I know there are a lot in this
file...)

Otherwise it looks correct to me, providing Jason confirms your guesses.

Thanks,
-- 
Jean Delvare
