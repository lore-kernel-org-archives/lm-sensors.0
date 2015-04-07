From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Apr 2015 20:22:02 +0000
Subject: Re: [lm-sensors] [Skiboot] [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Message-Id: <1428438122.4947.6.camel@kernel.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
 <20150407164439.GA4514@roeck-us.net> <55241C02.60103@fr.ibm.com>
In-Reply-To: <55241C02.60103@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

On Tue, 2015-04-07 at 20:03 +0200, Cedric Le Goater wrote:
> 
> This is a shortcut. The code is for the ibmpowernv platform and assumes 
> that we are running on a P8 (8 hardware threads). It would be better to 
> use a "maximum threads per core" variable but I am not sure this is 
> available, as it is a tunable. I will look into it.

Yes, please don't hard code this...

Cheers,
Ben.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
