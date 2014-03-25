From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 25 Mar 2014 11:36:12 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add support for IT8623E
Message-Id: <20140325123612.7715f56e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1354475868-10032-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

On Tue, 25 Mar 2014 11:12:46 +0100, Martin Herrholz wrote:
> i did install the module like mentioned in your linked Instructions and 
> redone the sensors-detect.
> I still get the same result:
> 
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8623
>      (logical device 4 has address 0x290, could be sensors)

This is expected, sensors-detect has its own detection code which is
independent from the installed drivers. You can try the latest version
at:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

which should detect your chip properly.

> I had no it87 module installed prior to it, so i had nothing to remove. 
> The module compiles/loads without errors.

Great. But does it work? What does "sensors" say?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
