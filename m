From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Oct 2012 10:44:00 +0000
Subject: Re: [lm-sensors] SMBus access on PCI Express slots
Message-Id: <20121013124400.1faecc79@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO1EDAeLLDUqG7HWqnm=7AOd-j0HCAEwTrqw0s7onMEDCFpz=Q@mail.gmail.com>
In-Reply-To: <CAO1EDAeLLDUqG7HWqnm=7AOd-j0HCAEwTrqw0s7onMEDCFpz=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carson,

On Sat, 13 Oct 2012 21:16:17 +1100, Carson Au wrote:
> I am having trouble accessing the SMBus on PCI Express slots using
> lm-sensors or i2c-tools. I have attached my oscilloscope probes to the CLK
> and DATA lines, but even when I run sensors-detect, I can see no such
> activity on the line (lm-sensors does indeed find some i2c sensors).

I'd suggest using i2cdetect rather than sensors-detect for the job.
sensors-detect doesn't probe all addresses and skips some I2C adapters
by default.

> I am wondering if SMBus is even implemented on my Asrock Extreme 4
> motherboard (is it a mandatory requirement or just optional?).

I think it is mandatory, but even if it is the case you can't force
hardware manufacturers to follow the specification.

> Or maybe the SMBus connected to PCIe slots are behind an SMBus
> multiplexer?

This is a possibility, yes. Do you see all DIMM SPD EEPROMs? If not
the SMBus is certainly multiplexed.

On some boards there's a separate SMBus header. If your board has one,
you could try that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
