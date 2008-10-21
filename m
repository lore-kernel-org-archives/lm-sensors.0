From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 21 Oct 2008 08:35:40 +0000
Subject: Re: [lm-sensors] f71882fg-* How do you set temp limits for max_hyst
Message-Id: <48FD945C.5030206@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <48FBFF2A.608@suddenlinkmail.com>
In-Reply-To: <48FBFF2A.608@suddenlinkmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David C. Rankin wrote:

<snip>

> 	Well that worked nicely! Now why wouldn't it accept the set variables from the
> sensors3.conf file? Let's try again. A quick vi of sensors3.conf leaving:
> 
> # Set CPU and System temp limits
> 
>     set temp1_max_hyst 50
>     set temp1_max 55
> #    set temp1_crit_hyst 56
>     set temp1_crit 60
>     set temp2_max_hyst 50
>     set temp2_max 55
> #    set temp2_crit_hyst 56
>     set temp2_crit 60
> 
> 	WTF? It worked! Hmm..., something is fishy here. Let's do another test:
> 

Yes, note you've now commented out the set temp#_crit_hyst lines which were 
trying to set the readonly temp#_crit_hyst, which you did not (comment them 
out) with your first try, most likely those where causing the errors.

> 23:42 sq4~> sudo echo -n 50000 > /sys/class/hwmon/hwmon0/device/temp1_max_hyst
> -bash: /sys/class/hwmon/hwmon0/device/temp1_max_hyst: Permission denied
> 
> 	$%#@%^@$%$ing sudo! I see the problem, but I don't know why. When the error
> was generated, I was running sensors -s with sudo "sudo sensors -s" which has
> always worked before with all my other boxes. I wonder what the deal is here.
> Mystery solved, and another one to track down -- normal...

sudo sensors -s will work fine, it will probably work on this system too now 
that you've fixed sensors.conf, the problem with this line:

23:42 sq4~> sudo echo -n 50000 > /sys/class/hwmon/hwmon0/device/temp1_max_hyst

Is that the echo runs as root, but the " > " runs as you, so 
/sys/class/hwmon/hwmon0/device/temp1_max_hyst gets opened as you. The correct 
way to do this using sudo is:

sudo bash -c "echo -n 50000 > /sys/class/hwmon/hwmon0/device/temp1_max_hyst"

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
