From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Aug 2011 15:37:04 +0000
Subject: Re: [lm-sensors] Support for the Fintek F71889ED (found f.e. on the
Message-Id: <20110819173704.11833b3f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <616631172.20100723004130@eikelenboom.it>
In-Reply-To: <616631172.20100723004130@eikelenboom.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mathieu,

Please don't top-post.

On Tue, 9 Aug 2011 22:29:58 -0400, Mathieu Jobin wrote:
> Here is what I get running kernel 3.0 rc6
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue: 
> 
> Driver `to-be-written':
>   * ISA bus, address 0x600
>     Chip `Fintek F71889E Super IO Sensors' (confidence: 9)

Was this with the latest version of sensors-detect, as Hans instructed?
I doubt it. Please try again with:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

Note though, that this doesn't prevent you from loading the f71882fg
driver manually to see if it works.

> Driver `k10temp' (autoloaded):
>   * Chip `AMD Family 10h thermal sensors' (confidence: 9)
> 
> Note: there is no driver for Fintek F71889E Super IO Sensors yet.
> Check http://www.lm-sensors.org/wiki/Devices for updates.
> 
> No modules to load, skipping modules configuration.
> 
> Unloading i2c-dev... OK
> Unloading cpuid... OK

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
