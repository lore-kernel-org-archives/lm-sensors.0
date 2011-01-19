From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 19 Jan 2011 07:33:22 +0000
Subject: Re: [lm-sensors] user question about how to load xeontemp
Message-Id: <20110119073322.GA13904@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
In-Reply-To: <AANLkTimtTrZuU2VXQ0b=1_Z38hOQC-sst5B0F=YEdzL7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 19, 2011 at 01:29:28AM -0500, Jerry Lin wrote:
> > S5500HCV board spec shows a TMP75 sensor. Can you try to load the lm75 module instead?
> 
> "sudo modprobe lm75" yields no error message, but "sudo
> sensors-detect" yields the same result. ("modprobe -l | grep lm75"
> yields "kernel/drivers/hwmon/lm75.ko"). I'm not totally sure that I'm
> doing this correctly:
> 
You would have to run "modprobe -r adm1021" first.

Anyway, the board supports DDR3, and DDR3 has JC42 compliant temperature sensors
which are usually at i2c address 0x18..0x1f. So, especially if you have four DDR3 
DIMMs installed, that is probably what you have there.

Anyway, please load
	http://khali.linux-fr.org/devel/misc/sensors-detect
and run it. This is the latest version of sensors-detect. It should detect 
if the CPU supports sensors or not, and if the sensors at 0x18.. are jc42 sensors.
Make sure you remove the adm1021 driver before you run sensors-detect.

> sudo modprobe lm75
> [and then]
> sudo sensors-detect
> 
sensors-detect can only detect a sensor if the driver for it isn't loaded yet.

Also, you might want to run "modprobe ipmi-si" as suggested by the sensors-detect
output.

Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
