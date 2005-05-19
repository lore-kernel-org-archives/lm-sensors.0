From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <20041124225453.61d839df.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41A4C939.8050404@jonrkc.com>
In-Reply-To: <41A4C939.8050404@jonrkc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I finally figured out how to get the output of strace
> sensors.  It is attached
> as a text file to this email.
> 
> Thanks for your help so far!
> 
> Jon Rutherford

The strace looks fine, the configuration file is found, and read as
usual. I don't get it.

Could you please:

1* Send the whole configuration file to me, unmodified, for me to try on
my system.

2* Try installing lm_sensors 2.8.7 or newer from our sources. Download,
unpack, make user, make user_install and you're done. Be sure you
actually remove Mandrake's package before you do. And see if it changes
anything.

3* Provide the source RPM for the Mandrake lm_sensors package, or
preverably a pointer to that source RPM. I suspect that the Mandrake
folks included some home made patch that would prevent me from
understanding what's going on.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
