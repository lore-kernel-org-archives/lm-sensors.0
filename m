From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: adm1026 on dual opteron : No sensors Found
Message-Id: <3ED14172.6010400@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1053468785.3ecaa871cebf7@rand.angstrom.com>
In-Reply-To: <1053468785.3ecaa871cebf7@rand.angstrom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have not had segfault problems running 'sensors'.

segfaults are most often caused when there are different versions of 
libsensors installed on the system and the wrong one is being picked. 
(/lib/libsensors instead of lm_sensors-2.7.0/lib/libsensors).  Did you replace 
or delete the original /lib/libsensors libraries or set LD_LIBRARY_PATH to 
modify the library search path?

I am having a different problems with SuSE Linux though.

In lib/proc.c/sensors_proc_write, the function assumes that a sysctl() call 
won't modify the sysctl name array.   The same array is used twice.  First to 
read the existing values and then again to write the new values.

But an STRACE shows that the first element of the array is getting nuked (set 
to 0) during the read call.  The result is 'sensors -s' fails with:

    adm1026-i2c-0-2c: Can't access /proc file for writing;
    Run as root?

because the sysctl calls to write the new values fail.

Has anyone else had problems with sysctl on other distro's?  Is this fixed in 
CVS i2c?  (From which I could back-port a fix?)

:v)

Atish Datta Chowdhury wrote:

> Thanks very much. We can now see /proc/sys/dev/sensors/adm1026-i2c-0-2c.
> Compiling lm_sensors as 64 bit, however, gives segfaults while running
> sensors. gdb shows NULLs being passed to strcmp. Did you also encoutner
> segfaults on running 64 bit sensors, or is this our build weirdness ..? 
> 
> -thanks again,
> Atish
> 
> 
> Quoting Philip Pokorny <ppokorny@penguincomputing.com>:
> 
> 
>>There is an SMBus MUX on this motherboard that prevents the ADM1026 from
>>
>>being accessable by default at boot.  You need to poke the MUX to enable
>>
>>the ADM1026 onto the SMBus.
>>
>>I have a BIOS (beta? 1.60) from Arima that you should be able to get 
>>from your Arima rep that is supposed to enable the ADM1026 onto the 
>>SMBus by default.  I haven't tested it yet, but suspect it will work.
>>
>>However, in the mean time, you can poke the mux by running i2cdump 
>>against address 0x70 on the SMBus.  That has the effect of enabling all
>>
>>the MUX sub-busses and making the ADM1026 visible.  So if you:
>>
>>    modprobe i2c-amd756
>>    i2cdump 0 0x70
>>    modprobe adm1026
>>
>>You should see the chip.
>>
>>:v)
>>
>>Atish Datta Chowdhury wrote:
>>
>>>Hi,
>>>       Appreciate any help on getting an adm1026 on a dual opteron
>>>working. I am listing my observtions below. 'Will be grateful for
>>>any solution to this..:
>>>
>>>     Problem summary:
>>>     ----------------
>>>
>>>     Motherboard : Arima (BIOS 1.50) dual opteron
>>>
>>>     When using lm_sensors with the patch from penguincomputing
>>>
>>(Philip
>>
>>>Pokorney), the adm1026 can be detected by sensors-detect, but even
>>>
>>after
>>
>>>     a correct build and install of the suggested modules, we get the
>>>
>>>     following error upon running sensors:
>>>     "No sensors found"
>>>
>>>     Possible cause:
>>>     ---------------
>>>
>>>     We did not see the adm1026 either under /proc/sys/dev or
>>>
>>/proc/bus/i2c
>>
>>>     The modules loaded at the time of running sensors were:
>>>     i2c-core, i2c-dev, i2c-proc, i2c-amd756, adm1026.
>>>     Are there patches (e.g to adm1026 or i2c-proc) that we are
>>>
>>missing?
>>
>>>     Detailed description:
>>>     ----------------------
>>>
>>>     1) downloaded i2c-2.7.0 and lm_sensors 2.7.0 from
>>>     http://www2.lm-sensors.nu/~lm78/download.html
>>>     2) patch adm1026 on to lm_Sensors-2.7.0 from  
>>>
>>>
>>ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-adm1026-
>>
> 9.patch
> 
>>>     
>>>     3) Build (64 bit) against 2.4.19 (Suse's distribution : United
>>>
>>Linux 1.0))
>>
>>>        builds with nominal problems
>>>     4) Install  (both i2c and lm_sensors)
>>>     5) sensors-detect finds adm1026 off the SMBus AMD8111 adapter
>>>        and lists i2c-amd756,  adm1026.
>>>     6) insmod modules i2c-core, i2c-dev, i2c-porc, i2c-isa ,
>>>
>>i2c-amd756 and
>>
>>>     adm1026:
>>>
>>>     i2c-core.o: i2c core module version 2.7.0 (20021208)
>>>     i2c-dev.o: i2c /dev entries driver module version 2.7.0
>>>
>>(20021208)
>>
>>>     i2c-proc.o version 2.7.0 (20021208)
>>>     i2c-amd756.o version 2.7.0 (20021208)
>>>     i2c-amd756.o: Found AMD8111 SMBus controller.
>>>     adm1026: Version 2.7.0 (20021208)
>>>     adm1026: See http://www.penguincomputing.com/lm_sensors for more
>>>
>>info.
>>
>>>     7) "sensors" gives:
>>>     No sensors found!
>>>
>>>-thanks and regards,
>>>Atish
>>>
>>>Atish Datta Chowdhury
>>>Software Engineer
>>>Angstrom Microsystems
>>>
>>>
>>
>>
>>-- 
>>Philip Pokorny, Director of Engineering
>>Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
>>PENGUIN COMPUTING, INC.
>>www.penguincomputing.com
>>
>>

