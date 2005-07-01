From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 01 Jul 2005 16:00:19 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90AB5BB5@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300918.17966.bgardner@wabtec.com>
In-Reply-To: <200506300918.17966.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Is there a preferred format?

"23 6c dc 1c 00 00 00 43"
or
"236cdc1c00000043"
or
"0x23 0x6c 0xdc 0x1c 0x00 0x00 0x00 0x43"
Or, since it can be thought of as a 64 bit number
"0x236cdc1c00000043"

I prefer the last one.

Thanks,
Ben

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Thursday, June 30, 2005 4:09 PM
To: Gardner, Ben
Cc: Evgeniy Polyakov; LM Sensors
Subject: Re: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433

Hi Ben,

> w1-slave-sysfs.diff
> Every slave now has at least two sysfs files:
>  - id : an 8 byte binary file that holds the 64 bit id
>    example: [23 6c dc 1c 00 00 00 43]

I see no reason why this should be a binary file. Please make it a text
file. Binary files in sysfs are supposed to be an exception, not the
rule.

Thanks,
-- 
Jean Delvare


