From: frdurso@yahoo.com.br (Fernando Rocha Durso)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <1069782896.23807.12.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

root@athlon:/home/fernando# cat /proc/sys/dev/sensors/eeprom-i2c-0-50/*
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0
67 67 65 84 51 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 2 0 0 34 0

root@athlon:/home/fernando# which sensors
/usr/local/bin/sensors

root@athlon:/home/fernando# sensors -v
sensors version 2.8.1

root@athlon:/home/fernando# ldd $(which sensors)
        libsensors.so.2 => /usr/local/lib/libsensors.so.2 (0x40028000)
        libc.so.6 => /lib/libc.so.6 (0x40055000)
        libm.so.6 => /lib/libm.so.6 (0x4018b000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

root@athlon:/home/fernando# ls -l /usr/local/lib/libsensors.*
-rw-r--r--    1 root     root       119344 2003-11-18 21:07
/usr/local/lib/libsensors.a
lrwxrwxrwx    1 root     root           15 2003-11-18 21:07
/usr/local/lib/libsensors.so -> libsensors.so.2
lrwxrwxrwx    1 root     root           19 2003-11-18 21:07
/usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.1
-rw-r--r--    1 root     root       117212 2003-11-18 21:07
/usr/local/lib/libsensors.so.2.0.1

root@athlon:/home/fernando# ls -l /usr/lib/libsensors.*
/usr/bin/ls: /usr/lib/libsensors.*: Arquivo ou diret?rio n?o encontrado


Em Ter, 2003-11-25 ?s 18:06, Jean Delvare escreveu:
> Fernando, William,
> 
> Since you are experiencing the same problem with eeprom decoding, I
> merge both threads here.
> 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: 80 08 07 0d 0a 01 40 00 04 50 65 00 82 08 00 01   
>             ^^
> > 10: 0c 04 10 01 02 20 00 00 00 00 00 50 28 50 28 40  
> > 20: 60 60 40 40 00 00 00 00 00 00 00 00 00 00 00 00   
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 de  
> > 40: 43 43 41 54 33 00 00 00 01 00 00 00 00 00 00 00   
>             ^^
> > 50: 00 00 00 00 00 00 00 00 00 00 00 02 00 00 22 00  
> > (...)
> > My memory is Samsung DDR 400, i have one DDR with 256 Mb
> > I hope this is what you asked for...
> 
> Yes it is. Your memory type is correct (0x07 at 0x02 means "DDR SDRAM
> DIMM"). But for an unknown reason, sensors reads the value at 0x42
> instead (0x41 is 65).
> 
> The problem can come from three components:
> 1* The eeprom driver.
> 2* The libsensors library.
> 3* The sensors program.
> Since I don't have a clue yet, I'd like you to provide the folling
> additional information:
> 
> 1* The output of "cat /proc/sys/dev/sensors/eeprom-i2c-0-50/*".
> 
> 2* The output of "which sensors".
> 
> 3* The output of "sensors -v".
> 
> 4* The output of "ldd $(which sensors)".
> 
> 5* The output of "ls -l /usr/local/lib/libsensors.*
> /usr/lib/libsensors.*".
> 
> Hopefully it'll give me some ideas. Thanks.
