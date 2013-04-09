From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Apr 2013 07:46:51 +0000
Subject: Re: [lm-sensors] i2c-tools 'raw' i2c support
Message-Id: <20130409094651.2b54749c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130408153242.GA2748@roeck-us.net>
In-Reply-To: <20130408153242.GA2748@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 8 Apr 2013 08:32:42 -0700, Guenter Roeck wrote:
> On Mon, Apr 08, 2013 at 08:33:03PM -0000, Jason Morgan wrote:
> > Hi
> > 
> > I was wondering if anybody has had a chance to review my patch?
> > 
> > Cheers,
> > Jason.
> > ----- Original Message -----
> > From: Jason Morgan
> > Sent: 02/04/13 02:07 PM
> > To: lm-sensors@lm-sensors.org
> > Subject: [lm-sensors] i2c-tools 'raw' i2c unsupported
> > 
> > Hi,
> > 
> > I notice that the lm-sensors i2c-tools don't support 'raw' I2C device file access, instead they rely on the driver supporting the smbus interface. I am working on an embedded system that does not have smbus, so I created a some patches for lm-sensors tools that add a 'r' access method. The changes support i2c-get, i2c-put and i2c-dump.
> > 
> > These changes allow the i2c-tools to be used without smbus support in the kernel device driver for the I2C inteface.
> > 
> Is this really a problem ? Usually the kernel emulates SMBus access functions
> if a driver doesn't support it directly.

Seconded. There is no point in adding support for I2C-level access in
i2c-tools. Jason, which i2c bus driver are you using? What does
i2cdetect -F say about it? I suspect that the driver forgot to add
I2C_FUNC_SMBUS_EMUL to its functionality callback. Just add that and
you should be fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
