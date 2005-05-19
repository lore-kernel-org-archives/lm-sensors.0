From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Urgent lm_sensor question.  System failure??
Message-Id: <20011217164216.O21963@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C1E8DFE.D4A8792F@playground.net>
In-Reply-To: <3C1E8DFE.D4A8792F@playground.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Sometimes the health monitor chip can control fans, and may control
them in a variety of ways which lm_sensors may or may not effect.  Why
not try disabling lm_sensors and then do a full power reboot
(shutdown, power down, power up) to see if lm-sensors is really making
a difference?  BTW- 2.5.5 is a little old in case you want to try
upgrading (see our site: http://www.lm-sensors.nu )  Check for loose
connections on the fans, or try letting the computer sit in the Bios
screens for a while to see if the fan activity is different.
(Beware: Bios's are often busy-wait and can make your CPU hot
quickly if you fans aren't working right.)  Also be sure you are using
the correct chip driver and with the appropriate settings.

Good luck!


Phil

On Mon, Dec 17, 2001 at 07:29:50PM -0500, Gregory Gee wrote:
> 
>   First:
> 
> Abit BP6 with dual Celeron 400
> Redhat 7.2
> lm_sensor 2.5.5
> /sbin/modprobe i2c-isa
> /sbin/modprobe i2c-piix4
> /sbin/modprobe w83781d
> /sbin/modprobe eeprom
> 
>   Now, I have a quick question about what lm_sensor does.  Does it only read
> data or does it also control the fans?  The reason is that recently I have been
> getting sensor alarms about my Vcore and also my CPU fans have been individually
> turning on, off and slowing down.  Is lm_sensors doing this or is there a major
> CPU or motherboard problem.
> 
> Thanks,
> Greg

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
