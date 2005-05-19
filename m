From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <41DA735A.3090304@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Note that you don't really need i2c-viapro in this case (and it would
> even cause trouble if you were running a 2.6 kernel).

It was the proposal of sensors-detect some versions ago, so I inserted 
it. ;-) Kernel is still 2.4.

> Could you try not to run it after a cold reboot, and see what the
> initial value is? This will help us understand whether reading the value
> or writing the value is the problem.

I did a warm reboot (init 6; have no method of doing a cold reboot right 
now as this is a remote machine).

myhost:~# sensors
via686a-isa-0c00
Adapter: ISA adapter
CPU core:  +1.80 V  (min =  +0.06 V, max =  +3.10 V)
+2.5V:     +1.10 V  (min =  +0.06 V, max =  +3.10 V)
I/O:       +3.36 V  (min =  +0.08 V, max =  +4.14 V)
+5V:       +5.23 V  (min =  +0.13 V, max =  +6.44 V)
+12V:     +11.95 V  (min =  +0.32 V, max = +15.60 V)
CPU Fan:  5818 RPM  (min = 84375 RPM, div = 8)          ALARM
P/S Fan:     0 RPM  (min = 1222 RPM, div = 8)
SYS Temp:  +27.2?C  (high =   +45?C, hyst =   +40?C)
CPU Temp:  +21.6?C  (high =   +60?C, hyst =   +55?C)
SBr Temp:  +22.3?C  (high =   +65?C, hyst =   +60?C)

myhost:~# sensors -s
myhost:~# sensors
via686a-isa-0c00
Adapter: ISA adapter
CPU core:  +1.80 V  (min =  +0.06 V, max =  +3.10 V)
+2.5V:     +1.10 V  (min =  +2.37 V, max =  +2.62 V)
I/O:       +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +5.23 V  (min =  +4.51 V, max =  +5.50 V)
+12V:     +11.95 V  (min = +10.81 V, max = +13.20 V)
CPU Fan:  5443 RPM  (min = 84375 RPM, div = 8)          ALARM
P/S Fan:     0 RPM  (min = 1222 RPM, div = 8)
SYS Temp:  +27.3?C  (high =   +45?C, hyst =   +40?C)
CPU Temp:  +21.6?C  (high =   +60?C, hyst =   +55?C)
SBr Temp:  +22.3?C  (high =   +65?C, hyst =   +60?C)

> You can still try but I doubt it'll help. There is no reason why a
> working configuration file would suddenly stop working.

A newly installed sensors.conf didn't help.

> What you could do OTOH is manually delete the latest version of
> libsensors (3.0.7) in /usr/local/lib, so that the previous one is used
> instead (that would be 3.0.6 if you installed lm_sensors 2.8.8 before).
> If the readings are back to normal, then it has to be a library bug.

Here are the relevant files in my /usr/local/lib directory.
/usr/local/lib/libsensors.a
/usr/local/lib/libsensors.so -> libsensors.so.3
/usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.1
/usr/local/lib/libsensors.so.2.0.1
/usr/local/lib/libsensors.so.3 -> libsensors.so.3.0.7
/usr/local/lib/libsensors.so.3.0.0
/usr/local/lib/libsensors.so.3.0.1
/usr/local/lib/libsensors.so.3.0.2
/usr/local/lib/libsensors.so.3.0.3
/usr/local/lib/libsensors.so.3.0.4
/usr/local/lib/libsensors.so.3.0.5
/usr/local/lib/libsensors.so.3.0.6
/usr/local/lib/libsensors.so.3.0.7

Shall I simply delete libsensors.so.3.0.7? Or do I have to change the 
libsensors.so.3 symlink as well?

Thanks
Florian
