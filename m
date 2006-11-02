From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 02 Nov 2006 08:17:31 +0000
Subject: [lm-sensors] [Patch] Fintek F75375S/SP chip driver
Message-Id: <VlDWEaSC.1162455451.6428440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Riku,

On 10/31/2006, Riku Voipio wrote:
>last time I mailed this, I didn't get any feedback - Is this the
>wrong place to send drivers for chips? Also I can't seem to find a
>way to register to the wiki to update the devices entry..

It is the right place, unfortunately it seems that nobody had the
interest and time to reviewing your code, and I'm currently not able to
do so myself either.

As for the wiki, we had to disable anonymous changes to avoid being
spammed. If you intend to become a regular contributor to our project,
we can create a named account for you, just ask. Otherwise, just tell us
what change you would like to do on the wiki and we'll do it for you.

> Compared to the previous version posted here, changes are minimal.
> The driver is slightly more compact and fan is started at full speed
> by default.

This sounds like a bad idea. Loading the driver should not make any
change to the device configuration.

> I didn't bother with the libsensors stuff, since supposedly
> there is a generic sysfs-reading version coming out soon.

"Soon" might take several months. Please provide patches to sensors and
libsensors, so that your driver can receive proper testing in the
meantime. Take a look at the f71805f part for a not-too-heavy
macro-and-loop-based implementation.

Thanks,
--
Jean Delvare

