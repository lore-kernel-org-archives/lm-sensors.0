From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Feb 2009 14:27:46 +0000
Subject: Re: [lm-sensors] Help With a H8QMI-3 Motherboard
Message-Id: <20090210152746.35c367a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <498B0C97.6010900@ucar.edu>
In-Reply-To: <498B0C97.6010900@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Keith,

On Thu, 05 Feb 2009 08:58:15 -0700, Keith Romberg wrote:
> I have having a little bit of trouble with lm_sensors on a Supermicro 
> H8QMI-3 motherboard.  It is a 4 socket board with 4 Opteron 8354 CPUs. 
> Basically lm_sensors is reporting 2 CPU temp readings rather than 16 
> core temps.  Here is all the info about the system I could think of to 
> grab.  In sensors-detect I did notice the message:
> 
> "no driver for AMD K10 thermal sensors yet"
> 
> Is the AMD K10 sensor for the 8354 CPUs?

Yes. Actually the "K10" name is improper, we should refer to then as
"family 10h".

> Any help you be great.

There has been support for the family 10h floating around, in the form
of a patch to the k8temp driver. I've suggested to write a separate
driver because there was very little code in common between K8 and fam.
10h. But since then I have heard repeatedly that the fam. 10h sensors
were unreliable (pretty much the same as late K8 ones) so it is also
possible that we will never bother supporting these CPUs.

> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `w83793' (should be inserted):
>    Detects correctly:
>    * Bus `SMBus nForce2 adapter at 2e00'
>      Busdriver `i2c-nforce2', I2C address 0x2f (and 0x4b 0x4f)
>      Chip `Winbond W83793R/G' (confidence: 8)
> 
> Driver `w83627hf' (should be inserted):
>    Detects correctly:
>    * ISA bus, address 0x290
>      Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)
> (...)

These two chips should already provide good enough hardware monitoring
information. The lack of in-CPU digital sensors shouldn't be too much
of a problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
