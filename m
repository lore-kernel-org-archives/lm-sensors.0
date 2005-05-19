From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <gVC7WBw2.1104697101.1505630.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> you were partially right. ;-) By doing
> cp kernel/*.h /usr/local/include/linux
> it worked, the two files you mentioned were not enough.
> (...)
> Might this be a bug in i2c 2.9.0, that it does
> not copy files? I definitely issued a make install and received a
> "Successful"...

Yes, this is a bug, that will affect almost all users. My bad :(

> However, somethings seems to be wrong nontheless. A "sensors" delivers me:
>
> CPU Fan:  5818 RPM  (min = 84375 RPM, div = 8)          ALARM
>
> look at the min RPM count...

Which chip is this?

Did you run "sensors -s"?

Does the alarm wear off if you run "sensors" again?

You might simply need to set the min RPM count through the
/etc/sensors.conf file and run "sensors -s" afterwards.

--
Jean Delvare
