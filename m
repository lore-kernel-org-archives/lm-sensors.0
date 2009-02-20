From: Gabriel C <crazy@frugalware.org>
Date: Fri, 20 Feb 2009 13:20:05 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard and weird sensors output
Message-Id: <499EAE05.9040303@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <499372A3.6080803@frugalware.org>
In-Reply-To: <499372A3.6080803@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gabriel C wrote:

> Jean Delvare wrote:
> 
>> Hi Gabriel,
>>
>> On Wed, 18 Feb 2009 00:53:35 +0100, Gabriel C wrote:
>>> I've found the following Super-I/O chip on the mobo :
>>>
>>> Winbond WPCD377IAUFG
>>>
>>> So it seems you are right.
>> OK, thanks for reporting. I have just committed a fix to sensors-detect
>> so that it will differentiate between LM96000/PC8374L (have sensors)
>> and WPCD377I (no sensors) on the SMBus. Please give it a try:
>> http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> 
> 
> Thanks , I will test when I'm home and report back.

It does work for me , the new output is :

...

Probing for `National Semiconductor LM96000 or PC8374L'...  No
...

Probing for `Winbond WPCD377I'...                           Yes
    (confidence 7, not a hardware monitoring chip)

..

Jean it is possible these chips have something to do with Intel's QST ?


Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
