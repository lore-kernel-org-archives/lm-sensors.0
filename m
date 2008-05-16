From: "Oliver Pinter" <oliver.pntr@gmail.com>
Date: Fri, 16 May 2008 13:45:01 +0000
Subject: Re: [lm-sensors] Bad value with w83627thf
Message-Id: <6101e8c40805160645x5982d5ads61a422f5600f7507@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6101e8c40805160559i4eb94ba7y7cbfea9c3f528821@mail.gmail.com>
	 <20080516152712.629606bf@hyperion.delvare>
In-Reply-To: <20080516152712.629606bf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org

Hi Jean!

sorry for the bad ML.

the battery is CR2032, and it is 3V, im older kernel alway reported
bad value 0,02V or 2,4V (i think it is a possible value), after i
inserted new battery, show 2,4V.
from the 2.6.26-rcX kernel showed the 3+ V. when i reboot to older
kernel, the this state remained, but when turned off the pc, then not.


On 5/16/08, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Oliver,
>
> You are writing to the wrong mailing list (i2c instead of lm-sensors)
> so I am redirecting.
>
> On Fri, 16 May 2008 14:59:21 +0200, Oliver Pinter wrote:
>> linux-2.6 - git HEAD on: 9662369
>> lm-sensors: 1:3.0.1-5
>> libsensors4: 1:3.0.1-5
>> os: debian lenny
>> sernsor: w83627thf on asus p4c800 MB
>>
>> with 2.6.26-rcX kernel, reported false Battery values,
>> -------------------------------------->
>> VBat:        +3.26 V  (min =  +0.02 V, max =  +3.01 V)   ALARM
>> <-------------------------------------
>
> There is nothing wrong here. +3.26V sounds possible and correct for the
> battery voltage. If you are worried about the min and max values: it is
> up to you to edit your sensors3.conf file to set them properly if the
> BIOS of your motherboard did not (apply the changes with "sensors -s").
> The alarm will go away when you do.
>
>> lspci -xxx
>> 00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
>> Controller (rev 02)
>> 00: 86 80 d3 24 01 00 80 02 02 00 05 0c 00 00 00 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 01 04 00 00 00 00 00 00 00 00 00 00 43 10 a6 80
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 00
>> 40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 66 0f 04 00 00 00 00 00
>
> Completely irrelevant here, the Winbond W83627THF is an LPC chip, it
> doesn't have an I2C/SMBus interface, so the SMBus controller doesn't
> matter at all.
>
> --
> Jean Delvare
>


-- 
Thanks,
Oliver

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
