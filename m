From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 11 Jan 2006 22:20:25 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060111232025.0257667b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> My  problem was that 2.9.1 user-space tools were still in 
> /usr/[bin;sbin] and these were being utilized instead of the >2.9.2 
> versions located /usr/local/[bin;sbin].  After I got that straightened 
> out, sensors-detect did indeed find the chip.

OK, great :) The /usr/local variants should always be before the /usr
variants in $PATH, but depending on the distribution and/or the user,
it might not actually be the case.

> As an aside, the 2.9.2 version generated several errors during "make 
> user" (sorry, can't recall what was stated, and a quick google search 
> didn't illuminate for me what may have been generating the problem(s)).  
> However, I grabbed the CVS version (which provides sensors-detect 
> revision 1.405 (2005/12/09 19:44:49) ) and it worked without problem.   
> [Let me know if you're interested in what the errors were for my "make 
> user" attempt with the 2.9.2 d/l and I will revisit that issue].

If this is fixed in CVS already, don't bother. There's nothing more
we'll be able to do, can't kill a bug that's already dead ;)

> isadump -k 0x87,0x87 0x2e 0x2f 0x0b
> (...)
> In case an"isadump 0x295 0x296" is also of assistance, it yields:

Thanks for the dumps, I've stored them in my personal collection, this
might come in handy to answer future support requests.

You may have noticed that I have been committing the user-space part of
the W83687THF support to CVS already. I also modified the Linux 2.4
w83627hf driver to fully support the W83687THF chip. I still need to
rework the 2.6 patch based on what I found in the datasheet, and then
we'll have to work on a sample configuration file for the chip. I hope
to get all this done by the end of the week. Stay tuned! :)

-- 
Jean Delvare

