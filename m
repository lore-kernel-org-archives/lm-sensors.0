From: w.newell@verizon.net (Wes Newell)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <40F79EFF.30106@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F5A42D.9070301@verizon.net>
In-Reply-To: <40F5A42D.9070301@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>I tried 1, 2, 3, and 2345, or something like that out of
>>rustration.:-) here's what I get trying the diodes (3).
>>
>>Temp1:       +70?C  (low  =   +20?C, high =   +70?C)   sensor = invalid
>>Temp/MB:     +29?C  (low  =   +25?C, high =   +45?C)   sensor = invalid
>>Temp/CPU:    +21?C  (low  =   +15?C, high =   +60?C)   sensor = invalid
>>    
>>
>
>The "sensor = invalid" is exactly what was fixed in 2.8.5's "sensors".
>
>That's just a matter of displaying the correct string however; it has
>obviously no effect on the values.
>
>The driver itself had some changes though. As said earlier, I doubt
>it'll change anything, but that may still be wyrth trying.
>
>You don't use the reset_it87 module parameter, do you?
>
>  
>
I don't even know what it is.:-)

>If you run Windows, I'd be interested in you trying Motherboad Monitor
>as a replacement for the ITE's tool, and tell me how it works. If Alex
>managed to handle your case, he will probably help us.
>
>  
>
OK, I thought I had tried all combos in MBM, but I guess not. Set to 
sensor 1-diode works for the cpu temp in MBM. I verified this by making 
the temps go up and down  and checking the time it took vs Smartguardian 
and they were basically the same. My boards not in the MBM database 
either so I just picked a K7S5A I think to start with, but I don't 
recall for sure. It's been a few months and I don't normally run win. 
Now for the bad part. I changed to set sensor1 3 in sensors.conf and 
then set it with -s. Still read 70C. So I lowered that with a -35 offset 
to get it to 35 which I know is very close to the normal idle temp. I 
then turned the fan off expecting the temps to start rising. They never 
did, so I either missed something or there's another problem somewhere. 
So, either way I set sensor1 it was the same. no rise in temps with fan 
off. What's wierd is that when set to thermisor, it rises 1C when I run 
glxgears and load the cpu to about 50%. Now that seems real strange to 
me. At this point, I'm going to update from 2.8.4 to 2.8.7 and see what 
happens.
