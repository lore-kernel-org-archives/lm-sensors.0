From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 04 Aug 2015 21:03:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8732F
Message-Id: <20150804230301.3e4ca369@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  4 Aug 2015 12:45:31 -0700, Justin Maggard wrote:
> Add support for the IT8732F.  This chip is pretty similar to IT8721F,
> with the main difference being that the ADC LSB is 10.9 mV instead of
> 12 mV.

10.9 mV. No kidding. Sigh.

Drunk people shouldn't be allowed to design chipsets really.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
