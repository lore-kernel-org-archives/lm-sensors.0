From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 12 Jan 2012 08:30:18 +0000
Subject: Re: [lm-sensors] Chipset not supported
Message-Id: <20120112083018.GA15774@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F09C52B.7070904@gmail.com>
In-Reply-To: <4F09C52B.7070904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 12, 2012 at 01:58:55AM -0500, Jean Delvare wrote:
> Hi Charles,
> 
> On Sun, 08 Jan 2012 11:32:43 -0500, Charles Wolf wrote:
> > Hello, I'm having temperature issues with my chipset, but it's not on 
> > the support list. I don't know how to help add things, and it sait to 
> > mail it out to the mailing list, so here it is, I am using a laptop with 
> > the Mobile Intel PM965 chipset. I'd help make it work, if someone told 
> > me what I need, or someone can do it themselves. I'm willing to help 
> > anyway I can. Thank you :D
> 
> Most laptops don't have usable sensors (other than the ACPI thermal
> zones and CPU integrated thermal sensors). Anyway we can't say anything
> about your specific system without seeing the complete output of the
> latest version of sensors-detect:
>   http://dl.lm-sensors.org/lm-sensors/files/
> 
> Also please check if the BIOS display voltage or fan speed values. If
> it doesn't (as is the case of most laptops) then there's probably no
> monitoring chip on this system so nothing we can do.
> 
I had a brief look into the PM965 datasheet (http://www.intel.com/Assets/PDF/datasheet/316273.pdf).
Apparently it has internal temperature sensors. It also supports Intel MEI,
which afaik can be accessed to read the chip (and possibly CPU) temperatures.
There is a MEI driver in staging, but I don't have any idea how to use it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
