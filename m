From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Nov 2007 21:02:29 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 patch for (gnome) sensors-applet
Message-Id: <20071113220229.2549e680@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4738C247.4030501@hhs.nl>
In-Reply-To: <4738C247.4030501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 12 Nov 2007 22:14:47 +0100, Hans de Goede wrote:
> A patch for compiling sensors-applet against lm_sensors-3.0.0 is now available 
> from: http://www.lm-sensors.org/wiki/Download
> 
> Note that this patch also adds support to the lm_sensors-2.x code for reading 
> the low and high (sensors-applet speak for min and max) values from libsensors 
> instead of using hardcoded defaults depending on the sensor type.
> 
> This is thrown into the mix as the lm_sensors-3x support patch is incremental 
> to the min/max reading patch for the 2.x code.
> 
> Both patches have been send upstream.

Great, thanks for doing this!

So, are you done with your porting work? If so, and if you didn't find
any problem with the new libsensors API, is there any reason to delay
the release of lm-sensors 3.0.0 any further?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
