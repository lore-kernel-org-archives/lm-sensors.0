From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: lm_sensors device request
Message-Id: <1083673446.40978b66cd89e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
In-Reply-To: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have kernel 2.6.5 & lm_sensors 2.8.6, I compiled the
> kernel w/ modules for the i2c and did a make user &
> make user_install, I did have an old version of
> lm_sensors on but I removed it before I installed. 
> How could I check the libraries?

ls -l /usr/lib/libsensor*
ls -l /usr/local/lib/libsensor*

Make sure that you have a single regular file (and some symbolic links
pointing to it).

That said, I think I remember that there is a bug in sensors 2.8.6 (library)
for a few chips, including lm75. This is probably what you are hitting now.
I suggest that you give a try to lm_sensors CVS. Do not forget to run
"ldconfig" after installing it, so that the new library is taken into
account. Hopefully it'll solve you problem.

-- 
Jean Delvare
http://khali.linux-fr.org/
