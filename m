From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 17 Nov 2005 11:35:16 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <wxMZBkZM.1132222901.0262640.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Alessandro,

> > What exactly is the problem you are trying to solve?
>
> a) I would like to send specific commands to my driver without having
> to export a function to do that.

If the command is really specific, I see no reason why exporting a
function would be avoided.

> b) I want to have drivers of the same class to respond to a common command
> subset, so that, for example, every i2c driver which is compatible
> with I2C_CLASS_RTC could be used in the same way from the higher layers.

The fact that your RTC chip is I2C-based is an implementation detail. If
you want a command to work on all RTC drivers, you certainly do not want
to rely on i2c-core in any way. Better have some rtc-core driver (if it
doesn't already exist) and have your RTC driver register with it.

Also, please keep in mind that I2C_CLASS_* is meant to limit the extent
of automatic chip probing. Only i2c adapters and drivers which want to
take part in the automatic chip probing (which is the only way right
now, but this should change soon) should define .class. You should not
expect *all* RTC chip drivers based on I2C to define it. In fact, I even
expect .class to disappear in the long run, once alternative probing
methods have been implemented and deployed.

> c) trying to understand and document the way i2c_driver->command should
> be used/abused.

/deleted?

--
Jean Delvare
