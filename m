From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: [PATCH 2.6] I2C: Prevent buffer overflow on SMBus block read in
Message-Id: <20050201082241.GA22023@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050125224258.GA18228@kroah.com> <btE2IXvS.1106731047.5606340.khali@localhost>
In-Reply-To: <btE2IXvS.1106731047.5606340.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>

On Wed, Jan 26, 2005 at 10:17:27AM +0100, Jean Delvare wrote:
> 
> Hi Greg, all,
> 
> > Hm, all distros leave the i2c-dev /dev nodes writable only by root, so
> > this isn't that "big" of an issue.
> 
> Agreed. Non-root write access to these devices would probably be a
> security issue per se anyway, buffer overflow or not. However, I can't
> tell if e.g. some embedded systems wouldn't set a particular group on
> these device files and allow write access to this group, so as to allow
> some daemon to write data to an EEPROM or something similar. This is why
> I thought I better warn and push the patch upstream. I wasn't exactly
> requesting 2.6.10.1 to be released ;)
> 
> On second thought, I doubt that embedded designs would rely on a VIA Pro
> chip anyway. But you never know.
> 
> > > @@ -268,6 +268,8 @@
> > >  		break;
> > >  	case VT596_BLOCK_DATA:
> > >  		data->block[0] = inb_p(SMBHSTDAT0);
> > > +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
> > > +			data->block[0] = I2C_SMBUS_BLOCK_MAX;
> >
> > But data->block[0] just came from the hardware, right?  Not from a user.
> 
> True, except that with a write access to the device file and depending on
> the client chip, the user might have just programmed the chip for it to
> answer with this specific value. See right below.
> 
> > Now if we have broken hardware, then we might have a problem here, but
> > otherwise I don't see it as a security issue right now.
> 
> It doesn't take broken hardware.
> 
> (Warning: I am going technical at this point, people not interested in
> the gory details of the I2C and SMBus protocols should better stop here
> ;))

<snip>

Thanks for the good description.  I've applied your patch to my trees
and will push it upward soon.

thanks,

greg k-h
