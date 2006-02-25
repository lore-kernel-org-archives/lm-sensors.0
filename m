From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 25 Feb 2006 15:38:35 +0000
Subject: [lm-sensors] Can't access procfs/sysfs file  - 2.6.14.6
Message-Id: <20060225153835.GB3101@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY115-F2032313B519534D280592CCFF30@phx.gbl>
In-Reply-To: <BAY115-F2032313B519534D280592CCFF30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Warren:

* Warren Wilder <wipwap19 at hotmail.com> [2006-02-24 19:51:45 +0000]:
> I have noticed others had this problem, but it turned out to be some 
> configuration issue. Hopefully this is the case for me as well. I am 
> slightly worried that I have to wait for the 'eeprom' module, which my Via 
> VT1211 chip seems to need.

That doesn't make sense: no sensors/hwmon chip needs the eeprom module.

> My system:  (Via SP13000)
> HLFS (Hardened Linux From Scratch) with kernel 2.6.14.6
> sysfs compiled and mounted
> 
> running sensors-detect notifies me of these required modules:
> i2c-viapro
> i2c-dev
> I can succesfully load both.

So, sensors-detect doesn't find vt1211?  Can we see the full output?

> When I run sensors I get this notice:
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!

What modules are loaded and/or builtin when you run sensors?

> The thing is, I haven't build libsensors with sysfs support, since the 
> INSTALL and QUICKSTART files inform me of not having to do anything, 
> besides 'make user and make user_install' if I have a 2.6 kernel with i2c 
> modules compiled.
> Since I also have udev on my system I am leaning towards missing some sort 
> of udev rule.

If you were running a 2.6.x kernel when you built libsensors, then it almost
certainly did the right thing.  You can run 'ldd `which sensors`' to be sure.

> Please inform me of the next step.

Reply-to-all with the requested info.  Thanks.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


