From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 07:25:02 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <20080716092502.1c7c6cb5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <487C5810.3030205@gmail.com>
In-Reply-To: <487C5810.3030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Tue, 15 Jul 2008 09:23:23 -0600, David Hubbard wrote:
> On Tue, Jul 15, 2008 at 4:40 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > What we really need for sensors-detect is simply the value of registers
> > 0x20 and 0x21, and values of registers 0x30, 0x60 and 0x61 for a
> > selected logical device. In what form we export these, needs to be
> > discussed.
> 
> Should superio-locks enumerate the available logical device ID's,
> perhaps as a sysfs interface?

I don't have anything precise in mind, I admit. All I can say is that
it needs to be extensible, in case we need to export more register
values in the future.

> >> David,
> >> do you have a preference wrt fn-ptr ? and if so, a single fn with 1 arg
> >> :  0,1,2 for enter/exit/query ?
> >> do you have any use for a flag bit ?  is there generality in it ?
> 
> I think we could just use the same enter and exit sequences for
> everything, and not make it customizable. Does that sound OK?

No. We can have a universal exit sequence, but enter sequences are
per-chip (or actually per chip family). That's even one part of the
device identification (lets us differentiate between two chips with the
same device ID register value.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
