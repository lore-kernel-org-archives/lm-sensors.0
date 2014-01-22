From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jan 2014 16:25:57 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <20140122162557.GA17689@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 22, 2014 at 05:01:28PM +0100, Mathias Gerber wrote:
> Hi Michael
> 
> On 22.01.2014 15:43, Michael Vorburger wrote:> Do I need any special
> drivers or other settings, for this motherboard? -
> > Thank you for any tips!
> Same mainboard here :-) Debian 7.3. My logfile looked almost the same.
> The chip on the mainboard is a NCT5538D. You have to get the module
> nct6775 from: https://github.com/groeck/nct6775
> 
> Build, install it and load the module. Run sensors to ensure that
> values are shown now. dmesg should something like:
> nct6775: Found NCT6791D or compatible chip at 0x2e:0x290
> 
Hi Mathias,

you were faster than me ;-). Michael, let me know if you have any problems with
the driver.

Note that the upstream driver supports the chip starting with kernel version 3.12.

> I had some issues with pwmconfig. The script tries to stop the fans
> completely. This does not work for the cpu fan (pwm2). I had to assign
> the pwm output pwm2 by hand to the inputs fan2_input.
> 
Interesting that pwmconfig doesn't recognize this. CPU fans usually never stop
completely, and afaik the script should recognize the speed change.

Anyway, I would recommend to use the chip's automatic fan control if possible.
It doesn't rely on a script running in the OS to control fan speeds, and
usually works pretty well (and can be reconfigured if you dislike the BIOS
settings).

Thanks,
Guenter

> This is my !! preliminary !! config for the mainboard:
> http://pastebin.com/JhysG21x
> -- 
> kind regards
>  Mathias
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
