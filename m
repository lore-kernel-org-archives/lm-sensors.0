From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 08 Nov 2005 15:15:39 +0000
Subject: [lm-sensors] adm1027 on 2.6.9-5.EL
Message-Id: <e9MFXoYV.1131458537.5479210.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <XVkq04oM.1131444138.7357880.khali@localhost>
In-Reply-To: <XVkq04oM.1131444138.7357880.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Paul,

On 2005-11-08, Paul Aviles wrote:
> In a previous 2.4 kernel install I had stuff under /proc/sys/dev/sensors
> and I cannot see it in 2.6.9-5. I have nothing under /sys/bus/i2c or
> /sys/class/hwmon though I do get sensors to work as the report below.

Sorry but this just can't be true. In 2.6.9, hardware monitoring data is
found under /sys/bus/i2c (or more exactly $sysfs/bus/i2c where $sysfs is
your sysfs mount point). If "sensors" work, then /sys/bus/i2c must be
populated. Check again.

> When I compared to my 2.4 working machine i2c-proc which I "guess" is
> normal when reading the doc from i2c-2.8.8 as i2c-core is supposed to
> provide this??

Sorry, I can't make any sense of this sentence. Please rephrase.

> What I am missing is the fan stuff it used to be in the procs dir.
>
> What am I missing?

Do you refer to the fan control features? They should be under
/sys/bus/i2c/devices/0-002e, search for pwm* files.

> I used the sensors.init script to load the modules and this is the result
> of my lsmod.
>
> i2c_dev                11329  0
> eeprom                  8545  0
> lm85                   19433  0
> i2c_sensor              3521  2 eeprom,lm85
> i2c_i801                7757  0
> i2c_core               22081  5 i2c_dev,eeprom,lm85,i2c_sensor,i2c_i801

Looks OK to me. You usually don't even need i2c-dev, it's only used by
sensors-detect and for bus scanning/chip dumping.

> adm1027-i2c-0-2e
> Adapter: SMBus I801 adapter at 1480
> +2.6V:     +2.591 V  (min =  +2.47 V, max =  +2.73 V)

+2.6V isn't a usual VCC value, how did you come up with this label?

> vid:      -3.425 V  (VRM Version 9.1)

Wow. Not good. What value does /sys/bus/i2c/devices/0-002e/cpu0_vid
contain?

> Thanks guys, particularly to Jean.

You're welcome.

--
Jean Delvare
