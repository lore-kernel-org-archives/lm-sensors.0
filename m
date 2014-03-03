From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Mar 2014 21:27:36 +0000
Subject: Re: [lm-sensors] Possibility to read temperature sensor on registered DDR3 DIMMs?
Message-Id: <20140303222736.45f9adb0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
In-Reply-To: <CAGz0_-1Y9Qos3qm8AAejhTxtZPeE9VH_ZCmscOY-R6QU-VkWDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 3 Mar 2014 21:52:43 +0100, Andreas Hollmann wrote:
> Hi,
> 
> I have a 4-socket system with 256 GB RAM (32 x 8 GB).
> 
> Socket 0 shows unstable behavior when running the stream
> benchmark. It runs well for some time and then the performance
> drops to 50 %. It seems like throttling of some component.
> 
> The CPU temperatures are very low and therefore I consider
> it a problem with one of the 8 DIMM modules on Socket 0.
> 
> Is there any way to read the temperature?

Yes, it is supported by the jc42 driver. If you are lucky, you can just
load it and enjoy.

However, on such a beast of a board, odds are that the SMBus is
multiplexed and you will need proper support for that in order to see
all DDR3 temperature sensors.

SMBus multiplexing is board-specific so you will have to ask the vendor
for technical details on how SMBus multiplexing is implemented on your
specific board. With sufficient information, we can add support to
Linux for you.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
