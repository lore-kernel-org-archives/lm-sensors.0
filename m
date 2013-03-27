From: =?ISO-8859-1?Q?Hajdu_Tam=E1s_M=E1rk?= <fathom@sirc.hu>
Date: Wed, 27 Mar 2013 20:27:45 +0000
Subject: Re: [lm-sensors] Gigabyte E240N, it87 module, fan speed control not working, readings may bad
Message-Id: <51535641.8090101@sirc.hu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9039876856705991785=="
List-Id: <lm-sensors.vger.kernel.org>
References: <51522BDC.6070103@sirc.hu>
In-Reply-To: <51522BDC.6070103@sirc.hu>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============9039876856705991785==
Content-Type: multipart/alternative;
 boundary="------------040901070308090101060309"

This is a multi-part message in MIME format.
--------------040901070308090101060309
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the info, maybe I just needed to write it down to really get=20
it working:)
I have figured it out that system fan is pwm2 (maybe it's temp shows=20
-70, because there is no system thermometer) and after enable is set to=20
1 it is controllable via pwm2, so now I can write a script that reads=20
hddtemp and set's it to the right value.

Thanks!
Tam=E1s

2013-03-27 19:29 keltez=E9ssel, Guenter Roeck =EDrta:
> On Wed, Mar 27, 2013 at 06:14:07PM +0100, Hajdu Tam=E1s M=E1rk wrote:
>> Hi,
>>
>> If it is not connected shouldn't it report N/A or something like
>> that? Also it is strange the out of 3 temp sensors the second one
> How would it know ? That is why the configuration file supports the "igno=
re"
> statement. Also, why is it strange ? There is no requirement that a board=
 vendor
> MUST connect sensors in a certain order.
>
>> shows -70 degrees:
>> # cat /sys/class/hwmon/hwmon1/device/temp1_input
>> 33000
>> # cat /sys/class/hwmon/hwmon1/device/temp2_input
>> -70000
>> # cat /sys/class/hwmon/hwmon1/device/temp3_input
>> 46000
>> If I get the meaning of the readings well, that 46 Celsius is the
>> core temperature. It would be a bit surprising if that is true,
>> cause there is no load on the machine and the CPU is taken back to
>> 750 Mhz, I would expect a lower value there too.
>>
> That really depends on your CPU. Yo could try to compare it with the outp=
ut
> of the core temperature sensor if your CPU supports one.
>
>> The pwmX_enable values are 0,2,2 though I can echo anything to it, I
>> can't make the fan stop or change it's speed.
>>
> Setting a value to 1 should enable manual control. 2 is automatic, 0 turn=
s it
> off entirely. CPU fans can not be turned off, so if one fan is the CPU fan
> it would not be surprising that it can not be turned off.
>
>> The reason I want to this is that I have made a special case for the
>> machine and the fan I have connected to the system fan is only
>> responsible for HDD cooling, it should controlled by the hddtemp
>> values. But anyway it would be better to have control over the cpu
>> cooling as well cause I think it is overcooled now, which is simply
>> wasting energy.
>>
>> Cheers,
>> Tam=E1s
>>
>>
>> 2013-03-27 03:24 keltez=E9ssel, Guenter Roeck =EDrta:
>>> On Wed, Mar 27, 2013 at 12:14:36AM +0100, Hajdu Tam=E1s M=E1rk wrote:
>>>> Hi,
>>>>
>>>> I have a Gigabyte E240N mainboard (integrated amd cpu and gpu),
>>>> which by pwmconfig reported to use it87 module. This is for first
>>>> sight works, but one out of 3 temperature reading is always -70
>>>> degrees (though it is the temp3, which I don't know what), other two
>>> Most likely it is not connected to anything.
>>>
>>>> seems to good. Also the fan speed readings seems to be ok (I am not
>>>> 100% sure). What it really does, that hwmon1 is created and there
>>>> are changing values so at least it is partially working.
>>>> I have tried to use pwmconfig to configure and also tried to echo
>>>> values I could think of, but I could not set (nor pwmconfig could)
>>>> it's speed.
>>> Fan control may be in automatic mode. That is the case if pwmX_enable
>>> returns 2. If so, you are most likely better off by leaving it alone.
>>>
>>> Guenter
>>>
>>


--=20
=DCdv: *Tam=E1s*.

--------------040901070308090101060309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi, <br>
      <br>
      Thanks for the info, maybe I just needed to write it down to
      really get it working:) <br>
      I have figured it out that system fan is pwm2 (maybe it's temp
      shows -70, because there is no system thermometer) and after
      enable is set to 1 it is controllable via pwm2, so now I can write
      a script that reads hddtemp and set's it to the right value.<br>
      <br>
      Thanks!<br>
      Tam&aacute;s<br>
      <br>
      2013-03-27 19:29 keltez&eacute;ssel, Guenter Roeck &iacute;rta:<br>
    </div>
    <blockquote cite="mid:20130327182927.GA22145@roeck-us.net"
      type="cite">
      <pre wrap="">On Wed, Mar 27, 2013 at 06:14:07PM +0100, Hajdu Tam&aacute;s M&aacute;rk wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi,

