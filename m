From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 09 May 2008 10:47:18 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <48242BB6.3080404@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 09 May 2008 07:03:19 +0200, Hans de Goede wrote:
>> Perhaps it would be an idea to try to do an i2c (*) read transfer of more then 
>> 1 byte, it would be interesting to see how this specific 1 register device 
>> responds to this, maybe it will stop acking after the first byte is transfered 
>> because it has only one byte to send.
> 
> In master-receiver, slave-transmitter mode, it's the master who sets
> the ack bit, depending on whether it will ask for more bytes after that
> one (ack) or not (nack). The slave doesn't have its say. All the slave
> can do is send zero or maybe random bytes if it doesn't have data to
> send.

You're right, I didn't think about that.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
