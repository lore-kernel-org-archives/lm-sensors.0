From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 09 Mar 2006 20:05:12 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <44108A78.20801@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hartmut,
> 
>> I've just created a couple sysfs files in order to find out, and the 
>> conclusion is that each additional sysfs file reduces the remaining free 
>> memory by something on the order of 90-95 bytes.
>> It turns out that the memory reported by 'free' varies quite a bit between 
>> calls, which disturbs somewhat the precision of this measurement. I had to 
>> create 10000 sysfs files in order to get a statistically significant 
>> result. Now this result is correct on the 10% level, which I think is good 
>> enough for our discussion.
>> For this experiment, I used the same callback function for all sysfs 
>> files, so each additional file has just one SENSOR_DEVICE_ATTR struct 
>> definition and a device_create_file() call, but no extra supporting code.
>> This is the typical situation for the individual alarm files, I guess.
> 
> Yes, you tested the right thing, thanks for reporting your results.
> 
> I have been conducting a similar investigation but on the theoretical
> front. It seems that the amount of memory required by each additional
> sysfs file (not counting the callbacks and creation) is the size of
> stuct sysfs_dirent, plus 4 bytes (not sure why, most probably an
> internal slab implementation detail.) This is 40 + 4 = 44 bytes on x86,
> 72 + 4 = 76 bytes on x86_64.
> 
 > I don't know why your measurement suggests larger allocations. But even
 > with your value of 90-95 bytes it's still a rather small value.
 >

AFAIK each sysfs file has a inode behind it which has been fixated in 
the inode-cache. This is also one of the more worry some parts IMHO, if 
we completly fill the inode-cache (which can be configured to be quite 
small on embedded systems) this will cause a performace impact. This is 
all AFAIK / IMHO.

> Also note that the number of individual
> alarm files depends on the number of channels and/or limits the device
> has, so this approach won't suddenly turn a small driver into a large
> one. The size increment had to be somehow proportional to the original
> driver size.
> 

Well, the uguru driver would have 100 alarm (mask/beep/shutdown) files 
on my mb instead of the current 14!
(this number could vary depending on the exact config of the uguru on a mb)


> If anyone has similar figures for Hans de Goede's proposal, for
> comparison, I'll be happy to take a look.
> 


To get an idea of the extra code size for the mask creation I've removed 
the loops doing the masking in the uguru driver and replaced them with a 
simple function which gets/sets values directly from the data using 
attr->nr and/or attr->index .

Results:
With loops:
[hans at shalem uguru]$ ls -l abituguru.o abituguru.ko
-rw-rw-r-- 1 hans hans 232871 Mar  8 15:14 abituguru.ko
-rw-rw-r-- 1 hans hans 154472 Mar  8 15:14 abituguru.o

Without loops:
[hans at shalem uguru]$ ls -l abituguru.o abituguru.ko
-rw-rw-r-- 1 hans hans 231191 Mar  9 21:12 abituguru.ko
-rw-rw-r-- 1 hans hans 152816 Mar  9 21:11 abituguru.o

This would also spare one array with the sensor masks in show to user 
order a 16 bytes which is malloced.

So this saves around 1.8k code and would cost around 9k malloced (+ 
possible fragmented page size loss) data.



Also think about the number of extra file handles and / or open/closes a 
userspace program would need to have / do with this interface.

Regards,

Hans


