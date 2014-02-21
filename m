From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 21 Feb 2014 08:10:44 +0000
Subject: Re: [lm-sensors] [PATCH] sensors.conf.default: Add default voltage settings for nct6791
Message-Id: <20140221091044.6165890d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140220212423.0bd23f8f@endymion.delvare>
In-Reply-To: <20140220212423.0bd23f8f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 20 Feb 2014 21:21:55 -0800, Guenter Roeck wrote:
> On 02/20/2014 12:24 PM, Jean Delvare wrote:
> > Guenter, do I get it right that the NCT6791 has the same voltage input
> > constraints as the NCT6775 and NCT6776?
> 
> Yes, this is correct.
> 
> > Are there other Nuvoton chips that should be added to the list?
>
> NCT6779.

OK, I added both to sensors.conf.default.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
