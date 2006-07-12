From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 12 Jul 2006 00:26:10 +0000
Subject: [lm-sensors] AMD K8 digital temperature sensor
Message-Id: <4dfa50520607111726h5450881dn24fdafd2435c4d2e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A9941C.4020106@sh.cvut.cz>
In-Reply-To: <44A9941C.4020106@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Attached is a zip file containing the results of the k8temp driver on
my machine. It compiles and installs with no problems. The temperature
readings do not compare to what the w83627ehf reports. In the zip file
is comp_temp.gif which plots the results. It seems the digital
temperature sensors are located nearer the surface of the chip, or
perhaps are isolated thermally somehow, since they respond much faster
to a change in the load average. I did not test whether the
temperatures respond differently to a load applied to just one CPU.
Also, I do not know why the w83627ehf reports two temperatures from
the athlon 64 x2. It may be the processor has two analog temperature
pins. However, the temperatures are always within 1 degree C of each
other.

David

On 7/6/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Hi all,
>
> I have updated the archive at http://assembler.cz/download/amd_digital_temp.tar.gz
>
> So it supports the userspace too ;)
>
> There was a little problem with PCI support to libsensors but it seems I solved
> it somehow. I'm attaching the patch here too.
>
> It adds new bus of type PCI and does not change the "address" which is scalar.
> Instead it "concatenates" the PCI addr together.
>
> 0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
>
> k8temp-pci-0183
> Adapter: PCI adapter
> Core0Temp:   +47?C
>
> Regards
> Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: comp_temp_athlon64_x2.zip
Type: application/zip
Size: 165197 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060711/bd9325e4/attachment-0001.zip 
