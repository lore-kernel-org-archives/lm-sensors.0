From: Roland Stigge <stigge@antcom.de>
Date: Fri, 07 Jan 2011 12:56:55 +0000
Subject: Re: [lm-sensors] Use of swab16() in drivers/hwmon/*.c
Message-Id: <4D270D97.9040509@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D26ECDB.7010602@antcom.de>
In-Reply-To: <4D26ECDB.7010602@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 01/07/2011 11:59 AM, Jean Delvare wrote:
> This has nothing to do with the host's endianess. This has to do with
> the fact that the SMBus specification says that words are sent low byte
> first but almost all hardware monitoring devices send the high byte
> first (because it makes a lot more sense.)

Thanks! I just ignored that the word implementation of Linux' SMBus
(I2C_SMBUS_WORD_DATA etc.) already takes care of that.

bye,
  Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
