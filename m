From: rudolf.marek@sysgo.com (Rudolf Marek)
Date: Tue, 13 Jun 2006 08:54:47 +0000
Subject: [lm-sensors] W83793 driver
Message-Id: <448E7D57.8090805@sysgo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44893948.2070709@winbond.com>
In-Reply-To: <44893948.2070709@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Yuan,

> Sounds interesting, i think we do not need to do this now since the=20
> machine did not
> reboot for 3 days, maybe the reason is they use a aeroengine as the=20
> cpufan...
> I will dig what you said after finish the schedule about 793 :)
> Now I got it work on FC5 and FC4, but FC3 met the same problem as i met=20
> before,
> maybe i801 driver missing ICH7 PCI ID, and i'm trying to make it work :(

CHeck the PCI IDS, for new kernels you can check the history on each files:
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
history;h=86bc843a268058df558844b6bf64531617fbc698;f=3Ddrivers/i2c/busses/i=
2c-i801.c

And also through the trac.
http://www.lm-sensors.org/log/lm-sensors/trunk/kernel/busses/i2c-i801.c

>> I will just do a "quick" review later today and send you the results.=20
>> I have in
>> my queue also VT1211 driver, hopefully I can do both today or in near=20
>> future.
>>

I hope to do it this week, maybe in evening... Got a lot of work ;(

Regards
Rudolf


