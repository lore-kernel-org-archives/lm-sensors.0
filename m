From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Mar 2013 14:40:54 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <20130305154054.57800e60@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362069993-9530-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362069993-9530-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Mar 2013 06:34:35 -0800, Guenter Roeck wrote:
> On Thu, Feb 28, 2013 at 08:46:30AM -0800, Guenter Roeck wrote:
> > On LTC2978, only READ_TEMPERATURE is supported. It reports
> > the internal junction temperature. This register is unpaged.
> > 
> > On LTC3880, READ_TEMPERATURE and READ_TEMPERATURE2 are supported.
> > READ_TEMPERATURE is paged and reports external temperatures.
> > READ_TEMPERATURE2 is unpaged and reports the internal junction
> > temperature.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Hi Jean,
> 
> I know I take way too much of your time, but do you have any
> feedback on this one ? 

Reviewing the end of this series is on my todo list, but after my daily
work and after my openSUSE 12.3 bug reports (will be released next
week.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
