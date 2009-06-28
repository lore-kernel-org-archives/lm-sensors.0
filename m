From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Jun 2009 12:25:51 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/2] hwmon: Add support for TI's
Message-Id: <20090628142551.46c1314a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090626081031.GA4510@ubuntu>
In-Reply-To: <20090626081031.GA4510@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Jun 2009 10:10:31 +0200, Andre Prendel wrote:
> Hello Jean, Hans,
> 
> Here is an updated version of the tmp421 driver. I've fixed the issues
> according to your review. Please take a closer look at the
> is_visible() callback of the sysfs group. I'm using the attributes' index
> to decide whether the file is visible or not.
> 
> Jean, I know you're on vacation, so take your time :)

Now that the wiki is back, please update the TMP421 etc. entry.

> BTW I spend some time with my girlfriend at the Cote d'Azur last
> year. Probably the best vacation I've ever had. But speaking french is
> very difficult :)

Yes French is indeed very difficult :( but we have beautiful landscapes
and excellent cuisine :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
