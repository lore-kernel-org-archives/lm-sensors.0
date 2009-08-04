From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Aug 2009 08:52:46 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0 init script lm-sensors -- what
Message-Id: <20090804105246.6a0535c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Thu, 30 Jul 2009 20:49:19 +0530, Charles wrote:
> Hello  :-)
> 
> The lm-sensors 3.0.0 init script "lm-sensors" runs only two significant
> commands:
> 
> sensors -s 
> sensors 

Which distribution are you running? The initialization script is
distribution-specific. We provide a sample implementation, which I
think Fedora/Red Hat is using, but other distributions have their own
script.

Our reference implementation runs "sensors -s" but not "sensors".

> I understand the "sensors -s" activates any limits created by set statements
> in sensors3.conf.  What happens (or could be configured to happen) if a
> limit is exceeded?  The sensors.conf man page tells how to configure set
> values but not what they do.

It really depends on the chip, how it is configured (typically by the
BIOS, or its default configuration) and how it is wired on the
mainboard. That's why the manual page can't tell you ;)

In general, exceeding a limit will simply raise an alarm flag, which
will show as "ALARM" in the output of the "sensors" command. Other
actions that are possible depending on the chip and configuration:
* Beeping
* Fan kicking in
* CPU throttling
* System shutdown

The last 3 items are relatively rare, and would only happen when a high
or critical temperature limit is exceeded. And they would take a chip
with a dedicated output pin, properly configured and properly wired.

> Why does the init script run sensors (discarding its output)?  Is this
> necessary for initialisation before lmsensors library functions can be used?

The idea would be to clear undue alarm flags which were raised before
the limits were properly set. Most chips latch the alarm flags and only
clear them after they have been read and the alarm condition has gone.

Whether calling "sensors" in the init script is a good idea or not, is
subject to debate. Clearing the alarm flags is nice (avoids user
confusion), but OTOH, many GUI applications don't show alarm flags
anyway, and that call to "sensors" means reading all hardware registers
for most drivers, and for I2C/SMBus devices this can take a "long" time
(say 1 second) while the current trend is to shorten the boot time of
Linux systems. If anyone is really bothered by the irrelevant alarms
when "sensors" (or another monitoring application) is first run, then
I'd suggest modifying the kernel drivers so that updating limits also
clears the corresponding alarm flags. Or to have a separate cache for
alarms, so that reading/clearing them is reasonably fast.

> In case the answers to these questions depend on hardware and lmsensors
> library users, I am particularly interested in the it87 chip and GKrellM.

The IT8705F can emit beeps on out-of-limits conditions, although our
driver (it87) doesn't support this feature yet (but if the BIOS has set
it up for you, you could still have it.) Once again it depends on how
the chip is wired on the mainboard.

Hope it helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html.en

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
