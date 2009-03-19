From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Mar 2009 13:51:44 +0000
Subject: Re: [lm-sensors] ECS GeForce 6100 PM-M2 - labels/calculations
Message-Id: <20090319145144.5a8d6529@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49BE37E8.90301@googlemail.com>
In-Reply-To: <49BE37E8.90301@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Mar 2009 19:04:39 +0530, Charles wrote:
> cpu0_vid is (was?) not dynamic under the current lm-sensors implementation;
> the value shown is the value at start up.

Depends on the chip/driver. It's dynamic if read from regular registers
as other monitored values. It's the start up value if read from the
Super-I/O configuration space. The reason is that there is no
coordination between the various drivers which may access Super-I/O
configuration registers at the moment, so we don't want to access them
past initialization time. If we ever have proper locking protecting
Super-I/O register access then we can do dynamic readings on all
chips/drivers.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
