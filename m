From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Nat. Sem. PC87366
Message-Id: <20040424220654.3031fa26.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> testing the new pc87360.o module
> 
> sensors-detect correctly detects this sensor and outputs:
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Success... found at address 0xecc0
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Success... found at address 0xecd0
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Success... found at address 0xecf0
> 
> however, i am unable to see any sensor readings for this chip (i see
> eeprom readings), either through gkrellm (version 2.1.28) or by doing
> sensors (after having ensured /proc was loaded correctly, and after
> doing sensors-detect, sensors -s)
> 
> no errors were given, and installing the i2c version 2.8.4 package and
> cvs lmsensors2 for 04/23/04 in kernel 2.4.26 were no problem; however
> i am not seeing any result
> 
> my lsmod is:
> Module                  Size  Used by    Not tainted
> eeprom                  3856   0  (unused)
> pc87360                 9249   0  (unused)
> i2c-proc                6580   0  [eeprom pc87360]
> i2c-isa                  716   0  (unused)
> i2c-dev                 4096   0
> i2c-i801                4692   0
> i2c-core               15332   0  [eeprom pc87360 i2c-proc i2c-isa
> i2c-dev i2c-i801] e100                   50308   1
> ntfs                   54336   1  (autoclean)
> vfat                   10956   1  (autoclean)
> fat                    33304   0  (autoclean) [vfat]
> 
> so i am sure that i have the necessary modules loaded
> 
> is this a bug, or have i missed something?

Looks like a bug. Please enable DEBUG in Makefile, recompile, reinstall
and cycle the pc87360 module. Hopefully the logs (/var/log/* and/or
dmesg) will tell us where to look.

I admit to be surprised by the high value of the addresses returned by
sensors-detect and wonder if this could be the cause of the trouble. But
most likely I simply screwed something up when adding voltage and
temperature support. Nobody tested the module since as far as I know.

Thanks for testing.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
