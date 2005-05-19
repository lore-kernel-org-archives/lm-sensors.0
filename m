From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: VIA vt1211 chip driver for 2.6 available
Message-Id: <42375A95.1090304@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.60.0503041620390.5882@ekman10.ekmanhome>
In-Reply-To: <Pine.LNX.4.60.0503041620390.5882@ekman10.ekmanhome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the contribution.
i've tested your driver, have the following suggestions:
	- make ALL_SENSORS  the default, or even better remove all the #ifdef stuff
	- remove normal_xxx_range defines which cause compile warnings
	- remove uch_config  initialization in vt1211_init_client (trust the BIOS initialization instead,
	    or use setting in sensors.conf)

I've checked in a fix in libsensors so that uch_config can be set by sensors -s.


If you can make these changes, and submit the patch to our mailing list,
with comments and a signed-of-by line, we can get it fed upstream.
mds

Lars.Ekman@bredband.net wrote:
> 
> Hello,
> 
> I have made a port of the driver for the VIA vt1211 to the
> Linux 2.6.x kernel series. The driver is available at;
> 
>   http://hem.bredband.net/ekmlar/vt1211.html
> 
> It has been around for about half a year and seems to have
> quite many users with VIA mini-itx boards. I have received
> very fiew complaints for some time so the driver seems
> reasonable stable.
> 
> I have received e-mails from users who wonders why the driver
> is not included in the kernel, so I send you this mail to tell
> that the driver exists.
> 
> Please include it in your source tree if you think it useful,
> and send me a mail if you think I should correct something.
> 
> 
> Best Regards,
> Lars Ekman
> 

