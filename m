From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Ticket #: 1365 w83627hf fan3_div
Message-Id: <3F50DFBF.3040804@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Law10-F1207IDkrBuOk0004d1a0@hotmail.com>
In-Reply-To: <Law10-F1207IDkrBuOk0004d1a0@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good that it is not corrupting the lower bits of register 5d.
Bad in that I don't know what could be the problem.

Run isadump before and after changing the fan_div and look for any other
changes. If you want, send both to us. But I'm out of ideas.

Jason Anderson wrote:
> Thanks.  5d changes from 05 to 85 when changing fan_div from '4 2 1' to 
> '4 2 64'.  Is that good?
> 
> Do you think my Winbond chip is messed up, and that's what's causing this?
> 
>> From: "Mark Studebaker" <mds@paradyne.com>
>> To: Jason Anderson <jasonofhoulton@hotmail.com>
>> CC: lm78@Stimpy.netroedge.com
>> Subject: Re: Ticket #: 1365 w83627hf fan3_div
>> Date: Wed, 27 Aug 2003 14:40:00 -0400
>>
>> isadump 0x295 0x296
>>
>> Jason Anderson wrote:
>> >
>> > Hi!  I tried isadump, but I guess I don't know how to use it.  Please
>> > enlighten me.
>> >
>> > Update: My Windows motherboard utility reports 0 for fan3 now, too.
>> >
