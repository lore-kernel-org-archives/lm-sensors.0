From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Tue, 27 Feb 2007 16:08:11 +0000
Subject: [lm-sensors] hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <45E4576B.9000909@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Jean Delvare wrote:
>> Same problem as some time ago when
>> Rudolf Marek wrote:
>>> Please apply it and see the system log for result. (and of course mail it back)
>> I now have a VIA Epia EN12000 which shows in dmesg:
>>
>> hwmon-vid: Unknown VRM version of your x86 CPU
>>
>> # cat /proc/cpuinfo
>> processor       : 0
>> vendor_id       : CentaurHauls
>> cpu family      : 6
>> model           : 10
>> model name      : VIA Esther processor 1200MHz
(....)
> Indeed we do not support this CPU family at the moment.

OK. It can be fixed?

>> Need more info?
> 
> We'd need to know which VRM standard this CPU wants. Which hardware
> monitoring chip and driver are you using? 

driver w83627hf
chip w83697hf

> Can you try different VRM
> standards and see if one appears to match the expected CPU core voltage?

EPIA-EN Operating Guide v.1.10.pdf says that this CPU uses 1.004v at 1.2
GHz. I measure  +0.83V, though.
How can I try a different VRM?


Kind regards,
Udo

