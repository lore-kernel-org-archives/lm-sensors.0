From: com.ea@tinet.org (com.ea)
Date: Tue, 18 Jul 2006 19:00:23 +0000
Subject: [lm-sensors] Looking for testers
Message-Id: <anbqb2pn3gkfo0ptrai3265k1onkmhfk8j@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7askb297uvn6b7mo7tt48t0a9km8ipusbc@4ax.com>
In-Reply-To: <7askb297uvn6b7mo7tt48t0a9km8ipusbc@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Hi Carlos:
>
>* com. ea <com.ea at tinet.org> [2006-07-16 19:24:08 +0200]:
>> I am looking for testers of a fan/temperature control application.
>> This application allows the user to set a safe range of temperature and fan speed.
>> 
>> The application has been widely tested because it was written 2 years ago, 
>> but it used its own driver to read/write the hardware monitor (w83697hf).
>> 
>> I rewrote it to make use of libsensors and lm-sensors drivers. The idea is to
>> support all the chips able to provide 'changeable' pwm or dc output.
>> 
>> At the moment I have done the needed code for the kernel driver and libsensors 
>> to support the chips in the "w83627hf.c" driver (for 2.4 and 2.6 kernels)
>> 
>> I would like to find people with any of the following hardware monitors,
>> 
>> w83627hf
>> w83627thf
>> w83637hf
>> w83687thf
>> w83697hf <--- i got this one so no testing needed here
>> 
>> Testers interested should contact me at com.ea at tinet.org ,
>> I will supply the patches for libsensors / kernel drivers and the control application.
>> 
>> I will upload the new patches to the list as soon as they have been tested.
>
>I have a w83627thf here... but I won't have time to test until I get back
>from OLS this week.  Why don't you just post a link to your code, if you
>think the whole thing is not ready for review yet?
>
>Regards,

Hey I have just finished the new homepage.
You can find it here:

http://www.tinet.org/~com.ea/rtsensors/

If you own a w83627hf or a w83637hf and want to provide testing, then contact me.


Regards
Carlos


