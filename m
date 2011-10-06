From: Himanshu Chauhan <hschauhan@nulltrace.org>
Date: Thu, 06 Oct 2011 04:18:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon class driver registration with a
Message-Id: <20111006040656.GA2125@ubuntu.ubuntu-domain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317834791-2803-1-git-send-email-hschauhan@nulltrace.org>
 <1317839407.3983.46.camel@groeck-laptop>
In-Reply-To: <1317839407.3983.46.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>, lm-sensors@lm-sensors.org

Hi,

> I can not comment on the merits of your patch. Unless I am missing
> something, which may well be since I only spent a couple of minutes on
> it, other device classes don't seem to provide a similar API, so I don't
> know if or why it would make sense for hwmon. Maybe a driver which wants
> to register a character device interface should do so independently of
> hwmon.
> 

The idea here is to sit in the same class directory as of hwmon. Devices
registered with this interface will have "dev" under, for example,
/sys/class/hwmon/hwmon0/dev. To do the same inside the driver will be
a bit more involved than a call.

In my opinion other classes should also have similar interfaces.

> On the technical side, EXPORT_SYMBOL is missing.
> 
I will take care of that.

Regards
Himanshu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
