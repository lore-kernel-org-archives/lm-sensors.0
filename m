From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 07:03:11 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071009090311.289eccd5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 08 Oct 2007 20:31:55 +0200, Juergen Bausa wrote:
> > Aha, that explains it. Can you apply the attached patch and reload the
> > driver? Could you also please post the output of 'lsmod'?
> 
> not much information:
> /var/log/messages.0:Oct  4 00:17:43 lisa kernel: dme1737 0-002e: Write to register 0x30 failed (-1)! Please report to the driver maintainer.

As I expected...

> i2c_nforce2             7232  0

Juerg, you could patch i2c-nforce2 to return more useful error codes.
Such a patch could go upstream. Alternatively, building the i2c-nforce2
driver with CONFIG_I2C_DEBUG_BUS=y may provide some hints.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
