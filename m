From: avolkov@varma-el.com (Andrey Volkov)
Date: Tue, 15 Nov 2005 22:49:45 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <437A57CB.8090302@varma-el.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org>
In-Reply-To: <20051115215226.4e6494e0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, "Mark A. Greer" <mgreer@mvista.com>

Jean Delvare wrote:
> Hi Andrey,
> 
> 
>>Possible too late to include in 2.6.15,
>>but better later then never :).
> 
> 
> You must be kidding. It might be too late for 2.6._16_. Reviewing takes
> time, reworking afterwards takes time, then you get some testing in -mm
> and it takes time again.
> 
:((.

> 
>>Comments?
> 
> 
> Sure, although I don't really have the time right now for a complete
> review. And I'd rather not review the code if it finally isn't used.
(see my prev. reply to Andrew and you)

> 
> First, a question. Can't you merge the M41T85 support into the m41t00
> driver?
It was first thing what I try, but this chips are very similar only at
first glance. m41t85 have _really_ extended sets of regs and result was
very littered by #if/#else file.

> 
> Mark, care to comment on that possibility, and/or on the code itself?
> 
And, please, remove unnecessary PPC dependence from Kconfig.

>>+config SENSORS_M41T85_SQW_FRQ_ENABLE
>>+	depends on SENSORS_M41T85
>>+	bool "Square Wave Output"
> 
> 
> What a mess. Please just have a sysfs file for that, it's more flexible
> and less intrusive.

I agree, it's look messed, but if sombody use SQW,
then must exist some startup constant for some custom board.
Changing this frq may exist only as option.

--
Regards
Andrey Volkov
