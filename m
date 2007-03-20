From: curt@curtronics.com (Curt Blank)
Date: Tue, 20 Mar 2007 18:01:27 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf
Message-Id: <Pine.LNX.4.63.0703201254460.31125@www.curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
In-Reply-To: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ug. Yes I can do that and I will. I was just thinking in order to take a 
decent picture I'm going to have to disconnect everything and this server 
has a lot. I'll do that tonight. And thanks for the quick reply.

Just for grins yesterday I tried loading all the Winbond drivers and I got 
a number to load successfully but there were no sensors. Unless having 
multiple loaded causes a conflict. i2c_dev might not have been loaded 
though, if that makes a difference.

-Curt

On Tue, 20 Mar 2007, David Hubbard wrote:

> Hi Curt,
> 
> On 3/20/07, Curt Blank <curt at curtronics.com> wrote:
> > Motherboard: MSI K9N4 SLI-F
> > Chipset: nVidia nForce 500 SLI
> > SuSE Linux 10.1
> > Kernel: 2.6.16.27-0.9
> > lm-sensors: 2.10.0-10 (from SuSE 10.1 distro)
> >
> > I run sensors-detect that came with the SuSE distribution and it can't
> > find any sensors. So then I download and run the latest sensors-detect and
> > it tells me to use the w83627ehf driver. But when I try it fails:
> >
> > # modprobe w83627ehf
> > FATAL: Error inserting w83627ehf
> > (/lib/modules/2.6.16.27-0.9-smp-bnfsrvr/kernel/drivers/hwmon/w83627ehf.ko):
> > No such device
> >
> > It has a confidence of 9 but it fails. Am I missing something here?
> > w83627ehf has been in the kernel since 2.6.13, but do I maybe need a newer
> > version then I have?
> >
> > These are the modules currently installed:
> >
> > # lsmod
> > Module                  Size  Used by
> > i2c_dev                12552  0
> > hwmon                   5128  0
> > eeprom                  9488  0
> > i2c_isa                 7552  0
> > i2c_nforce2             9344  0
> >
> > I have the output from the sensors-detect if anyone wants to see it.
> 
> Can you post a URL to a datasheet or high-resolution image of your
> motherboard?
> 
> I suspect it is not actually a w83627ehf, 627ehg, or 627dhg chip in
> your board. The datasheet or image will help us figure that out.
> 
> David
> 
> 

