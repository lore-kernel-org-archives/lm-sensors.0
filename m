From: william.mcclintock@schriever.af.mil (McClintock William J Contr MCOM)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <B8BD20F161298A42A3B513D23A28556701101F39@fsglenex3.schriever.af.mil>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Requested output below...Sensors installed on this machine are CVS as of a
few days ago...I had to tweak a file to get the package to build but it was
for an unresolved definition for the <kernel/chips/fscher.c> driver file.
Should not have affected anything I hope.

Interesting side note...I have two systems both with the same Motherboard
and RAM setup, basically both system are identical except for video card and
peripherals.  One, the one with the issues, is running redhat 9 somewhat
up2date and the other Fedora Core 1(evaluating prior to second system
install).  The thing that's interesting is the Fedora Core 1 lm_sensors
works out of the box, sensors are functioning.  Also sensors-detect only
suggested i2c-isa and w83781d with Fedora Core 1.  Redhat 9 suggested those
two plus eeprom and i2c-nforce2.  Not sure if that's anything but I thought
it was odd...Just wanted to mention.

Bill

[root@workstation1 root]# cat /proc/sys/dev/sensors/eeprom-i2c-0-50/*
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
127 127 158 0 0 0 0 0 1 67 77 88 50 53 54 65
45 51 50 48 48 76 76 0 0 0 0 0 0 0 0 0
[root@workstation1 root]# which sensors
/usr/local/bin/sensors
[root@workstation1 root]# sensors -v
sensors version 2.8.1
[root@workstation1 root]# ldd $(which sensors)
        libsensors.so.3 => /usr/lib/libsensors.so.3 (0x4002c000)
        libc.so.6 => /lib/tls/libc.so.6 (0x42000000)
        libm.so.6 => /lib/tls/libm.so.6 (0x4005e000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)
[root@workstation1 root]# ls -l /usr/local/lib/libsensors.*
/usr/lib/libsensors.*
ls: /usr/local/lib/libsensors.*: No such file or directory
-rw-r--r--    1 root     root       144724 Nov 24 10:29
/usr/lib/libsensors.a
lrwxrwxrwx    1 root     root           15 Nov 24 10:33
/usr/lib/libsensors.so -> libsensors.so.3
lrwxrwxrwx    1 root     root           19 May  7  2003
/usr/lib/libsensors.so.1 -> libsensors.so.1.2.1
-rwxr-xr-x    1 root     root        79944 Jan 24  2003
/usr/lib/libsensors.so.1.2.1
lrwxrwxrwx    1 root     root           19 Nov 24 10:33
/usr/lib/libsensors.so.2 -> libsensors.so.2.0.1
-rw-r--r--    1 root     root       116278 Nov 17 11:17
/usr/lib/libsensors.so.2.0.1
lrwxrwxrwx    1 root     root           19 Nov 24 10:33
/usr/lib/libsensors.so.3 -> libsensors.so.3.0.0
-rw-r--r--    1 root     root       142747 Nov 24 10:29
/usr/lib/libsensors.so.3.0.0
[root@workstation1 root]#


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Tuesday, November 25, 2003 11:07 AM
To: Fernando Rocha Durso; McClintock William J Contr MCOM
Cc: sensors@Stimpy.netroedge.com
Subject: Re: unknown eeprom type (65) [ticket #1449]


Fernando, William,

Since you are experiencing the same problem with eeprom decoding, I
merge both threads here.

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 80 08 07 0d 0a 01 40 00 04 50 65 00 82 08 00 01   
            ^^
> 10: 0c 04 10 01 02 20 00 00 00 00 00 50 28 50 28 40  
> 20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00   
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 de  
> 40: 43 43 41 54 33 00 00 00 01 00 00 00 00 00 00 00   
            ^^
> 50: 00 00 00 00 00 00 00 00 00 00 00 02 00 00 22 00  
> (...)
> My memory is Samsung DDR 400, i have one DDR with 256 Mb
> I hope this is what you asked for...

Yes it is. Your memory type is correct (0x07 at 0x02 means "DDR SDRAM
DIMM"). But for an unknown reason, sensors reads the value at 0x42
instead (0x41 is 65).

The problem can come from three components:
1* The eeprom driver.
2* The libsensors library.
3* The sensors program.
Since I don't have a clue yet, I'd like you to provide the folling
additional information:

1* The output of "cat /proc/sys/dev/sensors/eeprom-i2c-0-50/*".

2* The output of "which sensors".

3* The output of "sensors -v".

4* The output of "ldd $(which sensors)".

5* The output of "ls -l /usr/local/lib/libsensors.*
/usr/lib/libsensors.*".

Hopefully it'll give me some ideas. Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
