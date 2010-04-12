From: Martin Vool <mardicas@gmail.com>
Date: Mon, 12 Apr 2010 18:20:12 +0000
Subject: Re: [lm-sensors] Fancontrol script improvement
Message-Id: <x2u360a8e031004121120k4fc2f5fbl7338d6640b4a3efc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
In-Reply-To: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

this is also a good idea, but what about the already existsing
configuration files? This method would probably break already
existsing fancontrol configurations?
(i always could write my own python script, but i think the community
prefers shell scripting for compatibility reasons?)

Anyways i thought that just a simple patch by someone who does
shellscripting would be very cool :-)


Martin

On Mon, Apr 12, 2010 at 8:09 PM, Ioan Rusan
<ionica@bolovan.homelinux.com> wrote:
> Hello
>
> I am currently ported in C language.
> this it will be the next issue.
> my ideea was to make something like this (tell me it you like)
> input0=3Dtemp1_input;min_temp=3DN;max_temp=3DN
> input1=3Dtemp2_input;trigger_temp=3DN
> inputN=3D temp2_input;trigger_temp=3DN
>
>
> Martin Vool wrote:
>>
>> Hello,
>>
>> i am writing to you because i want to ask you what do you think of my
>> idea.
>> Currently i can assign only one temperature sensor to a fan. In my
>> setup i need to monitor 2 sensors and set the fan speed accordingly to
>> a single fan.
>>
>> It should not be very complicated to implement this, and implement it
>> so that the old configuration is not deprecated, for example:
>>
>> ...
>>
>> FCTEMPS=3Dhwmon0/device/pwm1=3Dhwmon0/device/temp3_input:hwmon0/device/t=
emp1_input
>> =A0hwmon0/device/pwm2=3Dhwmon0/device/temp2_input
>> MINTEMP=3Dhwmon0/device/pwm1E:50 =A0hwmon0/device/pwm2@
>> MAXTEMP=3Dhwmon0/device/pwm1U:60 =A0hwmon0/device/pwm2U
>> ...
>> or
>> ...
>> FCTEMPS=3Dhwmon0/device/pwm1=3Dhwmon0/device/temp3_input
>> hwmon0/device/pwm1=3Dhwmon0/device/temp1_input
>> hwmon0/device/pwm2=3Dhwmon0/device/temp2_input
>> MINTEMP=3Dhwmon0/device/pwm1E hwmon0/device/pwm1P =A0hwmon0/device/pwm2@
>> MAXTEMP=3Dhwmon0/device/pwm1U hwmon0/device/pwm1` =A0hwmon0/device/pwm2U
>>
>>
>> i personally would prefer the first, since it is more clear on what is
>> going on.
>>
>> When the script calculates the speeds it simply has to look what is
>> the highest RPM required for the monitored sensor.
>>
>> Since i am not used to program in shellscripts i wanted to know if you
>> would like to implement this? If not then i would give it a shot, but
>> the code probably wouldn't be very pretty...
>>
>> What do you think?
>>
>>
>> Martin Vool
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>>
>
>



--=20

Martin Vool
Privaat Disain O=DC
Tel. +372 555 69 474
martin@privaatdisain.ee
www.privaatdisain.ee

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
