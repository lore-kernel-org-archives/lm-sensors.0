From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: i2c-dev.h
Message-Id: <3ED82B23.7020002@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED81794.9060303@paradyne.com>
In-Reply-To: <3ED81794.9060303@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I found the userspace version, Kyosti added all that was needed to 
kernel/include/i2c-dev.h in the sensors package.
So he didn't leave us hanging after all.
I'm fixing prog/eepromer/*.c and the Makefile to find that version.

Greg KH wrote:
> On Fri, May 30, 2003 at 10:46:44PM -0400, Mark D. Studebaker  wrote:
> 
>>Kyosti took 173 lines out of i2c-dev.h in the main i2c branch
>>because userspace shouldn't include kernel headers,
>>and then merged that change into the lk2-4 branch too.
>>
>>But I don't recall seeing any replacement.
>>
>>Is there one?
>>Should we undo the changes so we have working userspace utilities
>>again or should we create a userspace version of i2c-dev.h?
> 
> 
> Create a userspace version, that includes the changes I made to it for
> the most recent 2.4 and 2.5 kernels :)
> 
> thanks,
> 
> greg k-h
