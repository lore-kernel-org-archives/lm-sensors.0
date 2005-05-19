From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: EMC6D100 patch
Message-Id: <3F0717B0.1040408@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F065CC2.8010108@penguincomputing.com>
In-Reply-To: <3F065CC2.8010108@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Funny...  I had that problem, but I fixed it.  I check again.

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

