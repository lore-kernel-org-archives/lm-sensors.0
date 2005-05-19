From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: SIS 645 (was: Re: SIS 630 (ID))
Message-Id: <200208261202.10783.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020823224314.A13520@mercury.solarsys.net>
In-Reply-To: <20020823224314.A13520@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

i have only one comment to our code ...
at line 292 you do not need to check_region ... you can call request_region 
and check return value ... if it's failed then return value is NULL ...

Regards,
Alexander

Am Sonntag, 25. August 2002 23:34 schrieben Sie:
> Hi there:
>
> A revised SiS645 SMBus driver is now here:
>
> http://home.pacbell.net/mh0ffman/sensors/i2c-sis645.c
>
> It uses PCI hotplug; the SMBus device shows up in lspci now.
> I couldn't see any reason to remove the device on module
> unload though.  I am still interested in your comments and
> suggestions.
>
