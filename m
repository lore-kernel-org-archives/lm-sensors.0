From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 05 Jul 2007 21:05:41 +0000
Subject: Re: [lm-sensors] Handling of fault files in generic print code
Message-Id: <468D5D25.4050302@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468B2877.9010305@hhs.nl>
In-Reply-To: <468B2877.9010305@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Wed, 04 Jul 2007 06:56:23 +0200, Hans de Goede wrote:
>> I noticed that currently the temp code prints a faults in the place where 
>> normally an alarm gets printed, and ignores alarms. I mimicked this for the 
>> fault support I added to the fan code.
>>
>> But is this wise, since the reading are bogus when a FAULT is raised, shouldn't 
>> the reading be omitted, just like were omitting the alarm?
> 
> I agree that the current implementation doesn't make much sense and
> can be confusing to the users. The "FAULT" statement should replace the
> (invalid) measured value rather than the ALARM flag.

Done, see 3.0.0 svn

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
