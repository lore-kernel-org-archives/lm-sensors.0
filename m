From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [2.5] Help with ICH5 SMBus and W83627THF
Message-Id: <1055782344.8803.10.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055775351.19204.11.camel@nosferatu.lan>
In-Reply-To: <1055775351.19204.11.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2003-06-16 at 18:44, Greg KH wrote:
> On Mon, Jun 16, 2003 at 06:40:49PM +0200, Martin Schlemmer wrote:
> > > And does the attached patch help any?  Or does it not do anything?
> > > 
> > 
> > I am guessing you forgot the patch ? :)
> 
> No, just the proper wording :)
> 

Silly me :)

> I ment that the patch you had attached, did it help any?  Do you want me
> to apply it to the main tree?
> 

Well, the i2c-i801-ICH5-support.patch, you can, as nothing between
ICH4 and ICH5 smbus that we support have changed.

The i2c-w83781d-w82627thf-support.patch one "works" in the sence
that it cause the w83781d driver to "detect" the w83627thf, but
as I said ... that is about it for now =)


Regards,

-- 

Martin Schlemmer



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030616/5827d781/attachment.bin
