From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <4217CF71.6030204@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050218154856.GA14189@home.fluff.org>
In-Reply-To: <20050218154856.GA14189@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ben Dooks wrote:
> On Sat, Feb 19, 2005 at 12:06:12PM -0500, Mark Studebaker wrote:
> 
>>Jean Delvare wrote:
>>
>>>Hi Ben, hi Mark,
>>>
>>>
>>>
>>>>>isn't this chip compatible with the LM75 and its driver?
>>>>>what's different about it if anything?
>>>>
>>>>configuration register is different, the temperature
>>>>comparison is also different (tmp101 has low/high range)
>>>
>>>
>>>Configuration is extended but compatible. Your driver doesn't seem to
>>>make use of the extra configuration bits (only raises OS/ALERT, which is
>>>already set by default).
>>
>>I'm going to fix the lm75 driver to only rewrite the CMP/INT bit,
>>and only if it's set to INT, OK?
>>This will be kinder to compatible chips.
> 
> 
> Would it be possible to have an option to add converter resolution
> control at the same time please?
> 
> If the data-sheet had said it was an lm75 compatible, it'd have saved
> me a bit of time. gah.
> 

yes we'd consider a patch to add a resolution parameter (res?)
we'd have to review the other chip datasheets (see list in doc/chips/lm75)
to see if they also support selectable resolution, you may need a second
parameter (or perhaps force_tmp101) to cause the driver to write the
new resolution...

if you're writing chip drivers, it's good to check doc/chips/SUMMARY
to see if there is a similar chip before you start a new driver from scratch...

once you let us know the lm75 driver works, we'll update our docs to reflect support
for the tmp100/101.

mds

