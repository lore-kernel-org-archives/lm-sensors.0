From: Ioan Rusan <ionica@bolovan.homelinux.com>
Date: Mon, 12 Apr 2010 18:38:43 +0000
Subject: Re: [lm-sensors] Fancontrol script improvement
Message-Id: <4BC368B3.8020000@bolovan.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
In-Reply-To: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

unfortunately it will break compatibility with current config file.
I decided to rewrite in C for speed and flexibility (I want to make 
fancontrol to read hdd temperature. In my case, sometimes, hard drive is 
getting to hot and need a better ventilation...)
Any way, I will make the version in C. If community want to use 
this...is ok...if not...is ok for me.

current config is look something like this:
SENSOR=1
MIN_TEMPE
MAX_TEMP`
MIN_SPEED=0
TEMP_INPUT=/hwmon/hwmon3/device/temp1_input
OUTPUT_FAN=/hwmon/hwmon3/device/pwm1
INPUT_FAN=/hwmon/hwmon3/device/fan1_input
LINIAR_FAN=1
SENSOR=2
MIN_TEMP5
MAX_TEMPE
MIN_SPEED=0
TEMP_INPUT=/hwmon/hwmon3/device/temp2_input
OUTPUT_FAN=/hwmon/hwmon3/device/pwm2
INPUT_FAN=/hwmon/hwmon3/device/fan2_input
LINIAR_FAN=1


Martin Vool wrote:
> Hello,
>
> this is also a good idea, but what about the already existsing
> configuration files? This method would probably break already
> existsing fancontrol configurations?
> (i always could write my own python script, but i think the community
> prefers shell scripting for compatibility reasons?)
>
> Anyways i thought that just a simple patch by someone who does
> shellscripting would be very cool :-)
>
>
> Martin
>
> On Mon, Apr 12, 2010 at 8:09 PM, Ioan Rusan
> <ionica@bolovan.homelinux.com> wrote:
>   
>> Hello
>>
>> I am currently ported in C language.
>> this it will be the next issue.
>> my ideea was to make something like this (tell me it you like)
>> input0=temp1_input;min_temp=N;max_temp=N
>> input1=temp2_input;trigger_temp=N
>> inputN= temp2_input;trigger_temp=N
>>
>>
>> Martin Vool wrote:
>>     
>>> Hello,
>>>
>>> i am writing to you because i want to ask you what do you think of my
>>> idea.
>>> Currently i can assign only one temperature sensor to a fan. In my
>>> setup i need to monitor 2 sensors and set the fan speed accordingly to
>>> a single fan.
>>>
>>> It should not be very complicated to implement this, and implement it
>>> so that the old configuration is not deprecated, for example:
>>>
>>> ...
>>>
>>> FCTEMPS=hwmon0/device/pwm1=hwmon0/device/temp3_input:hwmon0/device/temp1_input
>>>  hwmon0/device/pwm2=hwmon0/device/temp2_input
>>> MINTEMP=hwmon0/device/pwm1E:50  hwmon0/device/pwm2@
>>> MAXTEMP=hwmon0/device/pwm1U:60  hwmon0/device/pwm2U
>>> ...
>>> or
>>> ...
>>> FCTEMPS=hwmon0/device/pwm1=hwmon0/device/temp3_input
>>> hwmon0/device/pwm1=hwmon0/device/temp1_input
>>> hwmon0/device/pwm2=hwmon0/device/temp2_input
>>> MINTEMP=hwmon0/device/pwm1E hwmon0/device/pwm1P  hwmon0/device/pwm2@
>>> MAXTEMP=hwmon0/device/pwm1U hwmon0/device/pwm1`  hwmon0/device/pwm2U
>>>
>>>
>>> i personally would prefer the first, since it is more clear on what is
>>> going on.
>>>
>>> When the script calculates the speeds it simply has to look what is
>>> the highest RPM required for the monitored sensor.
>>>
>>> Since i am not used to program in shellscripts i wanted to know if you
>>> would like to implement this? If not then i would give it a shot, but
>>> the code probably wouldn't be very pretty...
>>>
>>> What do you think?
>>>
>>>
>>> Martin Vool
>>>
>>> _______________________________________________
>>> lm-sensors mailing list
>>> lm-sensors@lm-sensors.org
>>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>>
>>>
>>>       
>>     
>
>
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
