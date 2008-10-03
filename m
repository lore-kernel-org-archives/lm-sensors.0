From: Frank Myhr <fmyhr@fhmtech.com>
Date: Fri, 03 Oct 2008 17:14:31 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <48E652F7.7030605@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean-Marc Spaggiari wrote:

>>> Regarding pwm4 and pwm5, I'm not really sure how to do 
>> Simplest and probably best to just ignore/don't worry about pwm4 and
>> pwm5 for now. Letting the user select pwm4 and pwm5 control will require
>> new sysfs attributes, there is currently no standard for these.
>> Something like:
>> pwm[4|5]_control
>>        which could take values [1|2|3]
>> But I haven't yet successfully used pwm control on fans 4 and 5 on my
>> boards, not yet sure it's possible, so it's probably premature to
>> consider new sysfs interfaces for potentially useless features.

To clear up some confusion (please see file sysfs-interface):
fan1_input thru fan5_input are measured fan rpms
pwm1 thru pwm5 are driving fan voltage pulse-width-modulation duty
cycles in range 0-255. (Some boards convert pwm to linearized dc voltage).


> When I force has_fan to 5 fans, I get:
> 
> fan1:       3000 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:       5973 RPM  (min =    0 RPM)
> fan4:         -1 RPM  (min =   -1 RPM)
> fan5:         -1 RPM  (min =   -1 RPM)
> 
> So can I just help him to read to pwm 4 and 5 correctly?

The -1 values you're reporting for fan4 and fan5 come from
#define FAN16_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:1350000/((val)*2))

In other words, the 8720 reports "0", the above macro converts that to
-1. (I'm not entirely clear why this is done.)


> Regarding the resistors. should I publish the values? Or it's useless?

I think it would help at least other users of your board. Perhaps add it
 to Documentation/hwmon/it87 ?


-Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
