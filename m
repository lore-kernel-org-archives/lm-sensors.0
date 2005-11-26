From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 10:11:34 +0000
Subject: [lm-sensors] Ticket #2103
Message-Id: <20051126101229.3e5f7949.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.s0t5dwepn40jst@localhost.localdomain>
In-Reply-To: <op.s0t5dwepn40jst@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexey,

> > I don't think we ever saw an IT8705F or IT8712F chip, it's usually found  
> > in desktop systems. It may be a misdetection. Please follow up on our  
> > mailing list, provide the complete output of "sensors detect".
> (...)
>   IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>   IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
>   the bus will break your Thinkpad forever!
>   If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
>   had users reporting system breakage on other IBM systems as well.

Your ticket states that you are using lm_sensors 2.9.2. However, the
message above was removed from the sensors-detect script before 2.9.0
was released, so you cannot possibly be using lm_sensors 2.9.2.

What version of lm_sensors are you really using? We can't help you if
you provide inaccurate information.

> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>    Failed! (0x8705)
> Probing for `ITE 8705F Super IO Sensors'
>    Success... found at address 0x0800
> Probing for `ITE 8712F Super IO Sensors'
>    Failed! (0x8705)

OK, so it's really an IT8705F chip, or SiS950 clone.

Did the it87 driver ever work properly for you with another kernel?

How are you loading it? Manually, or through some script?

Please provide the output of "isadump 0x805 0x806" before loading the
it87 driver.

-- 
Jean Delvare
