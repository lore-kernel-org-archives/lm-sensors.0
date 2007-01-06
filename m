From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 06 Jan 2007 09:07:51 +0000
Subject: [lm-sensors] W83627EHF and K8 support patch
Message-Id: <20070106100751.52ed18c9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <courier.459C5AC6.00006D6A@radagast.org>
In-Reply-To: <courier.459C5AC6.00006D6A@radagast.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dave,

On Wed, 3 Jan 2007 17:39:12 -0800 (PST), Dave Platt wrote:
> Hi, all.  After buying an MSI K8MM3-V motherboard and Sempron
> CPU, I found it expedient to add some additional support to the
> sensors package in order to monitor things properly.
> 
> The attached patch updates the lib/chips.c file in the 2.10.1 
> distribution, adding support for the W83627EHF voltage-sensing inputs, 
> and adding support for the "k8temp" PCI-bus temperature sensor
> (which I assume is actually a sense diode on the K8 CPU itself...
> it reacts very quickly indeed to CPU-load changes).

k8temp is a digital temperature sensor embedded in the K8 CPU itself.
The "PCI" refers to the way the driver can access the information, not
the location of the sensors.

> It's entirely possible that these changes duplicate or conflict
> with changes someone else has made since 2.10.1 was shipped...
> I haven't checked.

No, this had not been added yet, so I've applied your patch, with minor
changes. Thanks for your contribution!

I just noticed that in9 is not included in the w83627ehf part, I guess
it's an omission (because you didn't need it on this board) and I can
add it?

> Also attached are the relevant parts of my /etc/sensors.conf
> file.

Thanks, I've added it to my collection:
http://khali.linux-fr.org/devel/lm-sensors/

I've made some reformatting and also changed the limits for VBat which
didn't look quite right (nominal Vbat is 3.0V not 3.3V.) I also dropped
the temp3 label as I think I understand this input isn't used on your
motherboard, right?

> With these changes in place, sensord is capable of logging
> and round-robin'ing all three of this motherboard's temperature
> sensors, both fan speeds, and all of the voltages.

Great :)

-- 
Jean Delvare

