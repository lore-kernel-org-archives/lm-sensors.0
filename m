From: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Tue, 15 Nov 2011 02:58:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus) Fix two issues
Message-Id: <3C06C26914DACA4BB3A368F78CA0B3A712AAA0@039-SN1MPN1-004.039d.mgd.msft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321249266-17071-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Hmm ... looking into the code, I2C_FUNC_SMBUS_READ_BLOCK_DATA is missing
> from I2C_FUNC_SMBUS_EMUL.
> Now that is interesting.
> 
> If you change mpc_functionality() to
> 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> I2C_FUNC_SMBUS_READ_BLOCK_DATA; I bet your problem will disappear.
> 
> Jean, any idea why I2C_FUNC_SMBUS_EMUL doesn't include
> I2C_FUNC_SMBUS_READ_BLOCK_DATA ?
> 
[Yuantian:] unfortunately no, Even I add I2C_FUNC_SMBUS_READ_BLOCK_DATA support,
The return value is not correct.

> Thanks,
> Guenter
> 

Regards,
Yuantian


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