If it is not connected shouldn't it report N/A or something like
that? Also it is strange the out of 3 temp sensors the second one
</pre>
      </blockquote>
      <pre wrap="">
How would it know ? That is why the configuration file supports the "ignore"
statement. Also, why is it strange ? There is no requirement that a board vendor
MUST connect sensors in a certain order.

</pre>
      <blockquote type="cite">
        <pre wrap="">shows -70 degrees:
# cat /sys/class/hwmon/hwmon1/device/temp1_input
33000
# cat /sys/class/hwmon/hwmon1/device/temp2_input
-70000
# cat /sys/class/hwmon/hwmon1/device/temp3_input
46000
If I get the meaning of the readings well, that 46 Celsius is the
core temperature. It would be a bit surprising if that is true,
cause there is no load on the machine and the CPU is taken back to
750 Mhz, I would expect a lower value there too.

</pre>
      </blockquote>
      <pre wrap="">That really depends on your CPU. Yo could try to compare it with the output
of the core temperature sensor if your CPU supports one.

</pre>
      <blockquote type="cite">
        <pre wrap="">The pwmX_enable values are 0,2,2 though I can echo anything to it, I
can't make the fan stop or change it's speed.

</pre>
      </blockquote>
      <pre wrap="">Setting a value to 1 should enable manual control. 2 is automatic, 0 turns it
off entirely. CPU fans can not be turned off, so if one fan is the CPU fan
it would not be surprising that it can not be turned off.

</pre>
      <blockquote type="cite">
        <pre wrap="">The reason I want to this is that I have made a special case for the
machine and the fan I have connected to the system fan is only
responsible for HDD cooling, it should controlled by the hddtemp
values. But anyway it would be better to have control over the cpu
cooling as well cause I think it is overcooled now, which is simply
wasting energy.

Cheers,
Tam&aacute;s


2013-03-27 03:24 keltez&eacute;ssel, Guenter Roeck &iacute;rta:
</pre>
        <blockquote type="cite">
          <pre wrap="">On Wed, Mar 27, 2013 at 12:14:36AM +0100, Hajdu Tam&aacute;s M&aacute;rk wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">Hi,

I have a Gigabyte E240N mainboard (integrated amd cpu and gpu),
which by pwmconfig reported to use it87 module. This is for first
sight works, but one out of 3 temperature reading is always -70
degrees (though it is the temp3, which I don't know what), other two
</pre>
          </blockquote>
          <pre wrap="">Most likely it is not connected to anything.

</pre>
          <blockquote type="cite">
            <pre wrap="">seems to good. Also the fan speed readings seems to be ok (I am not
100% sure). What it really does, that hwmon1 is created and there
are changing values so at least it is partially working.
I have tried to use pwmconfig to configure and also tried to echo
values I could think of, but I could not set (nor pwmconfig could)
it's speed.
</pre>
          </blockquote>
          <pre wrap="">Fan control may be in automatic mode. That is the case if pwmX_enable
returns 2. If so, you are most likely better off by leaving it alone.

Guenter

</pre>
        </blockquote>
        <pre wrap="">

</pre>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
    <br>
    <div class="moz-signature">-- <br>
      &Uuml;dv: <b>Tam&aacute;s</b>.
    </div>
  </body>
</html>

--------------040901070308090101060309--


--===============9039876856705991785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9039876856705991785==--
