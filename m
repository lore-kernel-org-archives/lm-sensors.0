From: decibel8@charter.net (David)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: 1250
Message-Id: <200306270944.25036.decibel8@charter.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, no luck so far. Having a little trouble with the cvs and little short
on time till Sunday.  
CVS i2c installed fine. CVS lm_sensors got an error during make right after:

lib/chips.c:2397: initializer element is not constant
lib/chips.c:2397: (near initialization for `adm1026_features[103]')
make: *** [lib/chips.ao] Error 1

Still seem to install fine during make install. 
Ran sensors-detect, seemed normal. Couldn't use the init script cause diff
than gentoos. 

bash-2.05b# lsmod
Module                  Size  Used by    Tainted: P
i2c-proc                6804   0
i2c-isa                  748   0  (unused)
i2c-viapro              3604   0  (unused)
i2c-core               15396   0  [i2c-proc i2c-isa i2c-viapro]

module via686a not loading though. Can't 'modprobe' or 'insmod' to get it working
gives:

bash-2.05b# insmod via686a
Using /lib/modules/2.4.20-gentoo-r5/kernel/drivers/i2c/chips/via686a.o
/lib/modules/2.4.20-gentoo-r5/kernel/drivers/i2c/chips/via686a.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg

The only thing I did before installing was:
uninstall i2c and lm_sensors. rmmod all the modules, had to take some out of /etc/modules.autoload and
reboot to get them out. Normal.  Rebooted. Then installed like said above. 
Will see if can get working at least by Sunday.
Didn't change anything in the kernel and via686a worked before.

build is linked to the correct kernel source, yadda, yadda.

Might put the ebuild in for i2c and then just try lm_sensors from CVS.

HMMMM, sensors -s doesn't work. Then checked and there is no /usr/bin/sensors.
Must not have install do to the error during 'make'


Dave







On Friday 27 June 2003 02:53 am, you wrote:
> > I will try putting the CVS on tonight. For now though here is
> > the info you were interested on about the patch.
>
> OK, thanks. It turns out to be unrelated to our problems, but
> interesting though. They customized some of messages at the end of the
> script to reflect files locations and names on Gentoo. Part of what they
> did could even make it back into our version.
