From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 16 Jan 2011 06:58:06 +0000
Subject: Re: [lm-sensors] LM94
Message-Id: <20110116065806.GA27859@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D31E8DA.7000503@gmail.com>
In-Reply-To: <4D31E8DA.7000503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 15, 2011 at 01:35:06PM -0500, Anish Patel wrote:
> Hello All,
> 
> I have tested the LM94 sensor with the LM93 driver and this override command
> echo lm93 0x2e > /sys/bus/i2c/devices/i2c-0/new_device
> 
I thought about adding the LM94 IDs to the LM93 driver. Problem is that
the driver does not support the extended features of LM94, so I am not sure
if that would be a good idea.

Thoughts anyone ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
