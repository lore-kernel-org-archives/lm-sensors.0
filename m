From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Mondo: problem with as99127f-i2c-2d
Message-Id: <200209101943.33371.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
In-Reply-To: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 10 September 2002 04:24 pm, you wrote:
> In any case, this indicates that the problem I'm seeing is not
> in mondo, but is a bug either in i2c/lm_sensors or
> conceivably, at the bios or hardware level in the A7V266E
> motherboard. However I don't think it's hardware - motherboard
> monitor runs on these machines when they are booted to XP and
> I've not seen any oddball shutdowns under that OS.  In one
> instance there was an xlock authentication failure 4 seconds
> before fan1 read 0.0.  Other than that, there was nothing
> obvious to indicate a problem /var/log/messages.  Note though
> that xlock was running continuously most of this time (due to
> the idle console), and cycling through whichever programs it
> runs by default.  This is xlockmore -4.17.2.
>
> This presents somewhat of a problem since it means running
> mondo in a protective mode will trigger unwanted shutdowns
> at 1-2 hour intervals (more or less).  Unfortunately for this
> class of software 99.99% correct doesn't quite do it.
>
> Any suggestions?  This is with RH 7.3 and the current
> distribution of I2c/lm_sensors.  The device is
> as99127f-i2c-0-2d.

Hmmm...yup, as99127f support is listed as BETA in the docs.  We 
have Asus to thank for that. =/  Perhaps Alex van Kaam 
(Motherboard Monitor developer) could help us here; IIRC he's 
contributed to lm_sensors in the past.

In the meantime...

After casting my marginally-experienced-kernel-hacker's eye over 
the lm_sensors sources, I think I might have spotted a fix for 
the fan issue.

The standard caveats apply; this patch may save your bacon, or it 
may take you from the frying pan into the fire.  I will not be 
responsible for any damage this does to your computer, your 
health, your sanity, or any of your friends, family, neighbors, 
or other possessions. ;)

All that being said, just cd to your lm_sensors source directory 
and type "patch -p1 < /path/to/lm_sensors-2.6.4-asus.patch".  
Then recompile and reinstall lm_sensors.

I haven't tried to fix the temp issue--yet.  It looks a little 
more difficult, and that job's probably better suited to a 
developer with appropriate hardware to test on.

--
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.6.4-asus.patch
Type: text/x-diff
Size: 1546 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020910/2008d328/lm_sensors-2.6.4-asus.bin
