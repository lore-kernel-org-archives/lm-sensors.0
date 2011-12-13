From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Dec 2011 05:58:33 +0000
Subject: Re: [lm-sensors] unsupported intel smbus controller?
Message-Id: <20111213055832.GB18715@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <19012-1323723512-333625@sneakemail.com>
In-Reply-To: <19012-1323723512-333625@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 12, 2011 at 06:40:01PM -0500, yu8ehurwa2@snkmail.com wrote:
[ ... ]
> 
> However, I have a TC74 on the SMBus (in addition to some intel gigE
> controllers).  The TC74 doesn't seem to be detected.
> 
> Is there a utility that lists devices on the smbus?
> 
sensors-detect or i2cdetect.

TC74 can not be auto-detected as far as I can see from the datasheet,
and there is no driver for it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
