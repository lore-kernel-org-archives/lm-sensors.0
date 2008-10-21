From: "David C. Rankin" <drankinatty@suddenlinkmail.com>
Date: Tue, 21 Oct 2008 18:45:21 +0000
Subject: Re: [lm-sensors] f71882fg-* How do you set temp limits for max_hyst
Message-Id: <48FE2341.8000504@suddenlinkmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FBFF2A.608@suddenlinkmail.com>
In-Reply-To: <48FBFF2A.608@suddenlinkmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:
> David C. Rankin wrote:
> 
> <snip>
> 
>>     Well that worked nicely! Now why wouldn't it accept the set
>> variables from the
>> sensors3.conf file? Let's try again. A quick vi of sensors3.conf leaving:
>>
>> # Set CPU and System temp limits
>>
>>     set temp1_max_hyst 50
>>     set temp1_max 55
>> #    set temp1_crit_hyst 56
>>     set temp1_crit 60
>>     set temp2_max_hyst 50
>>     set temp2_max 55
>> #    set temp2_crit_hyst 56
>>     set temp2_crit 60
>>
>>     WTF? It worked! Hmm..., something is fishy here. Let's do another
>> test:
>>
> 
> Yes, note you've now commented out the set temp#_crit_hyst lines which
> were trying to set the readonly temp#_crit_hyst, which you did not
> (comment them out) with your first try, most likely those where causing
> the errors.
> 

Not quite. Originally, I was receiving errors on all of the temp#_max_hyst and
temp#_crit_hyst (readonly) lines. I can't explain why the temp#_max_hyst lines
were generating the errors when attempting to set with sudo, but I'm quite sure
they were. In vi, I had line numbers visible (:set nu) and was testing setting
the hyst values from within vi (:!sudo sensors -s) and after exiting vi with a
simple sudo sensors -s and on both occasions the temp#_max_hyst lines were not
being set and were generating the errors.

I have done close to 2 gig of updates since that time so maybe one of the
updates fixed the sudo behavior. All is well now on openSuSE 11.0 with sensors3
and the f71882fg-* chipset.

Although, I still haven't a clue as to what temp3 is for the K9N2 SLI Platinum
board.

>> 23:42 sq4~> sudo echo -n 50000 >
>> /sys/class/hwmon/hwmon0/device/temp1_max_hyst
>> -bash: /sys/class/hwmon/hwmon0/device/temp1_max_hyst: Permission denied
>>
>>     $%#@%^@$%$ing sudo! I see the problem, but I don't know why. When
>> the error
>> was generated, I was running sensors -s with sudo "sudo sensors -s"
>> which has
>> always worked before with all my other boxes. I wonder what the deal
>> is here.
>> Mystery solved, and another one to track down -- normal...
> 
> sudo sensors -s will work fine, it will probably work on this system too
> now that you've fixed sensors.conf, the problem with this line:
> 
> 23:42 sq4~> sudo echo -n 50000 >
> /sys/class/hwmon/hwmon0/device/temp1_max_hyst
> 
> Is that the echo runs as root, but the " > " runs as you, so
> /sys/class/hwmon/hwmon0/device/temp1_max_hyst gets opened as you. The
> correct way to do this using sudo is:
> 
> sudo bash -c "echo -n 50000 >
> /sys/class/hwmon/hwmon0/device/temp1_max_hyst"
> 
> Regards,
> 
> Hans
> 

Dang your good Hans! Not only have you solved the sensors3.conf conundrum, but
you've taught this old dog a new BASH trick as well!

Seriously, thanks for helping me work through this issue and keep up the great
work with sensors.

-- 
David C. Rankin, J.D., P.E.
Rankin Law Firm, PLLC
510 Ochiltree Street
Nacogdoches, Texas 75961
Telephone: (936) 715-9333
Facsimile: (936) 715-9339
www.rankinlawfirm.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
