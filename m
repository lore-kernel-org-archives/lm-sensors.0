From: "Michael R. Doerner" <mdoerner1@cox.net>
Date: Sun, 12 Apr 2009 03:29:23 +0000
Subject: Re: [lm-sensors] lm-sensors Digest, Vol 48, Issue 14
Message-Id: <49E16013.20509@cox.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hiya Rudolf (and group),

OK, so if the AMD temp is incorrect, is there a software fix? I know
AMD's Overdrive software can read the sensors (MS-Windows XP), but are
they compensating for the inaccuracy somehow? Or just showing the
inaccurate value? Is it low, high, or just plain wrong? ;-) If the temp
sensors are wrong then how does the chip know to slow down at 70 C? ;-)

My motherboard is an ASUS M3A78-T which I believe has temperature
sensors on it. Would those temp sensors be supported by lm-sensors?
(They're not being detected now). On the MS-Windows side, I think either
Speedfan or Coretemp can read the motherboard sensors (besides ASUS
proprietary software.) I'm sure it's not as simple as incorporating
someone else's code into this application, but it seems it's been done
and if we can avoid re-inventing the wheel it might be a benefit.

Thanks in advance.

Mike Doerner
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Sat, 11 Apr 2009 13:25:27 +0200
> From: Rudolf Marek <r.marek@assembler.cz>
> Subject: Re: [lm-sensors] AMD 10h core temperatures
> To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
> Cc: lm-sensors@lm-sensors.org
> Message-ID: <49E07E27.30802@assembler.cz>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> Hi,
>
> Unless I made some mistake in the overview the temps looks like very similar to 
> reported IPMI ones right?
>
> So far all fam10h CPUs have same bug making the temps via the k8temp driver 
> inaccurate. It might work for you it might not. This is the reason why is still 
> there no driver.
>
> Rudolf
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
