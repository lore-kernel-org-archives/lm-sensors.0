From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <3FF1F8A9.2050402@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
>>let me try again.
>>They already have 2.4 support, right?
> 
> 
> Ja ja ;)
> 
> 
>>In that case, for every sysfs entry that is "non-standard"
>>(i.e. not covered by the conversion routine getsysname() in
>>lib/proc.c), add the name of the sysfs entry at the end of the entry
>>in lib/chips.c. If the magnitude is non-standard, add it as well.
> 
> 
> The amazing thing is that all entries *have* standard names:
> 
> alarms
> temp_crit1
> temp_crit2
> temp_input1
> temp_input2
> temp_max1
> temp_max2
> temp_min1
> temp_min2
> 
> So I would have expected everyting to work out of the box - but it
> doesn't. Any clue where I should start digging?
> 
>


strace?

temp_critx is NOT standard, or at least not converted by getsysname();
so if 'sensors' is looking for it as tempx_crit it won't find it.
