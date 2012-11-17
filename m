From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 16:10:31 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211171610.qAHGAWKX008603@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Saturday, November 17, 2012 2:13 AM
> To: Leslie Rhorer
> Cc: 'Guenter Roeck'; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Getting alarms using lm-sensors
> >
> > echo "$TID $ATEXT  Value: $F2" | mail -a From:sensor_monitor -s "RAID-
> Server
> > Sensor Event Notification" xxxxxxxxxx@yyyyyyyyy.com
> 
> This is an UTF8 vs. non-UTF8 issue. You are running "sensors" with an
> UTF8 locale, but the e-mail you send apparently lacks proper encoding
> information. This can be solved in two ways: either set the locale to
> non-UTF8 when you run "sensors" (LANG=en_US sensors), or add some
> encoding parameter to the mail command (my version claims utf-8 to be
> the default but apparently that's not your case.)
> 
> --
> Jean Delvare

OK, this works:

mail -a "Content-Type: text/plain; charset=UTF-8" -a From:sensor_monitor -s
"RAID-Server Sensor Event Notification" ...

Would you guys be interested in me posting the script for future reference?
 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
