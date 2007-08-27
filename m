From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 27 Aug 2007 08:28:35 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] sensors3: Optimize command line
Message-Id: <20070827102835.4b358a50@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070825151433.0fab41fe@hyperion.delvare>
In-Reply-To: <20070825151433.0fab41fe@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 25 Aug 2007 19:23:42 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Thanks to the new prototype of sensors_get_detected_chips, we no
> > longer need to build an array from the chip names passed on the
> > command line. Instead, we can process them one after the other
> > directly. This saves some memory and allows for minor code cleanups.
> > 
> Looks good to me,

Thanks. All 3 patches applied now. I also made a big cleanup to
"sensors", mainly to better understand what exactly it needs from
libsensors, in the hope it'll help me in the last part of the API
review: sensors_get_all_features() and all the underlying features
gathering, designation and storage code. I'll work on this as time
permits during the week, and hopefully I can send a proposal for
discussion at the end of the week.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
