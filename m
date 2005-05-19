From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Issue with lm-sensors 2.4.4.1
Message-Id: <20020411150704.A31673@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CB604BD.5B0E57DE@metroweb.co.za>
In-Reply-To: <3CB604BD.5B0E57DE@metroweb.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The latest version of Lm_sensors is 2.6.3.  To ensure the latest
compatibility and support, you need to upgrade.  I suggest you go to
our web site to get the latest: www.lm-sensors.nu

Also, the error seems to be a dependancy problem unrelated to the
lm_sensors code.  I suggest downloading the latest i2c and lm_sensors
sources and following the build instructions carefully.  Most module
issues we've run across are due to differing kernel sources,
compilers, or environment (e.g. kernel configuration settings) used
between the compiling of the kernel and the modules. 

Good luck!


Phil

On Thu, Apr 11, 2002 at 11:48:45PM +0200, Wayne Fallows wrote:
> Hi Joey
> 
> I am not sure if this is an issue or just my own stupidity. I have
> installed lm-sensors 2.4.4.1 on my Debian server 2.2.19.
> 
> I get the following error msg when dselect sets up lm-sensors (see
> lm_error). The motherboard that I am using is a EP-MVP3C their website
> is http://www.epox.com. I tried getting the out put of the
> "sensors-detect" with no success. It detects a Via-Pro but is unable to
> load mod not found. The chip I think it uses is VIA 82C596.
> 
> I have attached the dmesg and lspci outputs as text files.
> 
> I have read the support file and found that you do support this
> chip(ticket 316)
> 
> Regards
> 
> Wayne

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
