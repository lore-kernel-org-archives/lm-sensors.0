From: Pinkel <pinkel@gmail.com>
Date: Thu, 11 Oct 2007 16:28:43 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc2 to be released soon
Message-Id: <470E4F3B.4090706@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007113111.2e0a275f@hyperion.delvare>
In-Reply-To: <20071007113111.2e0a275f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

Just tried to download it, but the download location says:
The requested URL /lm-sensors/releases/lm_sensors-3.0.0-rc2.tar.gz was 
not found on this server.
Seems that the correct url is: 
http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.0.0-rc2.tar.bz2
(bz2 instead of gz ;))

Anyway, it's luckily an open dir, so I could still locate it.

--
Ivo

P.s. Unloading i2c-sis5595 before loading sis5595 fixes the problem.



Jean Delvare wrote:
> On Sun, 7 Oct 2007 11:31:11 +0200, Jean Delvare wrote:
>   
>> I plan to release lm-sensors 3.0.0-rc2 tomorrow or the day after. The
>> changes from rc1 are as follows (from CHANGES):
>>
>>   Makefile: Add sensors-conf-convert to make install
>>   libsensors: Notify the caller when writing a value fails
>>               Differentiate between different read error types
>>               Report I/O errors as such
>>   sensord: Log the error code on failure
>>            Drop the configuration file search path mechanism (#2259)
>>            Manual page update
>>   sensors: Fix spurious critical temperature alarm
>>            Print error messages to stderr
>>            Make error messages more helpful and consistent
>>            Better handling of the fault flags
>>   sensors-conf-convert: Add a short help text
>>   sensors-detect: Fix SMSC SCH311x detection
>>
>>
>> I am not yet sure if this will be the last release candidate before the
>> final release. On the one hand, it seems to work really well, but on
>> the other hand I really would like at least one additional application
>> to be ported to the new libsensors API to confirm that it is OK.
>>     
>
> 3.0.0-rc2 is now released.
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
