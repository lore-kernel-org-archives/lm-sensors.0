From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 14:21:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Do not accept name attributes which include '-'
Message-Id: <20140302152120.50aee250@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replying to myself...

On Sun, 2 Mar 2014 14:17:43 +0100, Jean Delvare wrote:
> I seem to recall there was a plan to have a flag to skip certain
> thermal zones in the thermal-to-hwmon bridge, was it ever implemented?
> We'd need exactly that.

Yes, it was implemented. I'll submit a patch for the
x86_pkg_temp_thermal driver as soon as I am done testing.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
