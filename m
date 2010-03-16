From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Mar 2010 16:30:31 +0000
Subject: Re: [lm-sensors] adt7473 for NVIDIA
Message-Id: <20100316173031.118bfa44@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100316155203.GD25138@alpha.zimage.com>
In-Reply-To: <20100316155203.GD25138@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Mar 2010 08:52:03 -0700, Phillip Pi wrote:
> Reply-To: 
> In-Reply-To: <20100316163333.7f5911f7@hyperion.delvare>
> 
> > > I noticed this kernel upgrade detected something new: 
> > > http://pastie.org/872083 (too long to post in here). It never detected 
> > > adt7473 module, but it never show it in sensors command. What is it? 
> > > From a quick Google search, it seems to be fan controls or something?
> > 
> > Hardware monitoring chip, on your graphics adapter. Getting these to
> > work if often tedious because nVidia is not cooperating. Try the
> > following (as root):
> > 
> > # echo adt7473 0x2e > /sys/bus/i2c/devices/i2c-4/new_device
> > 
> > Then "sensors" might show more.
> 
> # echo adt7473 0x2e > /sys/bus/i2c/devices/i2c-4/new_device
> # sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +21.8°C  (crit = +96.8°C)                  
> 
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +39.0°C                                    
> Core1 Temp:  +27.0°C                                    
> 
> adt7473-i2c-4-2e
> Adapter: NVIDIA i2c adapter 
> in1:         +2.99 V  (min =  +0.00 V, max =  +2.99 V)   
> +3.3V:       +3.21 V  (min =  +0.00 V, max =  +4.38 V)   
> fan1:       1511 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =  164 RPM)  ALARM
> fan4:          0 RPM  (min =    0 RPM)
> temp1:       +60.0°C  (low  = +65.0°C, high = +85.0°C)  ALARM  
> Board Temp:  +53.0°C  (low  = +20.0°C, high = +60.0°C)  
> temp3:       +59.0°C  (low  = +80.0°C, high = +105.0°C)  ALARM
> 
> Thanks. Do I have to add this line to my /etc/rc.local or something to 
> get this to work all the time? Or does it change often? BTW, I am using 
> the latest NVIDIA beta driver.

Yes, you have to add it to some init script, otherwise you'll lose the
device at reboot. Now the problem is that the bus number (4 in your
case) could indeed change over time. And once again nVidia make it hard
for us by not giving unique names to their I2C adapters, so we can't
even select by name. All you can do is hope that the numbers won't
change.

WRT to the output itself, I doubt that your card has more than one fan,
so you can probably add ignore statements for fan2, fan3 and fan4 to
your configuration file. The rest looks reasonable.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
