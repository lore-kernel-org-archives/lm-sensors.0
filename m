From: juergh@gmail.com (Juerg Haefliger)
Date: Thu, 23 Feb 2006 02:02:27 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <191fb4ca0602221802l55957488t8bca7ebda45c9fa5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for the hint. You're right, I didn't have the "name" attribute
implemented but after fixing this, it still doesn't work. See the
strace output below, it looks like sensors is going after i2c-adapter
which of course is not there. Am I missing something here?

Thanks
...juerg


[snip]

lstat64("/sys/devices/platform/vt1211.24576/in0_max",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/vt1211.24576/in0_max",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/vt1211.24576/in0_max", O_RDONLY) = 5
read(5, "2630\n", 4096)                 = 5
close(5)                                = 0
lstat64("/sys/devices/platform/vt1211.24576/in0_min",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/vt1211.24576/in0_min",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/vt1211.24576/in0_min", O_RDONLY) = 5
read(5, "0\n", 4096)                    = 2
close(5)                                = 0
lstat64("/sys/devices/platform/vt1211.24576/in0_input",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
stat64("/sys/devices/platform/vt1211.24576/in0_input",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
open("/sys/devices/platform/vt1211.24576/in0_input", O_RDONLY) = 5
read(5, "1972\n", 4096)                 = 5
close(5)                                = 0
lstat64("/sys/devices/platform/vt1211.24576/hwmon:hwmon0",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/vt1211.24576/power",
{st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/vt1211.24576/uevent",
{st_mode=S_IFREG|0200, st_size@96, ...}) = 0
stat64("/sys/devices/platform/vt1211.24576/uevent",
{st_mode=S_IFREG|0200, st_size@96, ...}) = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
open("/sys/devices/platform/vt1211.24576/name", O_RDONLY) = 4
read(4, "vt1211\n", 4096)               = 7
close(4)                                = 0
open("/proc/mounts", O_RDONLY)          = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7fbb000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 300
close(4)                                = 0
munmap(0xb7fbb000, 4096)                = 0
lstat64("/sys/class/i2c-adapter", 0xbf923fcc) = -1 ENOENT (No such
file or directory)
write(2, "Can\'t access procfs/sysfs file\n", 31Can't access procfs/sysfs file
) = 31
write(2, "Unable to find i2c bus informati"..., 198Unable to find i2c
bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!
) = 198
exit_group(1)                           = ?
-bash-3.00#



On 2/22/06, Jean Delvare <khali at linux-fr.org> wrote:
>
> Hi Juerg,
>
> On 2006-02-22, Juerg Haefliger wrote:
> > Yes I did register the device with the hwmon class. It shows up under
> > /sys/class/hwmon/hwmon0/device
>
> Did you create a "name" device attribute? libsensors needs it to find
> out the chip name. i2c drivers don't need to explicitely create it
> because the i2c subsystem does it for them, but there is no such
> mechanism for platform drivers (yet).
>
> You can take a look at my f71805f driver to see how this is done. It's
> really simple.
>
> If it still doesn't work after that, you could strace sensors and see
> where it is failing.
>
> --
> Jean Delvare
>

