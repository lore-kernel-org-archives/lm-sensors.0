From: ramsay@sedsystems.ca (Jim Ramsay)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A question about lm_sensors on IBM
Message-Id: <3F6F0914.3000509@sedsystems.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030920093752.71f69b8b.khali@linux-fr.org>
In-Reply-To: <20030920093752.71f69b8b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>Hello, Philip.
> 
> I'm not Philip, but hey, I want to answer :p

Well, I'm sure that's almost as good ;)

>>I work for a company who has in the past used lm_sensors for
>>monitoring temperature in various hardware running linux, and we've
>>been really impressed with it.
>>
>>The problem we've got now is that we are required to use some IBM 
>>servers, and of course lm_sensors won't run on them because of the 
>>Thinkpad 24RF08 EPROM issue.
>>
>>The other problem we've got is that because of other software 
>>constraints, we cannot upgrade our Linux past an approximate RedHat
>>7.0 (Kernel 2.2.16).  This means that 1) All of IBM's proprietary 
>>temperature monitoring stuff won't run, and 2) I am stuck using 
>>lm_sensors/i2c 2.7.0
>>
>>As far as I can tell so far these servers need the 'piix4' module.
>>
>>I need to know if I can disable the check for the vendorID throughout 
>>lm_sensors, and if so how involved a change this would be, or if
>>someone else has already done this.  I will of course only do so if
>>our IBM servers do not have the affected 24RF08 EPROM chip in them.
>>
>>Thanks for any help or advice you can give me on how to do this.
> 
> Here you go. There are two places where you want to disable the check.
> In sensors-detect first, in i2c-piix4.c then.
> 
> In sensors-detect, go to line 3075 and remove the call to
> safe_system_vendor (replace it with 0).
> 
> In i2c-piix4.c, go to line 247 and remove the call to ibm_dmi_probe
> (replace it with 0).

Right on, this is exactly what I wanted to know!

> Note that we don't in any way endorse any consequences of following the
> instructions right above. The checks you will be removing have a reason
> to be there, bypassing them is dangerous. We are not liable for any
> hardware damage, nor anything else, that this could cause.

Understood.  I can't imagine how someone would hold an unknown number of 
opensource software developers responsible / liable for anything besides 
making good software anyway, but I won't even bother to alter the code 
at all unless I get a strong answer from my IBM people on whether or not 
these computers we're using use the affected chip.

> However, if you decide to go on, we would be interested in learning
> about your experience. If you can have lm_sensors working efficiently on
> your system, we'll start working on a whitelist of known-to-be-safe IBM
> systems, so that other users will benefit of your work. Thanks!

I'd be happy to help out!  I'll tell y'all as soon as I know if it 
worked, if I didn't attempt it, or if lm_sensors ate my machine.

-- 
Jim Ramsay
Programmer Analyst
SED Systems, A Division of Calian Ltd.
email: ramsay@sedsystems.ca
phone: 306.933.1665
