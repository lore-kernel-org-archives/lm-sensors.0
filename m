From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Jun 2005 22:34:49 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address
Message-Id: <20050613223101.4b337064.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> For what its worth I get the same problem on a new machine I just put
> together (ironically enough so I could test ipmi_sensors on a more
> modern BMC - using the Tyan SMDC add-on). The motherboard is a Tyan
> 2882-D (an updated 2882) and I get:
> 
> w83781d 1-0028: Duplicate addresses 0x48 for subclients.

Try:
modprobe w83781d force_subclients=1,0x28,0x4a,0x4b

And/or ask Tyan for a fixed BIOS.

Which chip is it exactly? Which address(es) is sensors-detect reporting
in the first place? Tyan have a long history of conflicting sucblient
addresses.

> when trying to use w83781d. sensors-detect says I should be able to
> access the chip through the ISA bus too, but loading i2c-isa and
> w83781d no chip seems to be detected.

You may try w83627hf instead of w83781d, as the former can auto-detect
the ISA address and the latter cannot.

-- 
Jean Delvare
