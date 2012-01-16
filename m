From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jan 2012 10:12:31 +0000
Subject: Re: [lm-sensors] kernel 2.6.32 i2c-isa w83781d via686a
Message-Id: <20120116111231.7c770706@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326658239.11934.YahooMailNeo@web29606.mail.ird.yahoo.com>
In-Reply-To: <1326658239.11934.YahooMailNeo@web29606.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Emilio,

Please keep the list Cc'd for the interest of other readers (which
might then turn into helpers.)

On Sun, 15 Jan 2012 23:57:41 +0100, e_defranco wrote:
> thank you very much for your very fast and very accurate info. I am very 
> gratefull to you ... I have spend my weekend to try to get lm-sensor working 
> again.
> 
> I have applied what you suggest me and all working now !!!

You're welcome :) I had the same problem on my old Asus A7V133-C one
year ago.

> In this moment I have installed old 2.10.8 of lm-sensors (yes, I know, I am 
> very lazy ... but i promise: update again to 3.3.1 in the next day) and I 
> have copied my old sensors.conf in /etc (without, the negative voltage are 
> not correct).
> 
> I have read that for new version 3.3.1 is sufficient put the part of old 
> sensors.conf that working for the hardware in /etc/sensors.d ... is correct 
> ??

Yes, this is correct. For performance reasons if nothing else, avoid
copying the old very large default configuration file we had. Instead,
copy only the specific configuration section you need to a separate
configuration file.

> If no, how I must convert the old file ? sensors-conf-convert 
> /etc/sensors.conf ??

Assuming you have saved the relevant part of your old configuration
file to /tmp/sensors-Asus-A7V.conf.old, you'd do:

# sensors-conf-convert < /tmp/sensors-Asus-A7V.conf.old > /etc/sensors.d/sensors-Asus-A7V.conf

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
