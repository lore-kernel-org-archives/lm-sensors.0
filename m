From: ymu@winbond.com (Yuan Mu)
Date: Wed, 05 Jul 2006 01:27:19 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <44AB1577.8080005@winbond.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,
> 
> After few hundreds kilometers in train and many hours outside of it I have
> finally finished initial review. And I still dont know if I catched everything.
> 
Thanks :)

> I'm attaching the driver with comments.
> 
> I would like to fix for sure:
> 
> 1) step time/stop time unit to milliseconds
Of course ok.
> 2) tolerance/range temperature to milidegrees of celsius, plus there is a little
> problem with sysfs names. For EHF driver they are like this:
> ruik at ruik:/sys/bus/i2c/devices/9191-0290$ ls pwm1*
> pwm1  pwm1_enable  pwm1_min_output  pwm1_mode  pwm1_stop_time  pwm1_target
> pwm1_tolerance
> 
> Because they are tight to pwm but your chip design has it tighten to temps... I
> guess we cannot change it anyway...
> 
Yes, i guess so..
> Please can you provide some short documentation for new sysfs files that are
> somewhat non-standard so we may discuss the names?
> 
> For example temp##index##_fan_map would be better name
> temp[1-*]_auto_channels_pwm because we already define pwm[1-*]_auto_channels_temp
> 
OK.
> 3)  WRITE_TO_REG
>     is bad :) Please do not trust the cached values always write new one. ACPI
>    might changed the value in your behind ;)
> 
Ah, i hate ACPI :(
Almost all write function use this macro so to change it is simple :)
> if (0 <= w83793_write_value(client, REG
> 
> Does not look nice too.
> 
> Plus there are many more comments and ideas in annotated driver. There are three
> of my TODOs I will do that soon or later.
> 
I will fix what you said first.
> I'm offline starting tomorrow noon for two days so I will be not able to respond.
> 
> I think I will be able to respond you in morning if you have some questions to
> my mail ;)
> 

Thanks again for your review ;)

-- 
Best Regards
Yuan Mu


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

