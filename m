From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 24 Jan 2007 12:15:07 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Only probe useful I2C
Message-Id: <20070124131507.8dc8fe4a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070115200620.ceeb1ad5.khali@linux-fr.org>
In-Reply-To: <20070115200620.ceeb1ad5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 15 Jan 2007 20:06:20 +0100, Jean Delvare wrote:
> Here comes a patch to sensors-detect. The idea is to limit the I2C
> probing to the addresses where we know at least one hardware monitoring
> chip, rather than probing the whole 0x03-0x77 address range. Probing
> extra addresses has several drawbacks:
> * On some machines, probing some addresses results in a bus lockup.
>   Probing less addresses might help.
> * Some users are confused when sensors-detect finds an I2C/SMBus chip
>   at a given address but fails to identify it. To them, it may sound
>   like it is an unknown hardware monitoring chips. In 99% of the cases
>   it isn't though.
> * It's a waste of time.
> 
> I also dropped the detection of the "SMBus 2.0 ARP-Capable Device" at
> 0x61. If we ever support this, it's not sensors-detect's job.
> 
> In practice, this change basically halves the number of probed I2C
> addresses.
> 
> If someone really wants to see all the responsive addresses on an I2C
> bus, we have i2cdetect for that.
> 
> Comments anyone?

As there were no objections, I applied this patch.

-- 
Jean Delvare

