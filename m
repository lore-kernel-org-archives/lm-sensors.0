From: Taz <rastataz@gmail.com>
Date: Mon, 02 Mar 2015 11:05:09 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <54F443E5.1040802@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le 02/03/2015 11:30, Jean Delvare a =E9crit :
> On Thu, 13 Nov 2014 15:36:32 +0100, Taz wrote:
>> (sorry I just saw my reply still was in my drafts, don't know why...)
>>
>> Indeed : my current bash version is 4.3.11
>> Although I don't have line 585 in my fancontrol script
>> I can apply the the patch (lines 497 & 536 for fancontrol v0.7)
>>
>> I also gave it a try without the wait lines and not sending to
>> background the previous
>> sleep command the wait was waiting for anyway (useless ?)
>>
>> =3D> Mem consumption seems to be the same in all cases, we'll see in the
>> long run...
> BTW, can you please tell me
> * Which architecture this is (x86 or x86-64)?
> * The value of "ulimit -u" on this system.
> * The total amount of memory on the system.
>
> As Chet Ramey explained to me, the memory consumption is bound and the
> default limit depends on these factors. Assuming an x86-64 system,
> eating 22 MB of memory as you reported would take about 734000 records
> of 32 bytes each, and "ulimit -u" would be set to that value by default
> for a system with about 187 GB of memory. Which I would not expect in a
> NAS, so something is wrong.
>

The hardware is actually a ReadyNAS ultra 6000 with 2GB RAM.
I'm running a x86_64 ubuntu server 14.04 with 3.16 SMP kernel
and fancontrol from standard repos (pkg vers is 1:3.3.4-2ubuntu1).

=3D=3D=3D=3D=3D=3D=3D

=12(root@ReadyNAS:pts/0)=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=
=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=
=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=
=12=12=12=12#=20
ulimit -u
     7892

(root@ReadyNAS:pts/0)=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=
=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=
=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=12=
=12=12=12#free
                  total       used       free     shared buffers     cached
     Mem:       2039828    1829656     210172        708 4796    1091516
     -/+ buffers/cache:     733344    1306484
     Swap:      5242876          0    5242876


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
