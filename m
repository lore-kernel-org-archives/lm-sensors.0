From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: sensors-detect enhancement needed for sysfs
Message-Id: <3FBA80BB.1090501@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB839E3.6C7D5CCD@paradyne.com>
In-Reply-To: <3FB839E3.6C7D5CCD@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

cat /proc/bus/i2c on a 2.4 machine. look what it gives you:
bus number, adapter name, algo name.
The perl code pulls each of those out.

Now do cat /sys/class/i2c-adapter/*/device/name on a 2.6 machine.
It gives you adapter name (bus number is in the *). Algo name isn't available.

Your assignment: scan /sys/class/i2c-adapter for installed busses,
get the name for each, put in a dummy algo name.


Jean Delvare wrote:

>>I've enhanced i2cdetect, i2cdump, and i2cset using the new common
>>function in i2cbusses.c to list all the i2c busses, whether in 2.4 or
>>2.6 kernels. In 2.6 it's essentially 'cat
>>/sys/class/i2c-adapter/*/device/name' but see i2cbusses for details
>>like finding the sysfs mount point.
>>
>>We need a perl volunteer to make a similar enhancement at two places
>>in sensors-detect where it scans /proc/bus/i2c.
>>
>>Note that the adapter name, but not the algorithm, is available in
>>sysfs. I've hacked around that in libsensors and in the programs
>>above. Guess it's not really necessary.
>>
>>Anybody like to tackle sensors-detect?
> 
> 
> I'm on it, providing you tell me what exactly I'm supposed to do there.
> 

