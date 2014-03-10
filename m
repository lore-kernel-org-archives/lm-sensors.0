From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 10 Mar 2014 19:30:37 +0000
Subject: Re: [lm-sensors] Possibility to read temperature sensor on registered DDR3 DIMMs?
Message-Id: <20140310203037.4039bd8d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
In-Reply-To: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Mon, 10 Mar 2014 12:53:04 +0100, Andreas Hollmann wrote:
> thank you for your reply on this topic.
> 
> I have another question regarding the temperatures.
> 
> How can I identify the device for the temperatures that
> are shown below (temp0 to temp10)?

In general you'd have to ask the vendor. For Supermicro you can check
the configuration and match the register offsets with the driver. That
would result in the following for your board:

temp7: CPU1 Temperature
temp8: CPU2 Temperature
temp9: CPU3 Temperature
temp10: CPU4 Temperature
temp1: System Temperature

That doesn't tell us what temp2-4 are for though.

> It also seems that there are no devices found which need the jc42
> module? This means no temperatures are shown for memory dimms?

To my knowledge, all DDR3 modules have temperature sensors embedded. As
explained in my original reply, the fact that the jc42 driver doesn't
find anything most certainly means that all DIMM slots are behind an
SMBus switch or multiplexer. This is all board-specific so we can't
help without information from the vendor.

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
