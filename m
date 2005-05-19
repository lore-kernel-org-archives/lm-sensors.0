From: hector@marcansoft.com (=?ISO-8859-1?Q?H=E9ctor_Mart=EDn?=)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: as99127f PWM kinda working
Message-Id: <40B9DDDA.2050401@marcansoft.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A74A47.6010601@marcansoft.com>
In-Reply-To: <40A74A47.6010601@marcansoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the long wait, I upgraded my kernel (2.6.3 to 2.6.5) and had 
some problems with other stuff not related to lm-sensors, and I almost 
completely forgot about this e-mail. By the way, forget about those "2.6 
problems", everything works now (misconfiguration on my part, duh)

I read your information and it's very similar, although as you mentioned 
results seem to vary depending on the order that you set the values. 
PWM2 does nothing, but neither it did with Speedfan; I think it's just 
not connected with any fan, since PWM1 controls ALL fans at once (except 
obviosly the PowerSupply fan, unless I plug it in into the mobo's own PS 
fan header). Anyway it does look like PWM2, since it's default is also 0x8f

I agree that a new as99127f driver shoud be made, given the increasing 
number of differences with the Winbond chips.

Sensors-detect tells me I have a rev.1 chip:
Probing for `Asus AS99127F (rev.1)'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Asus AS99127F (rev.2)'... Failed!

i2cdump tells me that the default value for 0x59 is 0x8f (without having 
touched it since bootup) which seems to prove that the normal 
configuration is Bit8: set and bits 0-3: PWM value. I also observed that 
the other bits have no effect, but 0-3 have the effect that I described 
(i.e. 0x91 is still fans off, whereas 0x89 is full on since it's >0x84)

when bit 8 is clear, I have observed several effects, for example, afer 
0x81(or 0x91, etc.), 0x00 gradually started the fans as if 
0x81-0x82-0x83-0x84 were written in succession after some seconds each. 
If tha value before 0x00 is 0x83 for example, it increments to full 
speed (which would be 0x84), which leads me to think 0x00 gradually 
increments the fan's speed. Note the actual read value stays at 0x00, 
which definitely means there is some internal (or public through 
smbus?!? I have to check out if some other register changes) counter, at 
the very least. Just now it has been running at 0x00 with no speed 
change whatsoever afer going up to max speed, so I guess it just 
increases and afterwards stays there.

The results with bit 8 set have been normal and stable AFAIK, except 
0x80. I'll leave it a while there to see if it does something. Hopefuly 
It won't burn my Athlon lol. Currently it's still off, I'm setting it 
back on before something starts to smoke, and I'll connect my fan to 
+12V and leave a test fan there so I don't worry about my CPU getting fried.

CPU Temp:  +72.5?C - Whoah, better be safe than sorry...

BTW, I didn't mention 0x83 before, it's just an intermediate value, say 
70% speed.

My real name is H?ctor, I had my new accounts half set-up still and 
that's why you got that From: name. I'll be sending email from this 
account from now on. I don't like my nick on things like this, it makes 
me feel that people are going to think that I'm afraid to say my name or 
something heh heh.

Please tell me your results with these and other values, so we can make 
some tests to find out what exactly does what.

Jean Delvare wrote:

>>Hi! I've been fiddling around with the (in)famous 0x59 register and 
>>found out the following values do work as a form of coarse pwm:
>>
>>0x80 - seems to turn fans off after some time(1-2 minutes)... might
>>be some form of auto-fan-control based on temp? hmm (Qfan? this mobo
>>is an old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attemp
>>at Qfan that was dropped at the BIOS)
>>0x81 - off
>>0x82 - slightly "on-ner" than off, but my fans do not get to move. I
>>can hear the high-pitched PWM sound that motors give off at
>>too-low-pwm. 0x83 - now they do move. Estimate about 70% speed or so.
>>0x84-0x8f - full on
>>
>>Changing the high nibble doesn't seem to do much except the high bit 
>>(0x80) must be set for PWM to work, else the current pwm doesn't seem
>>to change.
>>    
>>
>
>This more or less corroborates what I observed mysef and summuarized at
>the end of the w83781d driver documentation here:
>http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d
>
>There are a few differences though.
>
>1* When the high bit is clear, I would observe speed changes (different
>from when high bit is set).
>
>2* When high bit is set, my results differ from yours. For one thing I
>was never able to turn the fan completely off.
>
>What we definitely agree on is that the high bit sets a kind of mode and
>bits 6-4 don't matter when high bit is set. We also agree on the fact
>than only a limited number speeds are possible.
>
>I invite you to read my summary and comment on it.
>
>I'll quote your report after mine in that document.
>
>  
>
>>My mobo is an ASUS A7V266-E. This behaviour is similar to what I got 
>>with speedfan under Windows, where 0-15% would be off, 15-2x% (can't 
>>remember the exact value) would be 70% and higher would be full on.
>>    
>>
>
>Is it a revision 1 or revision 2 chip? (sensors-detect should tell you)
>
>Did you tried playing with register 0x5A as well? It's suspected to be
>PWM2.
>
>In any case, I don't plan to implement PWM support for the as99127f. It
>would bloat the w83781d driver, so I think we would have to make the
>as99127f support move to a new driver. And I'm too busy with chips which
>have a datasheet to even think of worrying about chips with no datasheet
>available.
>
>  
>
>>If you need any more information please contact me! By the way,
>>thanks for making temperature readings working under Linux, now fix
>>those 2.6 kernel problems! ;)
>>    
>>
>
>Which problems are you referring to? 2.6 driver works well enough for
>me.
>
>Thanks.
>
>  
>
