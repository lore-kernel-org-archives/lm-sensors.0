From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm registers
Message-Id: <FJEPJHGHDGKMMPFFGCLOIEPPEHAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722093411.25d749c5.khali@linux-fr.org>
In-Reply-To: <20030722093411.25d749c5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

Well if the MBM user base is any indication then there are no side-effects
using the bank switch, it did solve a lot of detection problems I got.  When
I 1st started using this there where a few issues with bios's that asumed
they where on bank 1 and did not check or put it to bank 1 after mbm set it
to 0, but have no encountered that in ages :)

correct, Mozart2 has no LM75's clones

thanks for the url, will save that.

as I said in the other mail, make sure you scan the primary ID (as I call
it) before the secondary 2, else one of the AS99127F will be a winbond in
your eyes

the voltages of MBM are in the voltage.ini so no code change needed either
and you can rip them out if you want/need them, there are a lot of board
specific voltages

more question... let me know

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



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: donderdag 24 juli 2003 14:59
To: MBM Support
Cc: sensors@Stimpy.netroedge.com
Subject: Re: as99127f pwm registers



> So I will just include what I know and what works perfect for all mbm
> user so far:
>
> - before all detections I do:  IOByte($4E,$00,IOWrite);  so set any
> bank there might be to 00

We don't do that. Maybe we should consider doing so. I guess this makes
identification easier. Are there any side effects?

On the other hand, our policy is that our detection script should never
write to the chips.

> AS99127F_1 & AS99127F_2 & ASB100:
> - scan smbus between $29 and $2F

We use the full original range ($20 to $2F). What makes you think the
range for the as99127f/asb100 is different? Shouldn't it be $28 to $2F
(3-bit address selection, 8 addresses)? Oh, BTW, I don't think we ever
saw these chips at any other address than $2d. Did you?

> - if register $58 holds $31 then we have an asus (either ASB100
>   or AS99127F
> - if (IOByte($4F,$0,IORead)=$94) or (IOByte($4F,$0,IORead)=$06)
>   then ASB100
> - if (IOByte($4F,$0,IORead)=$12) or (IOByte($4F,$0,IORead)=$C3)
>   then AS99127F_1

That's what we have.

> - if (IOByte($4F,$0,IORead)=$5C) or (IOByte($4F,$0,IORead)=$A3)
>   then AS99127F_2

We did not have this one, I'll add it.

> Mozart2:
> - scan smbus on $77
> - if register $58 holds $56 or $10 then we are talking Mozart2
> - of the mozart there are 3 types:
> - //Asus ASM58 Mozart-2            $58=$56 $4E=$94 $4F=$36
> - //Asus AS2K129R Mozart-2         $58=$56 $4E=$94 $4F=$06
> - //Asus XXXXXXXX Mozart-2         $58=$10 $4E=$5C $4F=$A3
> - you can handle all 3 the exact same way!!!!!

We have absolutely no support for this one, but we could consider adding
at least detection. It's great that the three of them are handled the
same way.

> so that is detection, next temp sensors:
>
> ASB100:
> - no diode selection option like the winbonds have
> - sensor 1: offset $27 of the sensor chip
> - sensor 2 & 3 are the 2 LM75's on the smbus
> - sensor 4: offset $17 of the sensor chip
> - remark: I noticed that on intel boards sensor 2 is used for the cpu
> and 4 is ignored/stuck, on amd boards sensor 4 is the cpu and sensor 2
> is either ignored or a socket temp

We don't have temp4 in the driver yet. Could be added.

> AS99127F_1 & AS99127F_2:
> - no diode selection option like the winbonds have
> - they both are the same temperature wise
> - sensor 1: offset $27 of the sensor chip
> - sensor 2 & 3 are the 2 LM75's on the smbus
>
> Mozart2:
> - no diode selection option like the winbonds have
> - sensor 1: offset $27 of the sensor chip
> - sensor 2: offset $13 of the sensor chip

So you mean the Mozart2 has no LM75s?

> and finally the voltages, this is where there is a diffrence between
> the 2 AS99127F versions:
>
> ASB100:
> V0V1=$20*0.016
> V0V2=$21*0.016
> V0V3=$22*0.016
> V0V4=$23*0.016*1.68
> V0V5=$24*0.016*3.8
> V0V6=($25*(-0.016))*3.97
> V0V7=($26*(-0.016))*1.666
>
> AS99127F_1:
> V0=AS99127F Standard 1
> V0V1=$20*0.016
> V0V2=$21*0.016
> V0V3=$22*0.016
> V0V4=$23*0.016*1.68
> V0V5=$24*0.016*3.8
> V0V6=($25*(-0.016))*3.97
> V0V7=($26*(-0.016))*1.503
>
> AS99127F_2:
> V1=AS99127F Standard 2
> V1V1=$20*0.016
> V1V2=$21*0.016
> V1V3=$22*0.016
> V1V4=$23*0.016*1.68
> V1V5=$24*0.016*3.8
> V1V6=(($25*0.016)-3.6)*5.14+3.6
> V1V7=(($26*0.016)-3.6)*3.14+3.6

Great. As long as the registers are the same, we don't care about the
formulae. They can be added to our config file, so this require no
driver code change :)

> Mozart2:
> V0=Mozart2 Standard
> V0V1=$20*0.016
> V0V2%5
> V0V3=$22*0.016
> V0V4=$23*0.016*1.68
> V0V5=$24*0.016*4
> V0V6%5
> V0V7%5
>
> I have send a lot of info in the last month to lm_sensor users, so
> it's not always clear to me who is asking this for lm_sensor or for
> himselves.

This time it was for the team. I don't know about the other times. I'm
really astonished that our users ask you about that. These details are
only interesting to us as the driver writers. Users shouldn't really
matter about them.

> so if possible maybe post this somewhere on your site/forum/anything
> so I can direct requests from lm_sensor users to it.

I think of including your detailed expanations into our w83781d driver
doc, which is available online at:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d
Do you agree? I would eventually re-edit a bit to make it more like a
doc.

> The Asus boards are the most popular so I can say for 99.999% that
> the above is correct, there "might" be a diode selection possible but
> never used by Asus so far.  and believe me, if it's wrong people know
> my e-mail adres very well ;)

Precisely, that is where the current thread is supposed to be about. I
don't know if you support w83781d's (and clones such as the asus chips
we are talking about right now) PWM capabilities. We do. These registers
are at 0x5A and 0x5B (bank 0). I tried using PWM on my board, it didn't
work but I noticed that on my as99127f (version 1) the register at 0x5B
seem to be a temperature type selector. Bits 1, 3 and 5 (starting with
LSB=0) could be temp type selector for temp1, temp2 and temp3
respectively. I don't know how useful the information can be, but that's
something I wanted to share with you.

> please let me know if this was usefull and if you posted it so I have
> the url :)

This was very, *very* useful. Thanks *a lot* for your help and time.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
