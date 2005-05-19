From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: [Fwd: xeontemp vs. adm1021]
Message-Id: <4109462F.1060409@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


That's a good question.  It certainly looks as if it is the CPU temp=20
since it is quite a bit higher than the board temp.  Strange that the=20
two CPU's are so different in temp readings, though.  It's also possible=20
that those readings are actually for something else (like the power supply).

What I would try is to load the machine and monitor the temperatures.=20
The board temps should rise slowly, but the CPU temps should rise=20
quickly.  That should give you a easy and definitive answer in just a=20
minute or so.


Phil

PS- Nice to see our stuff at work at Fermilab! ;')

-------- Original Message --------
Date: Thu, 29 Jul 2004 13:27:01 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: frodol@dds.nl, phil@netroedge.com, mdsxyz123@yahoo.com
Subject: xeontemp vs. adm1021
Message-ID: <Pine.LNX.4.58.0407291316090.10290@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=3DUS-ASCII
X-Quarentine-Loop: Processed
X-Spambayes-Classification: ham; 0.00


Hi Guys..

Was reading your documentation at

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/xeontemp

and

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/adm1021

My hardware, Supermicro X5DPA-GG motherboard,
dual Xeon 2.66GHz 533 FSB chips,512kb L2 cache
and
dual Xeon 3.06GHz 533 FSB chips,512kb L2 cache

Running kernel 2.4.20-30.7smp from Redhat with
lm_sensors 2.8.3 and i2c 2.8.3 modules loaded over top of it.

In modules.conf
alias char-major-89 i2c-dev

sensors-detect finds the following:
MODULE_0=3Di2c-i801
MODULE_1=ADm1021
MODULE_2=3Dw83781d
MODULE_3=EEprom
MODULE_4=3Dsmbus-arp

My question is the following:

The docs on xeontemp which I mention above say that 533 MHz
xeons don't have the external sensor for the die temp.
"unfortunately the 533 MHz FSB Xeons dropped the on-board sensor chip"

but the adm1021 docs say " If you have a Xeon and the adm1021
module loads and both temperatures appear valid, then things are good"

In my case the adm1021 module does load, and I get this:


root@fnpc151 root]# sensors
max1617-i2c-0-18
Adapter: SMBus I801 adapter at 0540
Algorithm: Non-I2C SMBus adapter
Board:       +47C  (low  =3D   -55C, high =3D  +127C)
CPU:         +53C  (low  =3D   -55C, high =3D   +78C)

max1617-i2c-0-1a
Adapter: SMBus I801 adapter at 0540
Algorithm: Non-I2C SMBus adapter
Board:       +48C  (low  =3D   -55C, high =3D  +127C)
CPU:         +73C  (low  =3D   -55C, high =3D   +78C)

The CPU temperatures go up and down with CPU activity, as
expected.

My question is--is this "CPU" temperature that I am
reading out the temperature of the die?  The vendor
is telling me that it is.  The documentation you have
hints that it should be too, but I am just confused by
the statement that 533MHZ FSB chips don't have this sensor.

At first with lm_sensors 2.6 we did not see the sensor
but once we ran the sensors-detect from lm_sensors 2.8.3
we could see it just fine and it appears to be functioning.

Is this sensor the die temperature?

Thanks for your help.

Steve Timm




[root@fnpc151 root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 9
cpu MHz         : 3066.856
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 6121.06

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 9
cpu MHz         : 3066.856
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 6121.06


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov=20
http://home.fnal.gov/~timm/
Fermilab Computing Division/Core Support Services Dept.
Assistant Group Leader, Scientific Computing Support Group
Lead of Computing Farms Team
