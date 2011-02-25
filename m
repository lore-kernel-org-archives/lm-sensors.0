From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 19:15:43 +0000
Subject: Re: [lm-sensors] W83795G Supermicro H8DGU-F
Message-Id: <20110225201543.46954439@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <77E104072DACA94993E7A23504E0C29F0559E9@ROCMXUS22.cs.myharris.net>
In-Reply-To: <77E104072DACA94993E7A23504E0C29F0559E9@ROCMXUS22.cs.myharris.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ray,

On Fri, 25 Feb 2011 18:51:34 +0000, Ubelhart, Ray wrote:
> Thank you for getting back to me and especially the driver it works great. I was using the older version because I was under the impression that it was necessary based upon the combination of applications and OS I need (lm_sensors, net-snmp, CentOS 5.5).

Please don't top-post, and keep the list in Cc.

> If lm_sensors greater than 3.0 works on CentOS 5.5 x86_64 2.6.18-194 is there any net-snmp version dependencies to use lm_sensors-3.2?

As mentioned on
http://www.lm-sensors.org/wiki/Download
you need net-snmp >= 5.5 for lm-sensors 3.x compatibility.

> Where can I download an rpm install for lm_sensors-3.2?

We do not provide binary packages, sorry. You may take your chance on
http://atrpms.net/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
