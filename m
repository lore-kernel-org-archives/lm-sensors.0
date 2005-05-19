From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: bmc and fan speed control
Message-Id: <25381867050510122948dd2b64@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <427FF313.7070202@mds.gotdns.com>
In-Reply-To: <427FF313.7070202@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aj,


Yes the ADM1026 has fan control, but the ADM1026 is mentioned only as
the chip used by the IPMI BMC on it's private i2c bus. All IPMI BMCs
use normal hardware monitoring chips (AFAIK)  at a lower level, but
usually the documentation isn't always so complete as telling you
which. The BMC is essentially another separate computer running on
your motherboard along with it's own CPU, memory, firmware and even
i2c bus. The chip is likely only accessible by the IPMI BMC directly,
so unless the IPMI BMC has some sort of support itself for a command
to set the pwm you are out of luck.

The only sensor write commands in IPMI 1.5 are for setting alarm
limits, enabling/disabling sensors and setting sensor types, so I
don't see how you could set the fan speed in anyway via IPMI.

I think the only possible way to set the fan speed then would be if
(like my board) the IPMI BMC shares the same i2c bus as the rest of
the machine, except the bios blocks access to it, and you somehow
unblock that and access the ADM1026 directly (which by the way the
IPMI BMC wouldn't like, and would likely start complaining). In my
case I can do that by flashing with another vendor's bios, but my
motherboard is a bit unusual, and I wouldn't recommend trying anything
like that.

Yani
