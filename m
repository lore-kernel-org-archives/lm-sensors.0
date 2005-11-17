From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Thu, 17 Nov 2005 11:56:08 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117115517.55151af9@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Nov 2005 11:21:41 +0100 (CET)
"Jean Delvare" <khali@linux-fr.org> wrote:

> > a) I would like to send specific commands to my driver without having
> > to export a function to do that.
> 
> If the command is really specific, I see no reason why exporting a
> function would be avoided.

 abstraction. If we can abstract some rtc specific commands, less code will have
 to be written and maintaining it will be easier.


> The fact that your RTC chip is I2C-based is an implementation detail. If
> you want a command to work on all RTC drivers, you certainly do not want
> to rely on i2c-core in any way. Better have some rtc-core driver (if it
> doesn't already exist) and have your RTC driver register with it.

 That would bind the i2c driver definitely with its rtc counterpart.
 as I have said, rtc are not always rtcs. they may have memory, they may
 be used or not as a system rtc, thay may be timers. Should I have

 rtc-generic -> rtc-mychip -> i2c-myrtcchip *repeated* for each 
 i2c rtc chip?

 that makes no sense to me.

 I'd rather prefer having

 rtc-i2c -> i2c-anyrtcchip .

 This way, the i2c part could also be used to do other things on the rtc. If one
 needs to use it as the system rtc, you can simply modprobe the generic
 rtc i2c driver.


> > c) trying to understand and document the way i2c_driver->command should
> > be used/abused.

 I don't think the drivers/media people would be happy :) Most drivers implements
 a common subset of commands, which I think it's fair. Should each driver export
 a specific function? Should each caller have specific knowledge of the exact
 type of chip he is going to call? Certainly doable, but what a mess to maintain.

 I don't expect the i2c core to do anything specific, but I need to be sure
 all the i2c drivers conform to a standard, whatever that standard is.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

