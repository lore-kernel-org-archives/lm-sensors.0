From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Nov 2007 14:55:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Let the user overrule the detected
Message-Id: <20071109155551.5b5c621f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071109000324.3ea312e1@hyperion.delvare>
In-Reply-To: <20071109000324.3ea312e1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 09 Nov 2007 09:03:31 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > While it is possible to force SMBus-based hardware monitoring chip
> > drivers to drive a not officially supported device, we do not have this
> > possibility for Super-I/O-based drivers. That's unfortunate because
> > sometimes newer chips are fully compatible and just forcing the driver
> > to load would work. Instead of that we have to tell the users to
> > recompile the kernel driver, which isn't an easy task for everyone.
> > 
> > So, I propose that we add a module parameter to all Super-I/O based
> > hardware monitoring drivers, letting advanced users force the driver
> > to load on their machine. The user has to provide the device ID of a
> > supposedly compatible device. This requires looking at the source code or
> > a datasheet, so I am confident that users can't randomly force a driver
> > without knowing what they are doing. Thus this should be relatively safe.
> > 
> > As you can see from the code, the implementation is pretty simple and
> > unintrusive.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Sounds like a good plan to me and the patch looks good to me too, notice that 
> it touches lots of files, so despite a best effort I may have overlooked a typo 
> of some kind.

Well most of it is cut'n'paste from one driver to the next, there's not
that much room for typos. Only the vt1211 and w83627ehf drivers are a
bit different because the original code was a bit different.

Just one thing that I'd like to change now that I think of it:
"overrule" is probably not the correct word, "override" would probably
be better. I'll submit an updated patch with this wording.

> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Thanks for the quick review :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
