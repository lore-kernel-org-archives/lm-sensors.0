From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <20050104120127.131dfa51.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I did a warm reboot (init 6; have no method of doing a cold reboot
> right  now as this is a remote machine).
> 
> myhost:~# sensors
> via686a-isa-0c00
> Adapter: ISA adapter
> CPU core:  +1.80 V  (min =  +0.06 V, max =  +3.10 V)
> +2.5V:     +1.10 V  (min =  +0.06 V, max =  +3.10 V)
> I/O:       +3.36 V  (min =  +0.08 V, max =  +4.14 V)
> +5V:       +5.23 V  (min =  +0.13 V, max =  +6.44 V)
> +12V:     +11.95 V  (min =  +0.32 V, max = +15.60 V)
> CPU Fan:  5818 RPM  (min = 84375 RPM, div = 8)          ALARM
> P/S Fan:     0 RPM  (min = 1222 RPM, div = 8)
> SYS Temp:  +27.2?C  (high =   +45?C, hyst =   +40?C)
> CPU Temp:  +21.6?C  (high =   +60?C, hyst =   +55?C)
> SBr Temp:  +22.3?C  (high =   +65?C, hyst =   +60?C)
> 
> myhost:~# sensors -s
> myhost:~# sensors
> via686a-isa-0c00
> Adapter: ISA adapter
> CPU core:  +1.80 V  (min =  +0.06 V, max =  +3.10 V)
> +2.5V:     +1.10 V  (min =  +2.37 V, max =  +2.62 V)
> I/O:       +3.36 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +5.23 V  (min =  +4.51 V, max =  +5.50 V)
> +12V:     +11.95 V  (min = +10.81 V, max = +13.20 V)
> CPU Fan:  5443 RPM  (min = 84375 RPM, div = 8)          ALARM
> P/S Fan:     0 RPM  (min = 1222 RPM, div = 8)
> SYS Temp:  +27.3?C  (high =   +45?C, hyst =   +40?C)
> CPU Temp:  +21.6?C  (high =   +60?C, hyst =   +55?C)
> SBr Temp:  +22.3?C  (high =   +65?C, hyst =   +60?C)

Do you have "set fanN_min" lines at all in your via686a-* section? They
are commented out by default, maybe you simply need to uncomment them
and run "sensors -s".

> Here are the relevant files in my /usr/local/lib directory.
> /usr/local/lib/libsensors.a
> /usr/local/lib/libsensors.so -> libsensors.so.3
> /usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.1
> /usr/local/lib/libsensors.so.2.0.1
> /usr/local/lib/libsensors.so.3 -> libsensors.so.3.0.7
> /usr/local/lib/libsensors.so.3.0.0
> /usr/local/lib/libsensors.so.3.0.1
> /usr/local/lib/libsensors.so.3.0.2
> /usr/local/lib/libsensors.so.3.0.3
> /usr/local/lib/libsensors.so.3.0.4
> /usr/local/lib/libsensors.so.3.0.5
> /usr/local/lib/libsensors.so.3.0.6
> /usr/local/lib/libsensors.so.3.0.7
> 
> Shall I simply delete libsensors.so.3.0.7? Or do I have to change the 
> libsensors.so.3 symlink as well?

You would delete libsensors.so.3.0.7 and then run "ldconfig", which will
update the link properly.

In the meantime, I will try to reproduce the problem on my own system.

-- 
Jean Delvare
http://khali.linux-fr.org/
