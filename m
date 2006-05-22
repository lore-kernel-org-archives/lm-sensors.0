From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 22 May 2006 20:35:10 +0000
Subject: [lm-sensors] IBM NetFinity 4000r Support
Message-Id: <4472207E.5030102@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44665DE5.60703@wans.net>
In-Reply-To: <44665DE5.60703@wans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>   If you view the bug, it uses 4 MAX161 sensors for primary temperature
> sensors.  I also posted the source code for an old driver.  Please let
> me know what I need to do to get development started.
>              Kevin

yep I rechecked again. It seems to me at first as a bus problem. Please can you 
do/provide output of following:

0) power cycle the system
1) turn on the I2C bus debugging
2) modprobe i2c-piix4
3) i2cdetect 0
4) i2cdump 0 0x2d

lspci -xxx

Thanks,
regards
Rudolf

