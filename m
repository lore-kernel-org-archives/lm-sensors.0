From: Taz <rastataz@gmail.com>
Date: Sat, 13 Jun 2015 18:17:01 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <557C739D.1030807@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le 01/06/2015 16:47, Jean Delvare a =E9crit :
> On Mon, 1 Jun 2015 15:32:41 +0200, Jean Delvare wrote:
>> On Mon, 02 Mar 2015 19:10:02 +0100, Taz wrote:
>>> For the results : yes it reached around the same mem consumption :
>>> always less than 30MB,
>>> starting at 4MB and it looks to be the same start-up consumption as well
>>> with read instead of sleep.
>> Looks like I managed to reproduce your problem:
>>
>> 00d50000-04748000 rw-p 00000000 00:00 0                                 =
 [heap]
>> Size:              59360 kB
>> Rss:               41072 kB
>> Pss:               41072 kB
>> Shared_Clean:          0 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:         0 kB
>> Private_Dirty:     41072 kB
>> Referenced:        23936 kB
>> Anonymous:         41072 kB
>> AnonHugePages:         0 kB
>> Swap:              18288 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Locked:                0 kB
>> VmFlags: rd wr mr mw me ac
>>
>> I didn't do anything special, no idea why I couldn't see that before.
> Bah, I remember now. What I did is running the script with bash version
> 4.3.11, which is the one you're seeing the bug on. Probably I did that
> long ago and then forgot to check the result. I'll check how
> reproducible this is.
>
>> And no idea how to investigate it further :(
Sorry for late answer but I was quite busy lastly (I moved).

Still using the bash version you're refering to, I'm at 80 Mb usage=20
after 20 days uptime:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Name:   fancontrol
State:  S (sleeping)
Tgid:   1292
Ngid:   0
Pid:    1292
PPid:   1
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 256
Groups: 0
VmPeak:    96472 kB
VmSize:    96472 kB
VmLck:         0 kB
VmPin:         0 kB
VmHWM:     81064 kB
VmRSS:     81064 kB
VmData:    78652 kB
VmStk:       136 kB
VmExe:       956 kB
VmLib:      2288 kB
VmPTE:       208 kB
VmSwap:        0 kB
Threads:        1
SigQ:   0/7887
SigPnd: 0000000000000000
ShdPnd: 0000000000000000
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 0000000000016007
CapInh: 0000000000000000
CapPrm: 0000003fffffffff
CapEff: 0000003fffffffff
CapBnd: 0000003fffffffff
Seccomp:        0
Cpus_allowed:   f
Cpus_allowed_list:      0-3
Mems_allowed:   00000000,00000001
Mems_allowed_list:      0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Won't paste the output as well here but /proc/..../smaps shows many=20
segments, whithin which one is using 75 Mb.
(don't know if it's helpful...).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
