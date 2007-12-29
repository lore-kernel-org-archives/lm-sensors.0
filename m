From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 29 Dec 2007 20:25:55 +0000
Subject: Re: [lm-sensors] w83627dhg chip - stopping fan rotation?
Message-Id: <4776AD53.5030600@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Casper,

Please CC the list too.

Casper Gripenberg napsal(a):
>=20
> Hi,
>=20
> I'm kind of stuck with this fan problem, and I was wondering
> if anyone of you might know what the problem is, or where or
> how I could troubleshoot it further:
>=20
> I have an ASUS P5B-V mb with a W83627DHG chip. My lsmod
> says:
>=20
> w83627ehf              19984  0
> i2c_isa                 5248  1 w83627ehf
> i2c_core               26112  2 w83627ehf,i2c_isa
>=20
> I'm trying to stop the chassis fan, or actually any
> fan connected to the motheboard without much success.
> I tried to read the docs you wrote which say to write
> 0 into pwm[1-4] to get the fans to stop.
>=20
> So I do this:
>=20
>  > cd /sys/class/hwmon/hwmon0/device
>  > ls fan* pwm*
> fan1_alarm  fan3_input       pwm1_stop_time   pwm3
> fan1_div    fan3_min         pwm1_target      pwm3_enable
> fan1_input  fan5_alarm       pwm1_tolerance   pwm3_min_output
> fan1_min    fan5_div         pwm2             pwm3_mode
> fan2_alarm  fan5_input       pwm2_enable      pwm3_stop_time
> fan2_div    fan5_min         pwm2_min_output  pwm3_target
> fan2_input  pwm1             pwm2_mode        pwm3_tolerance
> fan2_min    pwm1_enable      pwm2_stop_time
> fan3_alarm  pwm1_min_output  pwm2_target
> fan3_div    pwm1_mode        pwm2_tolerance
>  > cat fan2_input
> 1132
>=20
> The speed looks correct. I have a large slow fan. Next:
>=20
>  > echo 0 > pwm1
>  > echo 0 > pwm2
>  > echo 0 > pwm3
>  > cat pwm1 pwm2 pwm3
> 0
> 0
> 0
>=20
> But the fans just keep on spinning. Why? Did I do something
> wrong or any ideas why I can't stop the fans? Can I somehow
> troubleshoot this further?

Perhaps you have still some kind of automatic mode maybe. What does
cat pwm?_enable print?

echo 1 > pwm1_enable will switch it to manual mode.

You need to set there manual mode first. Imho you can try first with pwmcon=
fig=20
script which is doing that for you. Addtitionally you may check documentati=
on=20
for the chip in kernel Documentation/hwmon/w83627ehf

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
;f=3DDocumentation/hwmon/w83627ehf;h=CCc2bcb610686aaf44a0d38c5f67db44e8985e=
82;hb=3DHEAD

Going for a holiday now, hope others will answer. Oh yeah I have written it=
 for=20
third time now ;)

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
