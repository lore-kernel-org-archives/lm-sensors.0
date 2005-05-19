From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket# 1566
Message-Id: <1076063242.40236c0adb748@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <02f601c3ebf9$5dacdde0$c8de11cc@black>
In-Reply-To: <02f601c3ebf9$5dacdde0$c8de11cc@black>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting kevin schlichter <kevins@tyan.com>:

> Your readings all look fine to me.  Are your assumptions based on
> the min= and max= settings in the /etc/sensors.conf file?
> 
> It looks like the tolerances in the sensors.conf file aren't set
> correctly, but I wouldn't pay too much attention to them anyway.
> DDR V doesn't have anything set at all, 3VSB should actually be
> 3.3VSB, and your battery will be fine all the way down to something
> like 2.4V before you start seeing CMOS errors on boot up.  For the
> sake of being thorough, I'll post a new version of the .conf file on
> our website in a few days.  Until then, I wouldn't worry about any
> of the readings you've posted here (except maybe your CPU temps
> which seem to be hot).

Once again, I have to say I'm impressed by the good support level Tyan
offers. Thanks Kevin :)

I sure will consider Tyan for my next motherboard. A number of
well-known brands are blacklisted already for not providing data sheets
for their chips and their lack of cooperation and support in general. I
hope that more brands will understand how important support is for
users and, as Tyan did.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
