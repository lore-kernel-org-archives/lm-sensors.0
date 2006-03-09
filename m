From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Mar 2006 19:41:14 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <20060309204114.05a2d1f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut,

> I've just created a couple sysfs files in order to find out, and the 
> conclusion is that each additional sysfs file reduces the remaining free 
> memory by something on the order of 90-95 bytes.
> It turns out that the memory reported by 'free' varies quite a bit between 
> calls, which disturbs somewhat the precision of this measurement. I had to 
> create 10000 sysfs files in order to get a statistically significant 
> result. Now this result is correct on the 10% level, which I think is good 
> enough for our discussion.
> For this experiment, I used the same callback function for all sysfs 
> files, so each additional file has just one SENSOR_DEVICE_ATTR struct 
> definition and a device_create_file() call, but no extra supporting code.
> This is the typical situation for the individual alarm files, I guess.

Yes, you tested the right thing, thanks for reporting your results.

I have been conducting a similar investigation but on the theoretical
front. It seems that the amount of memory required by each additional
sysfs file (not counting the callbacks and creation) is the size of
stuct sysfs_dirent, plus 4 bytes (not sure why, most probably an
internal slab implementation detail.) This is 40 + 4 = 44 bytes on x86,
72 + 4 = 76 bytes on x86_64.

I don't know why your measurement suggests larger allocations. But even
with your value of 90-95 bytes it's still a rather small value.

> With current DRAM prices, 100 extra bytes correspond to extra costs of 
> around 1e-5 EUR or USD for each additional file, which I think is 
> tolerable.

I don't think this is a matter of price, but more of a matter of
consumed memory on already designed/deployed systems, especially on
embedded systems. Other systems typically have over 3000 sysfs files,
so a dozen more or less really doesn't change anything.

If we consider the w83627hf driver as an example (being one of the
drivers with the higher number of alarm+beep files in my individual
files model) the additional memory consumption is (on x86) 44 * 33 1452 bytes. This really isn't much, even for an embedded system. Such
systems will typically have between 600 and 1600 sysfs files already,
33 more or less (worse case) still aren't that much.

Last, here are the figures I promised some days ago:

Before my individual alarm files patches:

   text    data     bss     dec     hex filename
   6101    1344       4    7449    1d19 drivers/hwmon/f71805f.o
   4848    1052      16    5916    171c drivers/hwmon/lm63.o
   5861    1892      36    7789    1e6d drivers/hwmon/lm90.o
  15024    1356      16   16396    400c drivers/hwmon/w83627hf.o

-rw-r--r--  1 khali users 24129 2006-03-09 18:52 drivers/hwmon/f71805f.c
-rw-r--r--  1 khali users 18909 2006-03-09 15:23 drivers/hwmon/lm63.c
-rw-r--r--  1 khali users 22806 2006-03-09 15:23 drivers/hwmon/lm90.c
-rw-r--r--  1 khali users 45891 2006-03-09 15:23 drivers/hwmon/w83627hf.c

After the patches:

   text    data     bss     dec     hex filename
   6357    1696       4    8057    1f79 drivers/hwmon/f71805f.o
   5122    1196      16    6334    18be drivers/hwmon/lm63.o
   6185    2060      36    8281    2059 drivers/hwmon/lm90.o
  16126    2128      16   18270    475e drivers/hwmon/w83627hf.o

-rw-r--r--  1 khali users 25316 2006-03-09 19:04 drivers/hwmon/f71805f.c
-rw-r--r--  1 khali users 20174 2006-03-09 19:04 drivers/hwmon/lm63.c
-rw-r--r--  1 khali users 24235 2006-03-09 19:04 drivers/hwmon/lm90.c
-rw-r--r--  1 khali users 50068 2006-03-09 19:18 drivers/hwmon/w83627hf.c

Summary:

f71805f:   +608 binary ( +8.1%), +1187 source ( +4.9%)
lm63:      +418 binary ( +7.0%), +1265 source ( +6.6%)
lm90:      +492 binary ( +6.3%), +1429 source ( +6.2%)
w83627hf: +1874 binary (+11.4%), +4177 source ( +9.1%)

So the size increase is admittedly not neglectable and greater than I
would like, but it isn't (IMHO at least) unaccpeptable either,
especially when hardware monitoring drivers are not amongst the largest
drivers in the first place. Also note that the number of individual
alarm files depends on the number of channels and/or limits the device
has, so this approach won't suddenly turn a small driver into a large
one. The size increment had to be somehow proportional to the original
driver size.

If anyone has similar figures for Hans de Goede's proposal, for
comparison, I'll be happy to take a look.

Thanks,
-- 
Jean Delvare

