From: jon.roland@the-spa.com (Jon Roland)
Date: Wed, 24 Aug 2005 17:59:06 +0000
Subject: [lm-sensors] Processes causing CPU to overheat
Message-Id: <430C52F8.7060001@the-spa.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <430A5153.2040604@linux-migration.net>
In-Reply-To: <430A5153.2040604@linux-migration.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes, I restored sensors by running sensors-detect.

I doubt things have changed that much in going to FC4. If you could provide a 
2.6.5 solution I can probably use or adapt it.

I am indeed working on a script that would extract the CPU temp from the output of 
the sensors command and use it as a trigger. I was just hoping someone might have 
already done something like that, preferably something a little more robust, and 
that I could run in background like a watch xxx script. A cron job with only a 
one-minute granularity does not seem to be fast enough for this problem, because 
freezeup occurs in less than a minute once the processes begin that seem to cause it.

Many of the respondents are also saying I need a better heatsink/fan. Funds for 
that are low right now.

Craig Sylla wrote:
> Unfortunately it varies from driver to driver.  :/
> 
> You would need to look at the source for the driver in question to see
> exactly what it does.  Most of them actually provide a fairly useful
> value in the sys entry.  Also you had mentioned earlier that sensors
> had died, have you been able to get them working again?
> 
> I am also unsure of exactly what the newer methods are for this, as
> I'm working with kernel 2.6.5, which is somewhat dated now.  FC4 is
> running 2.6.12 iirc, I'd rather not give you info that is wrong and
> waste your time.
> 
> One possibility - if the 'sensors' command and your sensors.conf file
> are good/working/right you could just grep out the line for the temp
> and parse that for your temperature and alarm status.  The command
> uses the config file to do the conversions for you and knows how to
> handle each driver correctly.  You can also set thresholds in the
> config file.
> 
> Craig
> 
> 
> On 8/23/05, Jon Roland <jon.roland@the-spa.com> wrote:
> 
>>This is a tantalizing suggestion, but it is insufficient information. Could you be
>>more specific, or point me to some documentation that would help me make it work?
>>Thanks.
>>
>>Craig Sylla wrote:
>>
>>>The 'raw' driver data comes from the sys file system.  You could read
>>>the temp directly (it will require some math conversion but not much).
>>> Or just check the 'alarm' value for a pass-fail type test.
>>
>>--
>>
>>----------------------------------------------------------------
>>Starflight Corporation    7793 Burnet Road #37, Austin, TX 78757
>>512/374-9585 www.the-spa.com/jon.roland/  jon.roland@the-spa.com
>>----------------------------------------------------------------
>>
> 
> 


-- 

----------------------------------------------------------------
Starflight Corporation    7793 Burnet Road #37, Austin, TX 78757
512/374-9585 www.the-spa.com/jon.roland/  jon.roland@the-spa.com
----------------------------------------------------------------
