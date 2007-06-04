From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Jun 2007 12:34:13 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <20070604143413.206dbb30@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Keith,

On Mon, 04 Jun 2007 02:26:51 +0000, KEITH ROMBERG wrote:
> Another problem I think is that the i2c-ipmi module is not getting loaded.  
> The module is not in the /lib/modules directory and I can not find any trace 
> and/or reference to it in the kernel source.  Is this one need?  It says it 
> should be loaded by sensors-detech which is version 2.10.1

As far as I know, i2c-ipmi no longer exists (nor is needed) when running
a 2.6 kernel.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
