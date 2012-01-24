From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jan 2012 07:45:46 +0000
Subject: Re: [lm-sensors] Per motherboard config
Message-Id: <20120124084546.2ca8b417@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F19BC74.7010506@ubuntu.com>
In-Reply-To: <4F19BC74.7010506@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phillip,

On Fri, 20 Jan 2012 14:11:48 -0500, Phillip Susi wrote:
> The default sensors3.conf does a good job configuring the sensors on a
> per-chip basis, but there is a good deal of variation on a
> per-motherboard basis as well.  Is it possible to key the config on
> the motherboard model,

No, this isn't possible (at least not currently.) libsensors has now
way to know which chip is on what board on a given system. It could
check the DMI IDs but this could lead to false positives on some
motherboards / graphics cards combinations for example. Plus we have no
syntax to express this in the sensors3.conf format anyway.

> and would there be any interest in gathering
> known motherboard configs into the default sensors3.conf to do things
> like hide sensors that are known to not be connected and thus have
> invalid readings?

We do already gather known motherboard configuration files, see:
http://www.lm-sensors.org/wiki/Configurations
http://khali.linux-fr.org/devel/lm-sensors/
If you have more, feel free to send them to the list and we'll add
them, or we can create a wiki account for you and you add them yourself.

These aren't meant to go to the default sensors3.conf file, we used to
do that years ago and this resulted in a huge default configuration
file which took long to parse and was a pain to maintain.

The missing piece now is a script that would check the DMI data of the
motherboard, look for a suitable configuration file and download it
to /etc/sensors.d semi-automatically. This could be integrated into
sensors-detect or made a separate script. This has been discussed in
the past already, some implementations have even been floating around.
Now it's really a matter of someone taking the time to integrate it all
properly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
