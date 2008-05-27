From: Ben Dooks <ben@fluff.org>
Date: Tue, 27 May 2008 19:41:43 +0000
Subject: Re: [lm-sensors] LM75 re-work,
Message-Id: <20080527194143.GC22585@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080527155308.GZ22585@trinity.fluff.org>
In-Reply-To: <20080527155308.GZ22585@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 27, 2008 at 08:00:00PM +0200, Jean Delvare wrote:
> Hi Ben,
> 
> On Tue, 27 May 2008 16:53:08 +0100, Ben Dooks wrote:
> > Is there a patch, or set of patches for the lm75 driver to
> > use the new i2c framework available in one bundle? I've had a
> > look over the list and was wondering if someone had gathered
> > together all the submissions?
> 
> There are 3 patches which are ready to go upstream at this point:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022931.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023040.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023041.html
> 
> Apply them in this order. In case the list archive corrupted the patches
> somehow, you can fetch them temporarily from my home server at:

Thanks, they applied with a bit of fuzz against my 2.6.26-rc4, and have
worked:

root@192:/# dmesg | grep tmp101
lm75 0-0049: hwmon0: sensor 'tmp101'

root@192:/# cat /sys/class/hwmon/hwmon0/device/temp1_input
26000

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
