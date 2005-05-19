From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: bmcsensors port to 2.6
Message-Id: <20050313175106.7d590cf2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> If I was to create a patch that allowed a more functional device sysfs
> callback, how likely would it ever be accepted into the mainstream
> kernel?

I can't answer to that, as I am not the one to decide. However, I am
ready to help you get your voice heard. I have already been asking for
something similar one year ago or so (when I started porting i2c chip
drivers to 2.6). The problem you have with bmcsensors exists with ALL
hardware monitoring drivers, it's just even more visible with yours
because there is no predefined number of sensor inputs for bmbsensors.
If you look at the other hardware monitoring drivers you'll find loads
of complex macros to define sysfs callbacks. I would be (very) happy if
we were able to get rid of that.

> To highlight the problem, having a maximum of 150 sensors in the
> bmcsensors drivers results in a kernel module 110kb in size, compared
> to a size of ~50kb for the driver with a limit of 50 drivers (due to
> the extra callback functions and pointers). Aside from the kludge that
> is the non-dynamic callbacks the driver uses currently it causes a
> real and unacceptable (in my opinion) inefficiency.

100% agreed.

Greg, I don't know if you remember the problem so I'll explain it
quickly here again.

Sysfs callback functions are very simple. It is possible to have several
files use to the same callback function but it is quite useless because
the callback function doesn't know who called it. In hardware monitoring
drivers, it's quite common that we need the same function for, say, all
voltage files or all temperature files. In 2.4, we could have a single
callback function, and an extra parameter allowed us to know from which
file the call was coming. In sysfs we cannot, which is the reason why
the hardware monitoring drivers have so many big macros to define
several callback functions at once. These macros make the code very hard
to read IMHO, and are error-prone.

So what I had been asking for some times ago, and Yani is asking for
again now, is an extension of the sysfs interface that would let us have
a single callback function for several interface files, with that
additional parameter, whatever form it takes. Is there a chance such an
extension could be accepted? How this would have to be done, if you
already have an idea on this? Or any reason why this isn't a good idea?

If it can be done and Yani works on this, I volunteer to test the result
and convert all the hardware monitoring drivers to the new system.

Thanks,
-- 
Jean Delvare
