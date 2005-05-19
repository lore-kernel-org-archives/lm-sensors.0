From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <3FF1F2DC.2080304@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I checked in some better comments for getsysname() in lib/proc.c.

Mark Studebaker wrote:
> let me try again.
> They already have 2.4 support, right?
> In that case, for every sysfs entry that is "non-standard"
> (i.e. not covered by the conversion routine getsysname() in lib/proc.c),
> add the name of the sysfs entry at the end of the entry in lib/chips.c.
> If the magnitude is non-standard, add it as well.
> 
> 
> Jean Delvare wrote:
> 
>> Hi MDS (and others),
>>
>> I would like to add support for the 2.6 lm83 and lm90 drivers to
>> libsensors/sensors. Although it should be obvious how to do that, I just
>> can't find where it is. Any hints?
>>
>> Thanks.
>>
> 
> 
