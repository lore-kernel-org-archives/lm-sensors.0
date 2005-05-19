From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: module not found?
Message-Id: <20020319152417.O31061@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020319152506.62cfadfe.lcampagn@mines.edu>
In-Reply-To: <20020319152506.62cfadfe.lcampagn@mines.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



It is in the Lm_sensors package: kernel/busses/i2c-i810.c  Of course,
it needs to be built accordingly for your system before you can use
it.  You may need to download the package and properly install it
(www.lm-sensors.nu) or get a more complete rpm/deb package (which we
don't make).  If you build the package from source, I'd suggest
fetching the source from CVS (which will very shortly be version 2.6.3
release)... instructions on the download page.

Good luck!


Phil

On Tue, Mar 19, 2002 at 03:25:06PM -0700, Luke Q Campagnola wrote:
> I am running Debian/Woody, kernel 2.4.17 .. I'm having a problem finding a module I need. Here's some of my sensors-detect output: 
> 
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): 
> modprobe: Can't locate module i2c-i801
> Loading failed ()... skipping.
> 
> 
> Despite much effort, I can not seem to locate this module anywhere. I have tried installing the most recent source, which didn't help. I was unable to find anything that would tell me the location of the driver in your FAQ or install docs, as well as th
e kernel documentation. I did find i2c-i801 on your drivers page, but again, that does not tell me where to get the driver. Does this driver come with the kernel, and if so, where is it located in the configuration? Does it come with your software? 
> 
> 
> Very Confused, 
> 
> Luke 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
