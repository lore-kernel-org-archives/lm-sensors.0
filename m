From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 08 Jul 2014 07:56:30 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (smsc47b397) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140708095630.6ee74573@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404782858.10553.1.camel@phoenix>
In-Reply-To: <1404782858.10553.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 07 Jul 2014 21:06:58 -0700, Guenter Roeck wrote:
> On 07/07/2014 06:27 PM, Axel Lin wrote:
> > Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> > simplify the code a bit.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> We'll need a Tested-by: from someone for this one.

I can test this at the end of August if nobody beats me on it.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
