From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Feb 2014 21:37:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140202223712.4e87be7e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391362768-27750-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391362768-27750-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 02 Feb 2014 13:04:47 -0800, Guenter Roeck wrote:
> On 02/02/2014 12:50 PM, Jean Delvare wrote:
> > Hi Guenter,
> >
> > On Sun,  2 Feb 2014 09:39:28 -0800, Guenter Roeck wrote:
> >> +	if (IS_ERR(hwmon_dev))
> >> +		return PTR_ERR(hwmon_dev);
> >
> > Why not return PTR_ERR_OR_ZERO?
> >
> Hi Jean,
> 
> Because I forgot that it exists and only remembered after I sent out the patch ;-).
> 
> I'll fix and resubmit. Should I split out the dev = &client->dev change
> into a separate patch ?

No, the lm80 and adm1024 drivers are simple enough, don't bother...

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
