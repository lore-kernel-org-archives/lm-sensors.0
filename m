From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 Jan 2008 13:12:54 +0000
Subject: Re: [lm-sensors] lmsensors and gkrellm
Message-Id: <20080113141254.1a7ea7c7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200801131658.26068.kiwionabike@xnet.co.nz>
In-Reply-To: <200801131658.26068.kiwionabike@xnet.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, hi Carren,

> On Jan 12, 2008 8:58 PM, Carren Stuart <kiwionabike@xnet.co.nz> wrote:
> > I'm running OpenSUSE 10.3 on an Acer Travelmate laptop with an Intel Core Duo
> > 1.6GHz processor.
> >
> > I finally figured out how to get lmsensors running and configured so that I
> > could get my hdd temps showing up in gkrellm.

Note: lm-sensors doesn't have anything to do with hard-disk drive
temperature. HDD temperature is retrieved through SMART and we don't
have any support for that.

On Sat, 12 Jan 2008 22:37:32 -0700, David Hubbard wrote:
> The coretemp readings come from a digital temperature sensor inside
> the processor. The processor provides PCI device entries which access
> these internal sensors.

Note: while this is true of AMD CPUs (k8temp is a PCI driver) this
isn't how Intel CPUs work. The coretemp driver reads the temperature
values from MSRs (model-specific registers) i.e. from the CPU directly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
