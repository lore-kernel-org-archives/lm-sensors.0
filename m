From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sun, 20 Aug 2006 02:15:58 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <4dfa50520608191915u3f212d6dlf87c30ce4868f7f1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 8/18/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi David,
>
> > > That's not enough, unfortunately. In case of error you must unregister
> > > the driver before returning. I also think we should print some message
> > > on error. Care to send an updated patch?
> >
> > Updated patch attached. I have tested it on my machine and everything
> > is working, but if other hwmon drivers use this, can they apply the
> > patch on their machine and see if the modules fail to load?
>
> Thanks for the update. I tested this with the it87 driver and it worked
> as designed, preventing the driver to load if an error occurs.
>
> Unfortunately you forgot to sign your patch. Can you please resend the
> patch with the proper Signed-off-by line? While you're there please
> also fix the indentation of the "return" line, which isn't correct.

Good catch!

Updated patch attached.

David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-isa_return_attach_adapter.patch
Type: application/octet-stream
Size: 871 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060819/4cd3cce9/attachment.obj 
