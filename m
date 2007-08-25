From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 25 Aug 2007 17:23:42 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] sensors3: Optimize command line
Message-Id: <46D0659E.7050607@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070825151433.0fab41fe@hyperion.delvare>
In-Reply-To: <20070825151433.0fab41fe@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Thanks to the new prototype of sensors_get_detected_chips, we no
> longer need to build an array from the chip names passed on the
> command line. Instead, we can process them one after the other
> directly. This saves some memory and allows for minor code cleanups.
> 
Looks good to me,

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
