From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm_sensor on a Netvista
Message-Id: <20021124121103.7fdfe7bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <MEEOLGLAMCNGBPBBBFHOCEGOCDAA.guillaume@apostoly.com>
In-Reply-To: <MEEOLGLAMCNGBPBBBFHOCEGOCDAA.guillaume@apostoly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 1/ are your sure that lm_sensors only mess up with 24RF08
> eprom system ?
This is the only case that was reported.

> 2/ if so, can I check if my computer as got this eprom, with a "cat
> /proc/something" or else, and so take an older version with doesn't do
> the machine check and install lm_sensors ?
There is no known way to detect it, else we'd have used it instead of
detecting IBM systems.
If you want to bypass the warning and use lm-sensors, *at your own
risk*, I can tell you how to do so *in private*.

> 3/ I read in the documentation that :
> "IBM Thinkpads contain a proprietary Embedded Controller which
>    is used to access sensors. This controller is not on the SMBus,
>    and IBM will not release the programming interface to the
>    controller. So lm_sensors isn't useful on Thinkpads anyway."
> What is that device, and is there a way to use it under linux ?
As long as IBM doesn't release the programming interface, no.

> 4/ is IBM aware of the problem, and do they want to make something for
> that ? I know that IBM is pretty involved in the Gentoo distribution,
> so maybe that way, contacting the package maintener for gentoo
> lm_sensor we could achieve something
We have being trying for years (actually it started even before I joined
the project) to get information from IBM but it never came to any useful
end. Recently, Pam Huntley has been helping us and there now is an
official Thinkpad identification chart
(http://www.pc.ibm.com/qtechinfo/MIGR-45120.html). Though it will be of
some help, it doesn't really solve anything as long as we don't know
which Thinkpads (or even other IBM systems, or even other non-IBM
systems) have been using the 24RF08.

> 5/ is their a SAFE way, to safe that eprom information and make tries
> with lm_sensors ? I mean, if I try lm_sensor, and that break my
> machine because of this eprom, what way have I got to fix it, and get
> a working system back ???
There are at least two reasons for which it is difficult to do so.
First, the EEPROM driver is read-only, so it would require that we
implement a writing interface. Second, as fas as I know, you don't know
you have destroyed anything before rebooting, and then it's too late.

If you can get more information from IBM, please share with us :)
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
