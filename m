From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Fwd: query on running sensors
Message-Id: <3C6E7F04.FACE3222@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You don't really have a 5595, you have a different SiS chip that
is not supported. Sorry.
See our 'new drivers' page for more information.
You also may wish to upgrade to our 2.6.2 release, 2.5.5 is very old.
mds


> Subject: query on running sensors
> Date: Wed, 6 Feb 2002 12:42:37 -0600 (CST)
> From: cchevur@siue.edu
> To: mdsxyz123@yahoo.com, bobd@stanford.edu, j.teh@iname.com,
>      darkside@chello.nl
> 
>   Hi
> 
>       I am trying to run lm_sensors on RedHat Linux 7.1 machine.
>   I did \"rpm -ihv lm_sensors-2.5.5-3.i386.rpm\" and installed the package
> 
>   After running \"sensors-detect\" I got the following 2 lines to be
>   inserted in a startup script:
> 
>   modprobe i2c-isa
>   modprobe sis5595
> 
>   I inserted the above 2 lines in /etc/rc.local file
> 
>   and also I inserted
> 
>   \\\"alias char-major-89 i2c-dev\\\" in /etc/modules.conf file.
> 
>   Then I rebooted, but sis5595 module is not getting loaded.
> 
>   dmesg output shows the following error:
> 
>   sis5595.o version 2.5.5 (20010115)
>   sis5595.o: Sensor base address uninitialized - upgrade BIOS?
>   sis5595.o: SIS5595 not detected, module not inserted.
> 
>   From the FAQ section of lm_sensors website I came to know that I
>   have to type the following line at the command prompt to initialize
>   the base address:
> 
>   modprobe sis5595 force_addr=0xADDRESS
> 
>   How could I know the address that I have to give in the above line
>   or what is the address that I have to give??
> 
>   Am I proceeding in the right direction or is there anything else
>   that I have to do?? Please help!!!
> 
>   Thankyou,
>   Chaitanya Chevuri
