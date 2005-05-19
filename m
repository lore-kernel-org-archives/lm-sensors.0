From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Call for 2.8.2 soon
Message-Id: <3FC2815C.8030309@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some of it really is "real bugfixes".
Fixing the magnitudes in the w83781d temperatures
is probably the most important...
Can we agree on the "real bugfixes" and push only those over?

Greg KH wrote:

> On Mon, Nov 24, 2003 at 09:23:58PM +0100, Jean Delvare wrote:
> 
>>>After -test10 comes out (assuming it has Khali's patches in it),
>>>then I want to fix up libsensors to match the magnitudes and sysfs
>>>names that test10 has in it, then release 2.8.2.
>>
>>Test10 is out, without the patches. Looks like Greg wants to wait until
>>Linux 2.6.0 is out before applying patches again. This policy is likely
>>to slow down Mark's plan.
> 
> 
> Sorry about that, but I'll only let real bugfixes in right now.
> Everything else (like the patches sent to me already) are queueing up
> for 2.6.1.
> 
> thanks,
> 
> greg k-h
> 

