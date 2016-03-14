From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 14 Mar 2016 19:40:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: add support for Sensirion SHT3x sensors
Message-Id: <20160314194039.GA5557@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <157916ADD54A1D4ABFF27DDF0233870C956E1A93@S-EXCH01.sensirion.lokal>
 <20160310191411.GA2388@roeck-us.net>
 <157916ADD54A1D4ABFF27DDF0233870C956E1FE3@S-EXCH01.sensirion.lokal>
In-Reply-To: <157916ADD54A1D4ABFF27DDF0233870C956E1FE3@S-EXCH01.sensirion.lokal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pascal Sachs <Pascal.Sachs@sensirion.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Frey <David.Frey@sensirion.com>

Hi Pascal,

On Mon, Mar 14, 2016 at 03:28:52PM +0000, Pascal Sachs wrote:
> Hi Guenter
> 
> Thank you for the fast code review.
> During extended testing of the updated driver we found some other minor issues with the alert feature we would like to fix before submitting again.
> 
Take your time - you missed the commit window anyway.

> We as well have to update our submission process, since the company mail server converts tabs to whitespaces and adds this confidentiality message to the end.
> I am very sorry about that, but I did not knew that.
> 
No problem. Must be a server from that company in Redmond, WA ;-).

In case it helps, I use "git send-email" in combination with msmtp,
which in turn is configured to send mail either through a gmail account
or, if that happens to be tagged as spam source, through a web hosting
account.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
