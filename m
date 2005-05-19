From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: I2C_TIMEOUT
Message-Id: <20050113230931.2b492b52.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9ACC0FE8-65AC-11D9-B612-000393DBC2E8@freescale.com>
In-Reply-To: <9ACC0FE8-65AC-11D9-B612-000393DBC2E8@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <kumar.gala@freescale.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi Kumar,

> What is the intended purpose of the I2C_TIMEOUT cmd?  It clearly sets 
> the adapter timeout, I'm just trying to understand if there is a 
> standard usage for the adapter's timeout.

An adapter's timeout is supposedly the time the adapter driver will wait
for a client to answer before giving up. As far as I can see, most SMBus
master drivers do *not* properly use this, ie they use a local variable
instead of the i2c_adapter struct member, so you cannot use the command
to change their default timeout value. Some other bus drivers (most
notably all i2c-algo-bit-based ones, but also i2c-iop3xx and
i2c-ibm_iic.c) do properly use the timeout member so the command should
work for them.

Note that I never saw the command used. Where it would make the more
sense is from user-space through i2c-dev, but even then I believe that
everyone is just happy with the default timeouts the bus drivers come
with.

Hope that helps,
-- 
Jean Delvare
http://khali.linux-fr.org/
