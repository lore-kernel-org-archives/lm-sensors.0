From: Jordan Crouse <jordan.crouse@amd.com>
Date: Tue, 22 Jan 2008 22:55:22 +0000
Subject: Re: [lm-sensors] adt7475 support (Asus M2N-SLI Deluxe)
Message-Id: <fn5s8p$d0v$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 22 Jan 2008 22:10:32 +0100, Hans de Goede wrote:

> Matt Roberds wrote:
>> Hello all!
>> 
>> I recently built a system using an Asus M2N-SLI Deluxe motherboard,
>> which has an Analog Devices ADT7475 thermal monitor and fan control
>> chip.  sensors-detect knows about it but says there is no driver.  I've
>> been looking through the mailing list archives and found a post from
>> Hans de Goede in December with a partial driver (see
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-
December/022169.html
>> ).
>> 
>> I downloaded that driver and it built as a module under kernel 2.6.18,
>> after commenting out a few lines of code.  sensors (from lm-sensors
>> 3.0.0) says:
>> 
>> 
> Hi,
> 
> Yes that Hans de Goede would be me. Unfortunately I'm still waiting for
> my Asus M2N-SLI Deluxe to return from the Asus repair center as it broke
> down.
> 
> Notice that beside my driver WIP, there also is one written by Jordan
> Crouse I just noticed when looking it up in my archive that he hasn't
> send it to the list yet, so I've attached it here. Both drivers need
> quite some work before being acceptable for mainline inclusion. The one
> done by my students is incomplete, and the one done by Jordan Crouse
> (attached) needs to have atleast the following issues fixed:
> 
> * remote vcc and vcpp are not valid input names, please see
> Documentation/hwmon/sysfs-interface for valid sysfs attr names.
> 
> * You're handling of the alarms is wrong, now a days we have one alarm
> file per inpuit, again see: Documentation/hwmon/sysfs-interface
> 
> * Don't call a driver adt74xx even if it will support multiple chips, it
> may very well never support all chips matching the xx mask, so instead
> just call it after the first support chips, other documentation like the
> wiki-page and sensors-detect will show to use this driver for releated
> chips.

I have some updates for that, but I have been very lazy in sending it 
out.  I'll send it out today, if it will help.

Thanks for the kick,
Jordan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
