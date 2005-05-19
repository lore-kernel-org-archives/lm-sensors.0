From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <aRoD3eq2.1100794761.1897410.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> This appears to be an issue that many are having, in a
> webforum i particpate in, we are all encountering sensors not responding
> to changes in the conf file. One user even deleted the conf file and
> replaced it with a dummy file, and sensors still worked. As of now, we
> still cant find out how to talk to sensors and modify its output and
> computations.

Please take a look at ticket #1817:
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket17

Looks exactly like your problem. Mandrake too. Isn't by any chance your
webforum Mandrake-related?

I really want to see the output of "strace sensors -s" for users having
the problem. It would also be very interesting to see if Mandrake
applied some patches to lm_sensors when building the RPM.

Thanks,
Jean
