From: <JasonZhao@viatech.com.cn>
Date: Fri, 13 Mar 2009 11:03:10 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <9156F9F8217CD44898ABE1E581FAFF8842FEED@exchbj02.viatech.com.bj>
List-Id: <lm-sensors.vger.kernel.org>
References: <200902221052.31780.justin@justinzane.com>
In-Reply-To: <200902221052.31780.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf
Will reply you tonight (3 hours later), back to home now:)
However I found I only have a " VIA C7 BIOS WRITERS GUIDE_2.5"( created
in 04/04/07) on hand. My colleague that works for c7 on EFI only have
this datasheet too.

-jasonzhao 

> -----Original Message-----
> From: Rudolf Marek [mailto:r.marek@assembler.cz]
> Sent: Friday, March 13, 2009 6:02 PM
> To: Jason Zhao
> Cc: Michael Reinelt; Juerg Haefliger; justin@justinzane.com;
> lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] module c7temp shows voltage, but no
temperature
> 
> Hello Jason,
> 
> We have some problem with c7temp driver in the linux. This was done by
Juerg.
> The driver can be downloaded from the lm-sensors.org website in
devices
> section.
> 
> It seems some version of fam6 model D does not have any temperature
register
> in
> 
> >    0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100f13
edx=0x42040000
> 
> Jason, Please can you look to some more recent version of C7 data
book, where
> the values for temperature are stored? (normally they are for cpuid
EAX > 0xc0000002 in EAX. Here are zeros.
> 
> I dont know what CPU revision it is exactly. I guess we will need to
read some
> other MSR to get current version. Juerg do you know this? Its should
be MSR
> 1154h.
> 
> All I know that the cpu is also at HP Mini-note 2133.
> 
> Thanks,
> Rudolf
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
