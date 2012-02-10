From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Feb 2012 08:27:40 +0000
Subject: Re: [lm-sensors] Clearing intrusion detection -- sensors(3) change or at least in the FAQ
Message-Id: <20120210092740.156d9bf2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Sorry for the late reply.

On Tue, 17 Jan 2012 11:08:05 -0600, Jim Duchek wrote:
> Hi all.  I don't subscribe to this list so please CC any responses, thanks.
> 
> I recently had to clear my CMOS and this appears to have triggered the
> intrusion detection on my motherboard.  I do like that it's not
> automatically cleared like other alarms, but no way to clear it in the
> BIOS, unfortunately, and I was unable to find anything in the lm_sensors
> documentation or via google to help either (I certainly may have missed
> it).  I dug around in the it87 module source and saw writing to the sysfs
> file would clear it, so problem solved (for me).  There probably ought to
> be an option in sensors(3) or at least a note in the FAQ about clearing the
> intrusion alarm, though I'm not familiar enough with the innards of the
> hwmon setup to do something properly generic myself.

We could indeed add an option to sensors(3), or even write a separate
binary solely dedicated to reporting intrusions and clearing alarms.
Opinion anyone?

Meanwhile I have added an entry in the FAQ to mention the current lack
of tool and the way to clear the intrusion alarm:
  http://www.lm-sensors.org/wiki/FAQ/Chapter3?version#HowdoIclearthechassisintrusionalarm

I have also created a ticket to track this issue:
  http://www.lm-sensors.org/ticket/2385

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
