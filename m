From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: A bit of information on nForce chipset
Message-Id: <3DA84C12.CB69B763@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <020903021452.M0195414@mbox.nc.kyushu-u.ac.jp>
In-Reply-To: <020903021452.M0195414@mbox.nc.kyushu-u.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
together with the xbox team we have confirmed this and checked
the changes into CVS.
We now have SMBus/sensors running on the xbox!
thanks again.
mds

"Yoshifumi R. Shimizu" wrote:
> 
> Dear Developers of the lm_sensor project:
> 
>       My name is Yoshifumi Shimizu.  I'm writing this mail because,
> first, I want to express sincere thanks for lm_sensor project, and
> second, I would like to provide a bit of information concerning
> the nForce chipset.
> 
>      I am developing a motherboard monitor program for FreeBSD (it
> also runs on Linux box, though), named "xmbmon/mbmon", which is
> a userland program and not of device driver type.  In the very
> initial version I did not know about the lm_sensor project,
> but after certain version up, I am using the information abount
> the SMBus and the sensor chips directly from the code of your
> project.  In this sense I am very much indebted to you (Of course,
> I am make acknowledgements to your project in my program).  I
> apprecitate your activity very much.
> 
>      Next, I looked into the newest verion lm_sensor-2.6.4, and
> found that the nForce chipset is supported in the amd756 code.
> But, I noticed that the SMBus base address is fixed as 0x5500.
> I have been working on the SMBus issue of the nForce chipset in
> the newest verion of my "xmbmon/mbmon", and I got information
> on how to get the SMBus base address from my collegue (FreeBSD
> freaks).  The nForce SMBus base address is obtained through
> the offset 0x14 in the PCI configuration registor, just as
> the offset 0x58 for the AMD756/766/768 chipset.  This friend
> of mine has Asus A7N266 motherboard, and in this way the
> SMBus base address can be obtained with the result being
> correctly 0x5500.  I'm not sure that this base address is
> always fixed as 0x5500, but if not, this offset 0x14 in the
> PCI configuration may be an useful information.
> 
>      If you want to check in the code, please try to see
> the code of my programs, xmbmon version 2.00, which is now
> downloadable from my web page:
> 
>    http://www.nt.phys.kyushu-u.ac.jp/shimizu/download/download.html
> 
>     With best regards,             Yoshifumi R. Shimizu
