From: jon.roland@the-spa.com (Jon Roland)
Date: Wed, 24 Aug 2005 22:48:43 +0000
Subject: [lm-sensors] Processes causing CPU to overheat
Message-Id: <430C96F4.5010506@the-spa.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <430A5153.2040604@linux-migration.net>
In-Reply-To: <430A5153.2040604@linux-migration.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I will explore solutions like better thermal compound and heatsink/fan 
when I get some money from somewhere, like a job. In the meantime I am 
forced to use methods that only require labor. The problem just caused 
file damage that prevents me from logging in as an ordinary user (but I 
can login as root). Adding a new user didn't allow me to login as that 
user, so I conclude the file damage may have been in one of the etc/*rc 
files. I had to rebuild all my email accounts as root, but using the 
user mailboxes, to be able to send these messages. So far the problem 
has not re-occurred running as root. In other words, I am in a race to 
use software solutions get to a point where I can contemplate hardware 
solutions.

Don't know much about Iirc lm-sensors. All this is fairly new to me. It 
is not clear how a daemon could be harnessed to provide a trigger in a 
script unless there is a hook on it for such things.

While in the BIOS the CPU temperature shown by the Nexus monitor panel 
rose to 48 C, while the BIOS showed 66 C. That is why I set the shutdown 
threshold in the BIOS to 70 C, just above what I found with the BIOS 
running for a while, but lower than the level that the pathological 
condition I am reporting produces (52 C on the Nexus panel).

Don't know how I will find that sensor chip. I will take the system to a 
meeting tonight with others who may be able to figure these things out 
with me.

Craig Sylla wrote:
> One thing for the heatsink/fan would be just to remove it, clean
> everything off, and remount it using a good thermal compound (I
> recommend and use Arctic Silver).  A poorly interfaced heatsink is a
> common problem.  If it has the evil thermal stickytape or foam that's
> a really good reason for it not to work well, it could also just be
> poorly seated.  The P4 socket 775 HSF's are notorious for this.  The
> plain stock AMD HSF's are usually ok for 100% load, but you might just
> need to populate another case fan or two if there are spaces.
> 
> You can't really read the sensors too often btw - the part won't
> sample more often than every few seconds and will really tie up the
> system while it's reading (kernel locks).  Once/minute is pretty slow,
> but more than once every 5 seconds would really bog the machine.  I
> haven't written a check program yet (it is a task I have to do, but
> other things have priority).
> 
> Iirc lm-sensors comes with a demon that can check the sensors
> periodically - is that useful for this?
> 
> If the motherboard's BIOS has a screen that shows the temperature, you
> can also just leave it at that screen for a while and see what
> happens.  The BIOS setup screen runs the cpu at basically full load
> (it's in a loop) and will warm it up nicely.  Since Linux isn't
> running yet it would tell you if the system is just undercooled or if
> something is messing with the fan controller.  You can also use the
> BIOS screens to verify that it's not overclocked.
> 
> What type of chip is reading temperature (which module do you load)
> and what are your parameters for it to the sensors.conf?  If I can get
> a spare bit of time I can look and see which sys object to read.
> 
> Craig
>   
> 
> On 8/24/05, Jon Roland <jon.roland@the-spa.com> wrote:
> 
>>Yes, I restored sensors by running sensors-detect.
>>
>>I doubt things have changed that much in going to FC4. If you could provide a
>>2.6.5 solution I can probably use or adapt it.
>>
>>I am indeed working on a script that would extract the CPU temp from the output of
>>the sensors command and use it as a trigger. I was just hoping someone might have
>>already done something like that, preferably something a little more robust, and
>>that I could run in background like a watch xxx script. A cron job with only a
>>one-minute granularity does not seem to be fast enough for this problem, because
>>freezeup occurs in less than a minute once the processes begin that seem to cause it.
>>
>>Many of the respondents are also saying I need a better heatsink/fan. Funds for
>>that are low right now.
>>
>>Craig Sylla wrote:
>>
>>>Unfortunately it varies from driver to driver.  :/
>>>
>>>You would need to look at the source for the driver in question to see
>>>exactly what it does.  Most of them actually provide a fairly useful
>>>value in the sys entry.  Also you had mentioned earlier that sensors
>>>had died, have you been able to get them working again?
>>>
>>>I am also unsure of exactly what the newer methods are for this, as
>>>I'm working with kernel 2.6.5, which is somewhat dated now.  FC4 is
>>>running 2.6.12 iirc, I'd rather not give you info that is wrong and
>>>waste your time.
>>>
>>>One possibility - if the 'sensors' command and your sensors.conf file
>>>are good/working/right you could just grep out the line for the temp
>>>and parse that for your temperature and alarm status.  The command
>>>uses the config file to do the conversions for you and knows how to
>>>handle each driver correctly.  You can also set thresholds in the
>>>config file.
>>>
>>>Craig
>>>
>>>
>>>On 8/23/05, Jon Roland <jon.roland@the-spa.com> wrote:
>>>
>>>
>>>>This is a tantalizing suggestion, but it is insufficient information. Could you be
>>>>more specific, or point me to some documentation that would help me make it work?
>>>>Thanks.
>>>>
>>>>Craig Sylla wrote:
>>>>
>>>>
>>>>>The 'raw' driver data comes from the sys file system.  You could read
>>>>>the temp directly (it will require some math conversion but not much).
>>>>>Or just check the 'alarm' value for a pass-fail type test.
>>>>
>>>>--
>>>>
>>>>----------------------------------------------------------------
>>>>Starflight Corporation    7793 Burnet Road #37, Austin, TX 78757
>>>>512/374-9585 www.the-spa.com/jon.roland/  jon.roland@the-spa.com
>>>>----------------------------------------------------------------
>>>>
>>>
>>>
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
