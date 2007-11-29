From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 29 Nov 2007 18:16:39 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: No longer depend on libsysfs
Message-Id: <474F0207.9020905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071129120153.26879145@hyperion.delvare>
In-Reply-To: <20071129120153.26879145@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> Here is a proposed patch to make libsensors no longer depend on
> libsysfs. Instead, it accesses sysfs directly, using 3 embedded helper
> functions. My motivations for doing this are:
> * As far as I know, libsysfs is no longer maintained.
> * libsysfs does much more than we need. For example, when asking for a
>   device attribute list, libsysfs will read the contents and permissions
>   of all attributes. Not only does this waste CPU cycles per se, but in
>   the case of hwmon driver it also triggers register reads, which can be
>   slow for SMBus chips.
> * libsysfs enforces the difference between devices and class devices,
>   while future changes will be easier if we can handle both types alike.
> 

Good work!

I'm afraid I don't have the time to review this atm though, any other takers?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
