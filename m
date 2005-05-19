From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: problem with via686a sensor (lm-sensors 2.6.3) - bug + resolve
Message-Id: <3CEC0D49.97D5BFAB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CEA5928.6060201@dremium.com>
In-Reply-To: <3CEA5928.6060201@dremium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sure, report it to the Debian guys if you want.
If they take something that is post-2.6.2 from CVS and label it 2.6.3-5
then that results in confusion. But I guess they can do whatever they want.
I have no idea what their naming standards are.

"Demeter F. Tamas" wrote:
> 
> Mark Studebaker wrote:
> 
> >Are you sure this is in 2.6.3?
> >It was a bug in 2.6.2, I fixed it in 2.6.3, I just double-checked.
> >
> Hi,
> 
> Sure.
> BUT: I downloaded the lm-sensors with the command: apt-get install
> lm-sensors-source  (I have a debian/woody dist.)
> Well, I just checked again: apt-get downloads the
> lm-sensors-source_2.6.3-5_i386.deb. This package contains the
> lm-sensors.tar.gz in which the version.h contain the two lines below:
> #define LM_DATE "20020322"
> #define LM_VERSION "2..6.3"
> And the sensors-detect contains the bug.
> So I downloaded the tar.gz package from the www.lm-sensors.nu and it
> doesn't contain the bug.
> It seems the debian package has not the right 2.6.3 content.
> If you want I will report about it to debain guys.
> 
> Cheers,
> 
> Tam?s.
> 
> >
> >
> >"Demeter F. Tamas" wrote:
> >
> >>hi,
> >>
> >>I want to install lm-sensor 2.6.3 on my system (ABIT-KT7 mobo) and i
> >>couldn't get info about the via686a chip.
> >>So I started to browse the code and I found a bug in the
> >>prog/sensors-detect script.
> >>when it detect a VT82C686 chip it set the procid => "VIA Technologies
> >>VT82C686 Apollo ACPI" but in the sub via686a_isa_detect it try to
> >>compare the procid with the "VIA Technologies VT 82C686 Apollo ACPI"
> >>string and the result of the comparing is false because "VT 82C686" #
> >>"VT82C686".
> >>When I corrected this mistake the detecting become fine.
> >>
> >>Best Regards,
> >>
> >>              Demeter F. Tam?s
> >>
> >>              ---------------------------------------------------------
> >>              Web......: http://www.dremium.com
> >>              Web......: http://www.dreamgate-design.com
> >>              E-mail...: demeterft@dremium.com
> >>              E-mail...: demeterft@dreamgate-design.com
> >>              E-mail...: demeterft@mail.datanet.hu
> >>              Tel/Phone: (36-20) 450 99 91
> >>              Tel/Phone: (36-70) 258 59 17
> >>              Tel/Phone: (36-94) 331 771
> >>
> >
