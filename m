From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <LZuki27b.1100765995.7139670.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Tried this again, upon reboot typed sensors -s then ran sensors, still
> no change.  This appears to be an issue that many are having, in a
> webforum i particpate in, we are all encountering sensors not responding
> to changes in the conf file.  One user even deleted the conf file and
> replaced it with a dummy file, and sensors still worked.  As of now, we
> still cant find out how to talk to sensors and modify its output and
> computations.

Oh OK, looks like I misunderstood your exact problem in the first place.

Care to point us to the webforum in question for us to take a look?

> Have now removed all sensors additions to files, and sensors still loads
> and works, even at system boot, it tells me loading module lm sensors.
> So sensors will work without having information in other files (ie you
> dont need to modify any rc files to get it to work), but there is still
> the issue of how do you talk to lm sensors if its not reading the conf
> file?

At least this means that your distribution handles things by itself,
which is always more comfortable. However, this may also mean that
Mandrake did some changes to our code, which may explain it doesn't
work as usual.

Which configuration file are you editing exactly? The standard
configuration file location and name is /etc/sensors.conf. You may use
"strace sensors -s" to trace the execution of "sensors -s" and see
exactly where sensors gets its configuration data.

Jean
