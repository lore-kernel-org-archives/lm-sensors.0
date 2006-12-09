From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 09 Dec 2006 20:47:32 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <457B20E4.8080701@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

*Is here some SuSE user around willing to help Ulrich with compilation please?*

Ulrich, kernel compilation is not what the beginners should face, if you wait
few months and then install new Suse (or update) then your system should have
the drivers and everything should be ok.

Your problem is in two places, you need to update the lm-sensors package first.
And then modify the kernel to replace the W83627EHF driver and patch the
coretemp driver.


As for the update:
We agreed with Khali that best is to do

make user_install

(so the libraries and utils will be 2x in fs)

So, please take the lm-sensors 2.10.1

unpack it, install libsysfs developement package, and issue following command:

cd directory_where_it_is
make user_install

Then make sure that new utils are linked with correct (new) library:

ldd /usr/local/bin/sensors

ldd /usr/local/bin/sensors
        libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0x00002b55b27ef000)
        libc.so.6 => /lib/libc.so.6 (0x00002b55b2948000)
        libm.so.6 => /lib/libm.so.6 (0x00002b55b2b85000)
        libsysfs.so.2 => /lib/libsysfs.so.2 (0x00002b55b2d07000)
        /lib64/ld-linux-x86-64.so.2 (0x00002b55b26d7000)

You should check first line if it is same as mine.

This is *UNFINISHED* how to compile the kernel, you may try some steps,
hopefully someone SUSE skilled will help about this:

(here is some semi guide, dont follow it just read it
http://en.opensuse.org/Setting_up_VMware_on_SUSE_Linux)

Generally you need

0) install GNU make, gcc, ncurses devel,
1) get kernel source package (2.6.18?) and kernel-syms
2) it will be extracted to directory /usr/src/linux
3) Then get this file:
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj

Rename it to w83627ehf.c and overwrite file in the /usr/src/linux/hwmon/

PI) get all patches for coretemp driver, use patch < ... to change the source.

You may skip this step, right now, lets try to compile the kernel with modified
EHF driver.

4) return to /usr/src/linux directory
5) issue make cloneconfig
6) issue make menuconfig

You should now see a menu, go to device drivers / hardware monitoring, find
W83627EHF and check if there is <M> symbol.

7) recompile and install kernel, Any suse user tell what exactly needs to be
done here?

I'm sorry about my support, but to give you detailed instructions would take me
a lot of time (because I'm not a SUSE user), and unfortunately I dont have it
right now. I hope that other members of the list will help.

Rudolf

