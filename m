From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 27 Feb 2014 17:20:54 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <20140227182054.60082612@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Dominik,

On Thu, 27 Feb 2014 12:26:46 +0100, Dominik Egert wrote:
> after playing around for a day or so, i've come up with a new config file
> for the Gigabyte B75-D3V Mainboard.
> 
> The chip in use is the it8728, and sensor input is differently wired to
> other Gigabyte mainboards. 
> 
>  
> 
> I wasn't able to ignore the sensors from pkg-*

First time I see this. I don't know which driver does this but this
looks pretty wrong, "pkg" is way too generic as a device name. This
should be fixed quickly.

> Also the acpitz-* dies not give reasonable values, they don't change at all.

Feel free to ignore them then.

> BTW: It would be nice to have a Webpage/DB to contribute configurations
> utilizing a webform.

The formatting in this e-mail is simply too bad for me to even look at
your configuration file. If you want it to be reviewed and go in the
wiki, please resend it in a way which does not destroy the formatting.

Thanks,
-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
