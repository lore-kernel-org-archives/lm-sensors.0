From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm registers
Message-Id: <FJEPJHGHDGKMMPFFGCLOGEPMEHAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi all,

I had some mail problems the last 2 days so now have 5 or 6 mails on the
asus sensor chip.

the AS99127F has only 3 temp sensors, the ASB100 has 4 and the Mozart has
only 2, so I think your detection is wrong and you think your reading a 127F
while it's a ASB100.

So I will just include what I know and what works perfect for all mbm user
so far:

- before all detections I do:  IOByte($4E,$00,IOWrite);  so set any bank
there might be to 00

AS99127F_1 & AS99127F_2 & ASB100:
- scan smbus between $29 and $2F
- if register $58 holds $31 then we have an asus (either ASB100 or AS99127F)
- if (IOByte($4F,$0,IORead)=$94) or (IOByte($4F,$0,IORead)=$06) then ASB100
- if (IOByte($4F,$0,IORead)=$12) or (IOByte($4F,$0,IORead)=$C3) then
AS99127F_1
- if (IOByte($4F,$0,IORead)=$5C) or (IOByte($4F,$0,IORead)=$A3) then
AS99127F_2

Mozart2:
- scan smbus on $77
- if register $58 holds $56 or $10 then we are talking Mozart2
- of the mozart there are 3 types:
- //Asus ASM58 Mozart-2            $58=$56 $4E=$94 $4F=$36
- //Asus AS2K129R Mozart-2         $58=$56 $4E=$94 $4F=$06
- //Asus XXXXXXXX Mozart-2         $58=$10 $4E=$5C $4F=$A3
- you can handle all 3 the exact same way!!!!!

so that is detection, next temp sensors:

ASB100:
- no diode selection option like the winbonds have
- sensor 1: offset $27 of the sensor chip
- sensor 2 & 3 are the 2 LM75's on the smbus
- sensor 4: offset $17 of the sensor chip
- remark: I noticed that on intel boards sensor 2 is used for the cpu and 4
is ignored/stuck, on amd boards sensor 4 is the cpu and sensor 2 is either
ignored or a socket temp

AS99127F_1 & AS99127F_2:
- no diode selection option like the winbonds have
- they have both are the same temperature wise
- sensor 1: offset $27 of the sensor chip
- sensor 2 & 3 are the 2 LM75's on the smbus

Mozart2:
- no diode selection option like the winbonds have
- sensor 1: offset $27 of the sensor chip
- sensor 2: offset $13 of the sensor chip

then we get the fan sensors:

ASB100:
- 3 fans, identical to the W83781D

AS99127F_1 & AS99127F_2:
- 3 fans, identical to the W83781D

Mozart2:
- 2 fans:
- fan 1: offset $28,  divisor on $A1,  divisor mask $30,  shr 4,  1350000 /
rpm / div
- fan 2: offset $29,  divisor on $A1,  divisor mask $C0,  shr 6,  1350000 /
rpm / div

and finally the voltages, this is where there is a diffrence between the 2
AS99127F versions:

ASB100:
V0V1=$20*0.016
V0V2=$21*0.016
V0V3=$22*0.016
V0V4=$23*0.016*1.68
V0V5=$24*0.016*3.8
V0V6=($25*(-0.016))*3.97
V0V7=($26*(-0.016))*1.666

AS99127F_1:
V0=AS99127F Standard 1
V0V1=$20*0.016
V0V2=$21*0.016
V0V3=$22*0.016
V0V4=$23*0.016*1.68
V0V5=$24*0.016*3.8
V0V6=($25*(-0.016))*3.97
V0V7=($26*(-0.016))*1.503

AS99127F_2:
V1=AS99127F Standard 2
V1V1=$20*0.016
V1V2=$21*0.016
V1V3=$22*0.016
V1V4=$23*0.016*1.68
V1V5=$24*0.016*3.8
V1V6=(($25*0.016)-3.6)*5.14+3.6
V1V7=(($26*0.016)-3.6)*3.14+3.6

Mozart2:
V0=Mozart2 Standard
V0V1=$20*0.016
V0V2%5
V0V3=$22*0.016
V0V4=$23*0.016*1.68
V0V5=$24*0.016*4
V0V6%5
V0V7%5

I have send a lot of info in the last month to lm_sensor users, so it's not
always clear to me who is asking this for lm_sensor or for himselves.  so if
possible maybe post this somewhere on your site/forum/anything so I can
direct requests from lm_sensor users to it.

The Asus boards are the most populair so I can say for 99.999% that the
above is correct, there "might" be a diode selection possible but never used
by Asus so far.  and believe me, if it's wrong people know my e-mail adres
very well ;)

please let me know if this was usefull and if you posted it so I have the
url :)

if you have more questions feel free to ask


Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------
