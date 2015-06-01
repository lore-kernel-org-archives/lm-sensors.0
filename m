From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 01 Jun 2015 14:47:08 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <20150601164708.02dc06ab@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 1 Jun 2015 15:32:41 +0200, Jean Delvare wrote:
> On Mon, 02 Mar 2015 19:10:02 +0100, Taz wrote:
> > For the results : yes it reached around the same mem consumption : 
> > always less than 30MB,
> > starting at 4MB and it looks to be the same start-up consumption as well 
> > with read instead of sleep.
> 
> Looks like I managed to reproduce your problem:
> 
> 00d50000-04748000 rw-p 00000000 00:00 0                                  [heap]
> Size:              59360 kB
> Rss:               41072 kB
> Pss:               41072 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:     41072 kB
> Referenced:        23936 kB
> Anonymous:         41072 kB
> AnonHugePages:         0 kB
> Swap:              18288 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Locked:                0 kB
> VmFlags: rd wr mr mw me ac
> 
> I didn't do anything special, no idea why I couldn't see that before.

Bah, I remember now. What I did is running the script with bash version
4.3.11, which is the one you're seeing the bug on. Probably I did that
long ago and then forgot to check the result. I'll check how
reproducible this is.

> And no idea how to investigate it further :(

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
