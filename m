From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 26 Jun 2009 10:02:33 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/2] hwmon: Add support for TI's
Message-Id: <4A449CB9.9040703@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090626081031.GA4510@ubuntu>
In-Reply-To: <20090626081031.GA4510@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 06/26/2009 10:10 AM, Andre Prendel wrote:
> Hello Jean, Hans,
>
> Here is an updated version of the tmp421 driver. I've fixed the issues
> according to your review. Please take a closer look at the
> is_visible() callback of the sysfs group. I'm using the attributes' index
> to decide whether the file is visible or not.
>

looks good to me,

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
