From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Apr 2007 13:56:45 +0000
Subject: Re: [lm-sensors] can't get tempurature readings!
Message-Id: <20070422155645.162b7340@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461F073C.3020400@coretech.co.nz>
In-Reply-To: <461F073C.3020400@coretech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jake,

Please keep the list in Cc.

On Fri, 20 Apr 2007 12:21:52 +1200, Jake Briggs wrote:
> Jean Delvare wrote:
> > Is this board advertised as having hardware monitoring capabilities? Do
> > you see temperatures or fan speeds in the BIOS setup screens?
> 
> Well the documentation from intel about this board say this 
> (ftp://download.intel.com/support/motherboards/server/se7210tp1-e/sb/tpsse7210tp1e20.pdf) 
> :
> 
> ---- 8< ---
> The Winbond* W83627HF-AW I/O Controller provides the following features:
> • Two serial ports
> • Serial IRQ interface compatible with serialized IRQ support for PCI 
> systems
> • PS/2-style mouse and keyboard interfaces
> • Interface for one 1.44 MB diskette drive
> • Intelligent power management, including a programmable wake-up event 
> interface
> • PCI power management support
> The BIOS Setup program provides configuration options for the I/O 
> controller.
> ---- 8< ---
> 
> It also says that "Hardware support for monitoring voltages, 
> temperature, and fans." is provided by "National Semiconductor 
> PC87431integrated management controller."

Ah. Smells like IPMI. That's a complex setup which isn't fully
supported yet. You'll have to take a look at this project:
http://bmcsensors-26.sourceforge.net/
I can't help you further with this, sorry.

> This machine shut itself down a couple of weeks ago due to a high cpu 
> temperature - investigation revealed broken fans! When I turned it back 
> on, the BIOS error log mentioned some code (I forget exactly what it 
> was) but googling told me that it was a high cpu temperature failure! 
> When I first installed linux on this machine, I was in a bit of a hurry 
> so when I installed lm-sensors and it didn't work straight away, I kind 
> of forgot about it!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
