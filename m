From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 12:56:16 +0000
Subject: Re: [lm-sensors] w83781d - Unable to set fan1_div
Message-Id: <20090902145616.4dc421ee@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090813210941.8E3F9B0048@smtp.hushmail.com>
In-Reply-To: <20090813210941.8E3F9B0048@smtp.hushmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 14 Aug 2009 06:09:41 +0900, clubsoda@hushmail.com wrote:
> Board is ASUS P4T requiring i2c-i801 and w83781d modules, with 
> sensors reporting as99127f-i2c-0-2d.  Tried setting fan1_div, 
> fan2_div and fan3_div to 8 in sensors3.conf and sensors.conf but 
> even after reboot div=2 so the minimum reportable fan speed is 2657 
> RPM.

In order to set the new limits you must run "sensors -s" as root. It's
in the FAQ.

Rebooting will not help at all, quite to the contrary: settings are
almost always lost on reboot, so you have to run "sensors -s" again.
Some distributions include this step in their init scripts, some do not.

> 
> BIOS is not too great at displaying low fan speeds either but ASUS 
> Probe in Windows goes down to 900 RPM or lower so the hardware is 
> capable.
> 
> Xubuntu Karmic alpha 3 system plus all updates.
> sensors, libsensors v3.0.2
> kernel 2.6.31-5-generic

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
