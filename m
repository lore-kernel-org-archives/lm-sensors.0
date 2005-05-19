From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <BB4EE78E.6D51%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 31.7.2003 15:24, "Jean Delvare" <khali@linux-fr.org> wrote:

> 
>> I just installed lm-sensors 2.8.0 on my Debian PPC - it said:
>> Installation successful. My computer hung itself up when I done
>> sensors-detect. At startup I know get:
> 
> At which point of sensors-detect dit hit hang?
I think after looking for the ISA-Bus.

> 
>> vector: 300 at pc = e238c288, lr = e238f080
>> Msr = 9032, sp = d8817cf0 [d8817c40]
>> Current = d8816000, pid = 661, comm = modprobe
>> Mon>
>> 
>> My Gnome-Startup hangs and nothing at all happens. When I reboot the
>> same happens again.
>> 
>> Any hints how I can get my computer back working again?
> 
> Gasp :( All that work to only break your computer... Maybe we should
> have just given up before.
I looged into the console with fn+ctrl+alt now when I run sensors I get:
Error while loading  shared libraries: libsensors.so.2: cannot open shared
oject file: No such file or directory

What does that mean?
> 
> You need to access your filesystem from another way (usually, Linux
> installation CDs offer a way to get a working console, or you have to
> boot from one or two floppy disks). Once you're there, you'll have to
> mount your root partition somewhere. For example, do:
> 
> mkdir /tmp/root
> mount /dev/hdb1 /tmp/root
> 
> (This assumes that your Linux root disk is /dev/hdb1. Change to whatever
> it is).
> 
> Then, go to /tmp/root/etc/rc.d/sysconfig/. You must have a "lm_sensors"
> init script there, which is the one that crashes your system. Delete it:
> 
> rm -f /tmp/root/etc/rc.d/sysconfig/lm_sensors.
> 
> Then unmount your root dir:
> 
> cd /
> umount /tmp/root
> 
> And reboot the usual way. Things should be back to normal.
My computer still boots but it just does not start GNOME.

Where do I have to look for the startup script of lm-sensors? In /etc/rc.d?

Thanks for Feedback.

Zeno
