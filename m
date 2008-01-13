From: Carren Stuart <kiwionabike@xnet.co.nz>
Date: Sun, 13 Jan 2008 18:32:21 +0000
Subject: Re: [lm-sensors] lmsensors and gkrellm
Message-Id: <200801140732.21439.kiwionabike@xnet.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200801131658.26068.kiwionabike@xnet.co.nz>
In-Reply-To: <200801131658.26068.kiwionabike@xnet.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon January 14 2008 2:12:54 am you wrote:
> Hi David, hi Carren,

    Hi Jean :-)

> Note: lm-sensors doesn't have anything to do with hard-disk drive
> temperature. HDD temperature is retrieved through SMART and we don't
> have any support for that.

I didn't realise that but it's really interesting, because, until I got 
lmsensors working correctly, I couldn't get my hdd temp to show up in 
Gkrellm. Once I got the sensors sorted the hdd temp automatically showed up - 
prior to that it wasn't reading correctly and was always showing 0C. 

> On Sat, 12 Jan 2008 22:37:32 -0700, David Hubbard wrote:
> > The coretemp readings come from a digital temperature sensor inside
> > the processor. The processor provides PCI device entries which access
> > these internal sensors.
>
> Note: while this is true of AMD CPUs (k8temp is a PCI driver) this
> isn't how Intel CPUs work. The coretemp driver reads the temperature
> values from MSRs (model-specific registers) i.e. from the CPU directly.

So does that make the coretemp values more accurate/reliable than the 
thermal_zone temps?

~Carren

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
