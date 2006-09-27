From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 27 Sep 2006 18:06:04 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <20060927180604.GA16860@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 27, 2006 at 06:49:00PM +0200, Rudolf Marek wrote:
> 
> > OK, I will be glad to test further.
> >   
> 
> Ok I think I found it.:
> 
> Please change this:
>              do_rdmsr(data->id, MSR_IA32_THERM_CONTROL, &eax, &edx);
> 
> Into this:
> 
>              do_rdmsr(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> 
> It should work ...

I made the change and recompiled, and even after verifying that the previous
one had been rmmodded, the new one won't insert, gives the same error as
before when I try to modprobe it.  

Can you please fix it so it can be modprobed and rmmodded without having to
reboot?  I was going to test this while ssh'd in from work but don't want to
reboot the machine.

Thank you
Michael

-- 

San Francisco, CA

