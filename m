From: =?ISO-8859-1?Q?Hajdu_Tam=E1s_M=E1rk?= <fathom@sirc.hu>
Date: Wed, 27 Mar 2013 17:14:07 +0000
Subject: Re: [lm-sensors] Gigabyte E240N, it87 module, fan speed control not working, readings may bad
Message-Id: <515328DF.4080809@sirc.hu>
List-Id: <lm-sensors.vger.kernel.org>
References: <51522BDC.6070103@sirc.hu>
In-Reply-To: <51522BDC.6070103@sirc.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

If it is not connected shouldn't it report N/A or something like that?=20
Also it is strange the out of 3 temp sensors the second one shows -70=20
degrees:
# cat /sys/class/hwmon/hwmon1/device/temp1_input
33000
# cat /sys/class/hwmon/hwmon1/device/temp2_input
-70000
# cat /sys/class/hwmon/hwmon1/device/temp3_input
46000
If I get the meaning of the readings well, that 46 Celsius is the core=20
temperature. It would be a bit surprising if that is true, cause there=20
is no load on the machine and the CPU is taken back to 750 Mhz, I would=20
expect a lower value there too.

The pwmX_enable values are 0,2,2 though I can echo anything to it, I=20
can't make the fan stop or change it's speed.

The reason I want to this is that I have made a special case for the=20
machine and the fan I have connected to the system fan is only=20
responsible for HDD cooling, it should controlled by the hddtemp values.=20
But anyway it would be better to have control over the cpu cooling as=20
well cause I think it is overcooled now, which is simply wasting energy.

Cheers,
Tam=E1s


2013-03-27 03:24 keltez=E9ssel, Guenter Roeck =EDrta:
> On Wed, Mar 27, 2013 at 12:14:36AM +0100, Hajdu Tam=E1s M=E1rk wrote:
>> Hi,
>>
>> I have a Gigabyte E240N mainboard (integrated amd cpu and gpu),
>> which by pwmconfig reported to use it87 module. This is for first
>> sight works, but one out of 3 temperature reading is always -70
>> degrees (though it is the temp3, which I don't know what), other two
> Most likely it is not connected to anything.
>
>> seems to good. Also the fan speed readings seems to be ok (I am not
>> 100% sure). What it really does, that hwmon1 is created and there
>> are changing values so at least it is partially working.
>> I have tried to use pwmconfig to configure and also tried to echo
>> values I could think of, but I could not set (nor pwmconfig could)
>> it's speed.
> Fan control may be in automatic mode. That is the case if pwmX_enable
> returns 2. If so, you are most likely better off by leaving it alone.
>
> Guenter
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
