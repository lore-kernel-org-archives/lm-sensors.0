From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Mar 2012 05:28:34 +0000
Subject: Re: [lm-sensors] dual output buck controller pmbus based
Message-Id: <20120301052834.GA14856@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
In-Reply-To: <CANSBHnO8pQ_QVMpuS8JCoKfSvQ9s1_KDv-HybXD_TpM2jnPUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 29, 2012 at 11:52:42PM -0500, Vivek Bardia wrote:
> Hi Guenter,
> 
Hi Vivek,

> I still do not have any evaluation hardware.
> 
Too bad.

> By the way, my usage for TPS40400/TPS40422 is just output voltage control. Have
> no sensors being used in my scenario.
> 
> Will you be able to comment on my below steps and its validity:
> 
> 1. To get the current output I do a READ_VOUT and then convert it to microvolts
> format, for e.g. finally i get 942734uV
> 
> 2. To set a output voltage to say 902234 based on some requirement, 
> My nominal voltage being 1.1V
> hence trim_offset = 902234 - 1100000
> therefor I do: PMBUS_VOUT_TRIM with a value ffa7
> 
> Is the above logic right? my VOUT_SCALE_LOOP is 
> 600mV/1100mV x (2^9) = 279.27 => 100010111 => b917
> 
I can not really comment on that. The procedure is different for each chip, 
not always easy to understand, and it often takes quite some time to find
a working configuration. Best is really to use the tools provided by TI
(the Fusion GUI is quite good), since there tend to be other parameters
which need to be configured as well. I use the TI tools even for the test
boards I built myself. The TPS40xxx series is not as difficult as the
UCD92xx series when it comes to configuration complexity, but I would
still suggest to use the tools. If you misconfigure the chip, you might
burn it, so it pays to be careful.

Did you have a look into http://www.ti.com/lit/ug/slvu638/slvu638.pdf ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
