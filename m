From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 31 Mar 2015 21:09:51 +0000
Subject: Re: [lm-sensors] [PATCH 04/15] hwmon: (it87) Introduce feature flag to reflect internal in7 sensor
Message-Id: <20150331230951.295a4c55@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 31 Mar 2015 09:22:37 -0700, Guenter Roeck wrote:
> On 03/31/2015 09:19 AM, Guenter Roeck wrote:
> > Good point. The idea was to use the macros on data, but of course they work on
> > sio_data as well. I'll rework the patches to do that.
> 
> Actually, if you are ok with it, I would prefer do that in a separate
> (additional) patch. I can do the same for has_vid(), so I'll make those
> changes in a single patch.

Sure, whatever is easier for you.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
