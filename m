From: gtg779q@mail.gatech.edu (gtg779q at mail.gatech.edu)
Date: Mon, 19 Mar 2007 04:13:16 +0000
Subject: [lm-sensors] Failure to Detect VT1211 chip on Averatec 3150P
Message-Id: <1174277596.45fe0ddc6e731@webmail.mail.gatech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
In-Reply-To: <1174094059.45fb40eb08206@webmail.mail.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Juerg Haefliger <juergh at gmail.com>:

> Well if you already know that it's a vt1211, why don't you just load
> the driver and see what happens? Do a 'modprobe vt1211' and check the
> kernel logs.
>
> On 3/16/07, brad.beglin at gatech.edu <brad.beglin at gatech.edu> wrote:
> > LM_sensors list,
> >
> > I have an Averatec 3150P laptop running Gentoo that I have been unable to
> get to
> > work with LM sensors.  The laptop has the VT8375 North Bridge, VT8233 South
> > Bridge, and the VT1211 super IO chip (platform documentation at
> > http://www.via.com.tw/en/products/chipsets/legacy/km266/).  I have
> attempted to
> > detect the VT1211 using the latest version of lm_sensors with both the
> linux
> > 2.6.19-r3 and 2.6.20-r1 kernels, with I2C, the via bus driver, and the
> VT1211
> > installed as both modules and built in.  On each attempt, the only thing
> that
> > detection script finds is the eeprom chip.  Is there some other kernel
> > configuration that I should try or another way that I can detect the super
> IO
> > chip?  If not, what else can I try?  Thanks

When I try to modprobe vt1211, I get the error:

Fatal: Error inserting vt1211
(/lib/modules/2.6.20-supend2-r1/kernel/drivers/hwmon/vt1211.ko): No such device

I noticed that there was a post similar to this about the driver not checking
all the appropriate addresses, so I also edited the driver to check the location
0x4e as noted in the mailing list, but even after recompiling, I got the same
result.  Sorry for the delay and thanks again.

--
Brad R. Beglin

