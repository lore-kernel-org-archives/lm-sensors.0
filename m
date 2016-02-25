From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Feb 2016 06:03:30 +0000
Subject: Re: [lm-sensors] Support for Acer Revo One RL85
Message-Id: <56CE9932.2010402@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1455877529.2575284.525825354.455A39A0@webmail.messagingengine.com>
In-Reply-To: <1455877529.2575284.525825354.455A39A0@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/19/2016 03:14 AM, Jamie Kitson wrote:
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               Yes
> Found unknown chip with ID 0x8528

This is an embedded controller chip, meaning it is all software programmed.
The only way to get support for it chip is through a platform specific
driver, typically an ACPI driver. This would require information
from the board vendor about ACPI access methods.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
