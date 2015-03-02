From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 02 Mar 2015 10:30:09 +0000
Subject: Re: [lm-sensors] Fancontrol memory consumption
Message-Id: <20150302113009.69c231b9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141105175729.39a88ab1@endymion.delvare>
In-Reply-To: <20141105175729.39a88ab1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 13 Nov 2014 15:36:32 +0100, Taz wrote:
> (sorry I just saw my reply still was in my drafts, don't know why...)
> 
> Indeed : my current bash version is 4.3.11
> Although I don't have line 585 in my fancontrol script
> I can apply the the patch (lines 497 & 536 for fancontrol v0.7)
> 
> I also gave it a try without the wait lines and not sending to 
> background the previous
> sleep command the wait was waiting for anyway (useless ?)
> 
> => Mem consumption seems to be the same in all cases, we'll see in the 
> long run...

BTW, can you please tell me
* Which architecture this is (x86 or x86-64)?
* The value of "ulimit -u" on this system.
* The total amount of memory on the system.

As Chet Ramey explained to me, the memory consumption is bound and the
default limit depends on these factors. Assuming an x86-64 system,
eating 22 MB of memory as you reported would take about 734000 records
of 32 bytes each, and "ulimit -u" would be set to that value by default
for a system with about 187 GB of memory. Which I would not expect in a
NAS, so something is wrong.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
