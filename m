From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: lm75-i2c-0-49 output
Message-Id: <41FD3621.7020903@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501301824.18376.lists@localguru.de>
In-Reply-To: <200501301824.18376.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

unless sensors-detect told you more modules to load,
you don't have any more chips that we support.
see FAQ for more information.

Marcus Schopen wrote:
> On Sunday 30 January 2005 18:34, Mark Studebaker wrote:
> 
>>not without loading more modules :)
> 
> 
> hmmm .... interesting ... what modules would that be :)
> 
> Thanks,
> Marcus
> 
> 
>>Marcus Schopen wrote:
>>
>>>Hi,
>>>
>>>is there a possibility to get more output:
>>>
>>>lm75-i2c-0-49
>>>Adapter: SMBus ALI15X3 adapter at f140
>>>temp:      +43.0?C  (high = +66.0?C, hyst = +63.0?C)
>>>
>>>lm75-i2c-0-48
>>>Adapter: SMBus ALI15X3 adapter at f140
>>>temp:      +41.5?C  (high = +60.0?C, hyst = +58.0?C)
>>>
>>>Kernel 2.6.8, loaded modules: i2c-ali15x3, lm75
>>>
>>>Thanks,
>>>Marcus
> 
> 
> 
