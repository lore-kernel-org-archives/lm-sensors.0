From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <20040903124132.M74032@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and done
> 'modprobe i2c_sensor'!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> sysfs is mounted for sure
> 
> modules loaded:
> 
> eeprom                  6920  0
> lm85                   21380  0
> i2c_sensor              4096  2 eeprom,lm85
> i2c_i801                9744  0

What do you see in /sys/bus/i2c/devices/?

-- 
Jean Delvare
http://khali.linux-fr.org/
