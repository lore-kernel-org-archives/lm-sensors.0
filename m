From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 05 Nov 2014 09:57:48 +0000
Subject: Re: [lm-sensors] Fwd: Re: Fancontrol memory consumption
Message-Id: <20141105105748.3db8a3ec@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <54589A6A.8010207@gmail.com>
In-Reply-To: <54589A6A.8010207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 04 Nov 2014 10:20:42 +0100, Taz wrote:
> I'm using fancontrol on a NetGear ReadyNAS Ultra 6000 (X86 arch) using 
> ubuntu server 14 and it's great !
> 
> But as you may see in the forward (or not : I don't know if the pic will 
> be filtered...), fancontrol

No picture indeed, although I don't think the list is configured to
filter them out.

> memory usage, although not huge, is worryingly increasing as uptime goes on.
>  From 6 Mb at the moment I start the daemon to 27 Mb less than a week 
> later, and still growing !
> 
> Here are few system stats, I think pinpointed the issue, but that's all 
> I could do...
> 
> 
> pmap -x FANCONTROL_PID (see 25 Mb in dirty column)
> ==> Address           Kbytes     RSS   Dirty Mode  Mapping
> 0000000000400000     956     556       0 r-x-- bash
> 00000000006ef000       4       4       4 r---- bash
> 00000000006f0000      36      20      20 rw--- bash
> 00000000006f9000      24      24      24 rw---   [ anon ]
> 0000000001dd7000   25948   25948   25948 rw---   [ anon ]
> (...)
> 
> cat /proc/FANCONTROL_PID/smaps output sample :
> ====
> (...)
> 01dd7000-0372c000 rw-p 00000000 00:00 0                                  
> [heap]
> Size:              25940 kB
> Rss:               25940 kB
> Pss:               25940 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:     25940 kB
> Referenced:        17956 kB
> Anonymous:         25940 kB
> AnonHugePages:         0 kB
> Swap:                  0 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Locked:                0 kB
> VmFlags: rd wr mr mw me ac sd
> (...)
> 
> Look like it's the heap ( memory leak in the fancontrol shell script !? )

You do not explicitly allocate memory in bash, so you are not
responsible for freeing it either. You can call "unset" to explicitly
drop references and allow bash to free some memory, but that only makes
sense in specific cases. I do not think this applies to fancontrol.

> cat /proc/FANCONTROL_PID/io
> =======> rchar: 685486042
> wchar: 6072566
> syscr: 2428507
> syscw: 346921
> read_bytes: 19808256
> write_bytes: 0
> cancelled_write_bytes: 0
> 
> It looks like every data read by the process is kept in memory (pwm 
> sensors data ?) : It doesn't seems OK to me...

Most variables are local to function UpdateFanSpeeds so they wouldn't
survive between cycles. The rest would only be read from, not written
to, so it can't grow.

> Am I wrong ? Do someone have any clue or suggestion ?

Most likely the leak is in bash itself and fancontrol is only exposing
it.

Which version of bash are you using? Try with different versions and
see if they all behave the same.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
