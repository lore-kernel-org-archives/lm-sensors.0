From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: IBM hardware
Message-Id: <20040316212746.72098257.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403161623.00418.rafael.espindola@ic.unicamp.br>
In-Reply-To: <200403161623.00418.rafael.espindola@ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have a IBM ThinkCentre. When I run the sensors-detect program it
> displays some warnings and informs me that the  BIOS version is
> 2AKT32ABR.
> 
> This is a desktop machine. Does the reported problem with thinkpad
> applies?

Probably not, although we are not certain of anything.

> How may I help in supporting this machine?

Edit the sensors-detect script so as to skip the detection, and see what
happens. Be aware you are on your own if it breaks something though
(which is why there is this detection after all).

I also invite you to download dmidecode CVS:
http://jdelvare.net1.nerim.net/sensors/dmidecode-CVS-2004-03-15.tar.gz

And give a try to vpddecode. It's an identification program aimed at IBM
systems. I need feedback on it to enhance it and in the end allow "safe"
IBM systems to go through sensors-detect. If your system happens to be
safe, I could update the sensors-detect script so that it is the first
IBM to be accepted, and the list would then grow as people report
successes.

> Could you include me in the development list?

Phil?

> Thank you.

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
