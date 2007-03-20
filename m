From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 20 Mar 2007 17:47:48 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf
Message-Id: <4dfa50520703201047j29d11c27w28d8d79f00d60064@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
In-Reply-To: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Curt,

On 3/20/07, Curt Blank <curt at curtronics.com> wrote:
> Motherboard: MSI K9N4 SLI-F
> Chipset: nVidia nForce 500 SLI
> SuSE Linux 10.1
> Kernel: 2.6.16.27-0.9
> lm-sensors: 2.10.0-10 (from SuSE 10.1 distro)
>
> I run sensors-detect that came with the SuSE distribution and it can't
> find any sensors. So then I download and run the latest sensors-detect and
> it tells me to use the w83627ehf driver. But when I try it fails:
>
> # modprobe w83627ehf
> FATAL: Error inserting w83627ehf
> (/lib/modules/2.6.16.27-0.9-smp-bnfsrvr/kernel/drivers/hwmon/w83627ehf.ko):
> No such device
>
> It has a confidence of 9 but it fails. Am I missing something here?
> w83627ehf has been in the kernel since 2.6.13, but do I maybe need a newer
> version then I have?
>
> These are the modules currently installed:
>
> # lsmod
> Module                  Size  Used by
> i2c_dev                12552  0
> hwmon                   5128  0
> eeprom                  9488  0
> i2c_isa                 7552  0
> i2c_nforce2             9344  0
>
> I have the output from the sensors-detect if anyone wants to see it.

Can you post a URL to a datasheet or high-resolution image of your motherboard?

I suspect it is not actually a w83627ehf, 627ehg, or 627dhg chip in
your board. The datasheet or image will help us figure that out.

David

