From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Help me with VT82C586B
Message-Id: <20050327102550.43139f03.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <14410443364.20050325100723@omskart.ru>
In-Reply-To: <14410443364.20050325100723@omskart.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

> JD> Not all motherboards have sensors, especially older ones, which
> JD> seems to be your case.
> 
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
>     PRO133x] (rev 1).
>       Master Capable.  Latency.
>       Prefetchable 32 bit memory at 0xe0000000 [0xe1ffffff].
>   Bus  0, device   1, function  0:
>     PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
>     MVP3/Pro133x AGP] (rev 0).
>       Master Capable.  No bursts.  Min Gnt.
>   Bus  0, device   7, function  0:
>     ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
>     VP] (rev 71).
> 
> what about this?

This is your south bridge, which has an I2C controller which is properly
handled by our i2c-via driver. This south bridge has no integrated
sensors, and there are no sensors on the I2C bus. Thus my conclusion:
there are no sensors on this motherboard.

-- 
Jean Delvare
