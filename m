From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Feb 2009 17:06:03 +0000
Subject: Re: [lm-sensors] More information on Gigabyte GA-EX58-UD4P
Message-Id: <20090219180603.3494df35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49986A9C.6000606@gmail.com>
In-Reply-To: <49986A9C.6000606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Sun, 15 Feb 2009 11:18:52 -0800, Dean Loros wrote:
> I went to the website & got the most current sensors-detect....Important 
> info follows:
> 
> Driver `to-be-written' (should be inserted):
>    Detects correctly:
>    * ISA bus, address 0x290
>      Chip `ITE IT8720 Super IO Sensors' (confidence: 9)
> 
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
> To load everything that is needed, add this to one of the system
> initialization scripts (e.g. /etc/rc.d/rc.local):
> 
> #----cut here----
> # Chip drivers
> # no driver for ITE IT8720 Super IO Sensors yet
> /usr/bin/sensors -s
> #----cut here----
> 
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
> 
> 
> So my next question is:  What is the status of the ITE IT8720 driver & 
> what can I do to help the process along?

Please search for "IT8720F" on this page:
http://www.lm-sensors.org/wiki/Devices
It answers your first question.

If installing a bleeding-edge kernel isn't an option for you, you can
load the it87 driver with parameter force_id=0x8718. It will make the
it87 driver treat your IT8720F chip as if it were an IT8718F, which is
supported for a long time now. The IT8718F and IT8720F are essentially
compatible as far as the hardware monitoring block is concerned.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
