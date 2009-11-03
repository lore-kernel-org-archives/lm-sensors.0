From: "Nicolas Krzywinski" <lists@site7even.de>
Date: Tue, 03 Nov 2009 17:33:23 +0000
Subject: Re: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision! SMBus may
Message-Id: <op.u2txpxg85kimqn@sesta09.lan7even>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.u0bhncaa5kimqn@sesta09.lan7even>
In-Reply-To: <op.u0bhncaa5kimqn@sesta09.lan7even>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

thank you for your answers!

You are right in all points - first of all with the kernel version that is =
=20
Linux version 2.6.26-2-amd64

I discovered, that I commented out the lm78 module already, so this is =20
solved. Further I saw the ipmi-si entry as you predicted.
Because I am lazy, I stick to the debian package rollouts of new software  =

versions whenever possible. Due to no loss of functionality and the =20
harmless reason of the message you kindly explained, I will simply wait =20
for updates.


I thank you for your support, most important is to know what's going on.

Regards,
Nicolas



Am 01.11.2009, 10:23 Uhr, schrieb Jean Delvare <khali@linux-fr.org>:

> Hi Nicolas,
>
> On Tue, 15 Sep 2009 23:22:14 +0200, Nicolas Krzywinski wrote:
>> just another desparate user that wrung out lm-sensors.org, Google & Co. =
=20
>> ;-)
>>
>> First of all: I don't really have a problem, because lm-sensors work on =
=20
>> my
>> baby
>> But: There is some spamming in the kernel log (see subject and below)
>>
>> -----
>>
>> Now lets hear the details:
>>
>> My system:
>> 1x Intel Xeon DP E5506
>> ..on Tyan S7002WGM2NR-LE (one CPU slot free)
>> ..using KVR1066D3Q8R7SK3/12G as short-term memory
>> ..with several SATA drives attached
>> ..running Debian 2.6.26-17lenny2
>>
>> As far as I understand aptitude, I installed:
>> lm-sensors 3.0.2-1+b2
>> ..with libc6 2.7-18
>> ..and libsensors4 3.0.2-1+b2
>> ..and perl 5.10.0-19lenny2
>> ..and sed 4.1.5-6
>
> What about the kernel version? That's all what really matters here.
>
>>
>> -----
>>
>> What I modified in sensors3.conf:
>>
>> [..]
>> chip "lm78-*" "lm79-*" "w83781d-*"
>> [..]
>>     ignore in0
>>     ignore in1
>>     ignore in2
>>     ignore in3
>>     ignore in4
>>     ignore in5
>>     ignore in6
>> [..]
>>      ignore fan1
>>      ignore fan2
>>      ignore fan3
>>
>>     ignore temp1
>>     ignore cpu0_vid
>> [..]
>> chip "w83793-*"
>> [..]
>>     ignore fan6
>>     ignore fan7
>>     ignore fan8
>>     ignore fan9
>>     ignore fan10
>>     ignore fan11
>>     ignore fan12
>>
>>     # This we have to reactivate when there is a second cpu installed..
>>     ignore temp2
>>     ignore temp5
>> [..]
>>
>> Remarks: ignored anything from lm78.. because I got only rubbish from
>> there - but Winbond works fine, nothing more that I need.
>
> Most probably because you don't have an LM78 and that would be a
> misdetection. I remember we have a lot of these some times ago, but
> this should be fixed since kernel 2.6.28 and lm-sensors 3.0.3.
>
> Anyway, instead of ignoring everything, you'd rather simply _not_ load
> the lm78 kernel module.
>
>>
>> -----
>>
>> Output of "sensors" command gives me pretty good values (except min/max
>> but I'm not keen on that):
>>
>> me@myserver:~$ sensors
>> lm78-i2c-0-2d
>> Adapter: SMBus I801 adapter at 0400
>>
>> w83793-i2c-0-2f
>> Adapter: SMBus I801 adapter at 0400
>> VCoreA:      +1.21 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>> VCoreB:      +0.00 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>> Vtt:         +1.09 V  (min =3D  +0.00 V, max =3D  +2.05 V)
>> in3:         +1.47 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> in4:         +1.07 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> +3.3V:       +3.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> +12V:       +11.71 V  (min =3D  +0.00 V, max =3D +24.48 V)
>> +5V:         +4.90 V  (min =3D  +0.15 V, max =3D  +6.27 V)
>> 5VSB:        +4.88 V  (min =3D  +0.15 V, max =3D  +6.27 V)
>> VBAT:        +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> fan1:        525 RPM  (min =3D    0 RPM)
>> fan2:          0 RPM  (min =3D    0 RPM)
>> fan3:        775 RPM  (min =3D    0 RPM)
>> fan4:       1131 RPM  (min =3D    0 RPM)
>> fan5:        703 RPM  (min =3D    0 RPM)
>> CPU1 Temp:   +71.2=B0C  (high =3D +100.0=B0C, hyst =3D +95.0=B0C)  senso=
r =3D Intel =20
>> PECI
>> temp6:       +49.0=B0C  (high =3D +100.0=B0C, hyst =3D +95.0=B0C)  senso=
r =3D =20
>> thermistor
>> beep_enable:disabled
>>
>> Remarks: don't wonder CPU temp, this is fully on load for more than 2 =20
>> days
>> now ;-)
>>
>> -----
>>
>> Now, all that I need works thats good ... but lets have a look at my
>> kernel log:
>>
>> me@myserver:~$ tail /var/log/kern.log
>> Sep 15 21:49:59 server7even3 kernel: [2670913.842602] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 22:13:48 server7even3 kernel: [2672347.037041] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 22:20:55 server7even3 kernel: [2672775.506601] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 22:28:04 server7even3 kernel: [2673204.696425] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 22:31:39 server7even3 kernel: [2673420.968805] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 22:37:15 server7even3 kernel: [2673757.521883] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 23:01:02 server7even3 kernel: [2675186.137306] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 23:03:58 server7even3 kernel: [2675362.459786] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 23:07:30 server7even3 kernel: [2675574.876593] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>> Sep 15 23:09:01 server7even3 kernel: [2675666.787660] i801_smbus
>> 0000:00:1f.3: Bus collision! SMBus may be locked until next hard reset.
>> (sorry!)
>
> This message is needlessly alarming. What really happened is that the
> Intel 82801 was not able to claim mastership of the SMBus, because
> someone else is using it. Maybe you have a BMC module connected to this
> motherboard? Are you using IPMI tools somehow? In this case, with older
> kernels, the transaction simply fails, so you get transient errors. As
> the w83793 driver apparently doesn't handle them properly,
>
> The message was fixed in kernel 2.6.27. Since kernel 2.6.31, the failed
> transaction is also retried automatically if the adapter asks for it,
> but the i2c-i801 driver doesn't. This should be added. In the meantime
> it is possible to set the retry count from user-space using the i2c-dev
> driver.
>
>> I do not really get to the point on what is causing those messages,
>> because:
>> - I got readings (any other occurrence of this message I found got no
>> sensor readings)
>> - I added only "ignores" to sensors3.conf (did I confused the kernel
>> because I ignored anything from lm78??)
>
> No, the kernel messages are unrelated to sensors3.conf.
>
>> - There is no time schema I can identify, the messages seem to occur
>> really arbitrary
>>
>>
>> What I did not do until now (I apologize, but have reasons):
>> - Restart of system (I don't want to restart because I think that =20
>> message
>> will come back)
>> - stopped sensord (because of the need to monitor the cpu temp, you =20
>> know..)
>>
>>
>> Further:
>> - I installed phpsysinfo as well. Anything evil with that maybe?
>
> No, phpsysinfo merely runs "sensors" and parses its output, it doesn't
> so anything you aren't already doing yourself.
>
>> Long story, short question: any hints?
>
> Upgrade to kernel >=3D 2.6.28, stop loading the lm78 kernel module.
> Upgrade to lm-sensors >=3D 3.0.3 and run sensors-detect again, you might
> get more sensors values from another monitoring chip.
>


--=20
Bleibend ist immer das Sinnbild - nie das Abbild (Hermann Hesse).

http://www.site7even.de | http://www.nskcomputing.de

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
