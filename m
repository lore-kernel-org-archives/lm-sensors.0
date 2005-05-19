From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Troubles making sensors work with ASUS motherboard
Message-Id: <3CB723BA.181F5606@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CB6C091.1040109@berg.dk>
In-Reply-To: <3CB6C091.1040109@berg.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Martin Berg wrote:
> 
> 
> So in short my question is (assuming that it is not an other
> error): how do I determine the correct address for modprobe
> via686a ?
> 

use any address that won't conflict with things in /proc/ioports.


> via686a.o version 2.6.2 (20011118)
> via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr
> via686a.o: No Via 686A sensors found.
> via686a.o version 2.6.3 (20020322)
> via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr
> via686a.o: No Via 686A sensors found.

Hopefully this is you trying two separate versions and not two different
modules being loaded at once. Otherwise you have a problem.
