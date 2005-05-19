From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: EMC6D100 patch
Message-Id: <3F071D4D.30304@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F065CC2.8010108@penguincomputing.com>
In-Reply-To: <3F065CC2.8010108@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Doh...  Found it.

I did the original coding against 2.7.0 and then ported to cvs.  Didn't notice 
that I needed to move the #defines from sensors.h to lm85.c.

Sorry...

Unfortunately, my current development system has a 2.4.7 kernel and won't 
compile without tweaks, so I can't verify the new patch compiles just yet. 
I'll make sure CVS lk2-4 compiles before I re-submit.

:v)

Mark D. Studebaker wrote:

> patch doesn't compile, no SYSCTL_IN5-7 definitions,
> please retest before you send us something, we're about to release...
> 
> Philip Pokorny wrote:
> 
>> I had previously put some EMC6D100 support into the LM85 driver.
>>
>> This patch adds support for the additional 3 voltage inputs on the 
>> EMC6D100. I also took a closer look at the docs and it doesn't look 
>> like we can tell a EMC6D100 from a ...101 so I've removed the 101 
>> "kind".  I also avoided problems with the doc generator...
>>
>> Please apply before 2.8.0...
>>
>> :v)
>>
>>
>> ------------------------------------------------------------------------
> 
> 

