From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Dec 2012 14:37:35 +0000
Subject: Re: [lm-sensors] i2c tools build failure with gcc 4.6
Message-Id: <20121220153735.2ae73802@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121220010733.GA31336@roeck-us.net>
	<20121220104510.2fa8a0fb@endymion.delvare>
	<20121220142006.GB32230@roeck-us.net>
In-Reply-To: <20121220142006.GB32230-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, 20 Dec 2012 06:20:06 -0800, Guenter Roeck wrote:
> On Thu, Dec 20, 2012 at 10:45:10AM +0100, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Wed, 19 Dec 2012 17:07:33 -0800, Guenter Roeck wrote:
> > > Seen with latest i2c-tools from svn repository.
> > 
> > With the subversion repository having gone on vacation, "latest"
> > doesn't mean much :(
> > 
> Oh, right, "the latest one I have", which is svn revision 6075. Is that the
> latest ?

"svn status -u" says 6091 but I think this includes the changes to
other trees (lm-sensors.) I have i2c-tools/CHANGES at revision 6083.

> > (...)
> > This could also be a Makefile dependency issue... I can't remember
> > what, if anything, guarantees that the library is built before the
> > tools which use it.
>
> Repeating the command doesn't help, though.
> 
> Maybe I am missing some commits ?

The error you get doesn't ring any bell and nothing in CHANGES seems
relevant.

If it helps, I have made my current SVN snapshot available at:
http://khali.linux-fr.org/devel/misc/i2c-tools-SVN.tar.gz

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
