From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 16 Aug 2006 22:00:59 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <4dfa50520608161500v27b725f1p9f80fcf1b03c9947@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> That's not enough, unfortunately. In case of error you must unregister
> the driver before returning. I also think we should print some message
> on error. Care to send an updated patch?

Updated patch attached. I have tested it on my machine and everything
is working, but if other hwmon drivers use this, can they apply the
patch on their machine and see if the modules fail to load?

David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-isa_return_attach_adapter.patch
Type: application/octet-stream
Size: 815 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060816/f6006eed/attachment.obj 
