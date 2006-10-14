From: kress@hal.saar.de (Michael Kress)
Date: Sat, 14 Oct 2006 11:43:22 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <4530CD5A.2010602@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare schrieb:
> Looks alright. Did you try unloading and reloading the driver a couple
> time? If everything works OK for you I'll push the driver into -mm
> soon, so that it can receive wider testing.
>  =20

sorry, it took a bit ... not because I tested for so long time... ;-)
I've been modprobe'ing und rmmod'ing the driver constantly for an hour
or so (every few seconds, with 'watch') and I can still receive the
expected results without any flaw, nothing irregular, no strange syslog
messages etc.

>> [root at matrix PC87427-platform-driver]# dmesg | tail -n 8
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D0
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D1
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D2
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D3
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D4
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D5
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D6
>> pc87427: readall_fan: data=FFff88003f09e540, nr=3D7
>>    =20
>
> These are temporary debugging messages which I put in there to
> investigate an older bug, which of course never happened again. You can
> get rid of them by removing -DDEBUG in the Makefile and building the
> driver again. You can also replace -g with -O2 for faster and smaller
> code.
>  =20

Debugging messages are gone now.
Thanks & have a nice weekend

Michael

--=20
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


