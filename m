From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Mar 2010 22:18:43 +0000
Subject: Re: [lm-sensors] adt7473 for NVIDIA
Message-Id: <20100316231843.26fc3a12@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100316155203.GD25138@alpha.zimage.com>
In-Reply-To: <20100316155203.GD25138@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Mar 2010 12:30:11 -0700, Phillip Pi wrote:
> Interesting. I exited my X and back to bash/console, and GeForce 8800
> GT's sensors results are different now.
> 
> $ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +21.8°C  (crit = +96.8°C)
> 
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +34.0°C
> Core1 Temp:  +21.0°C
> 
> adt7473-i2c-4-2e
> Adapter: NVIDIA i2c adapter
> in1:         +2.94 V  (min =  +2.94 V, max =  +2.94 V)   ALARM
> +3.3V:       +4.31 V  (min =  +4.31 V, max =  +4.31 V)
> fan1:         82 RPM  (min =   82 RPM)  ALARM
> fan2:         82 RPM  (min =   82 RPM)  ALARM
> fan3:         82 RPM  (min =   82 RPM)  ALARM
> fan4:         82 RPM  (min =   82 RPM)  ALARM
> temp1:        -5.0°C  (low  =  -5.0°C, high =  -5.0°C)  ALARM
> Board Temp:   -5.0°C  (low  =  -5.0°C, high =  -5.0°C)  ALARM
> temp3:        -5.0°C  (low  =  -5.0°C, high =  -5.0°C)  ALARM
> 
> Is that normal especially for the temperature readings?

This is not "normal", but still expected: the I2C adapters are driven by
your X nvidia driver, which gets inactive when you get to the console.
This is a design flaw, the I2C buses should be working all the time,
blame nvidia for it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
