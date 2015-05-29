From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 29 May 2015 21:20:44 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (nct6683) Add missing sysfs attibute initialization
Message-Id: <20150529232044.7d683ee9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432829756-14595-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432829756-14595-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 May 2015 13:24:10 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On 05/29/2015 01:50 AM, Jean Delvare wrote:
> 
> > Reviewed-by: Jean Delvare <jdelvare@suse.de>
> >
> > Looks like the abituguru and abituguru3 drivers suffer from the same
> > bug?
> >
> 
> Those drivers derive the attr values from a template which is pre-initialized
> with SENSOR_ATTR_2. With this, the initialization should be taken care of.
> Am I missing something ?

Probably not. My naive assumption was based on the lack of
sysfs_attr_init() call in these drivers. If the initialization is done
differently then alright. Thanks for verifying.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
