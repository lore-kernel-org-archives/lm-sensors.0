From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH][2.5] Support for W83627THF sensor chip (Was Re: [2.5]
Message-Id: <1055813650.7227.23.camel@nosferatu.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055807044.7227.7.camel@nosferatu.lan>
In-Reply-To: <1055807044.7227.7.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2003-06-17 at 03:06, Mark D. Studebaker wrote:
> About a week ago I worked with
>   Matthias Hentges <matthias@hentges.net>
> to determine the device ID for this chip, and he supplied a patch which
> I worked into CVS, into the w83627hf driver and into sensors-detect.
> It was checked in last week.
> 
> This driver is designed for Super I/O chips and includes detection
> and activation. It uses ISA accesses.
> 

Ok, checked out CVS.

> I would rather not keep adding to the w83781d cruft, especially
> for Super I/O chips. Not only is the
> driver quite unwieldy already, but people have had lots of trouble
> with the Winbond Super I/O chips because they often aren't
> initialzed by the bios so the w83781d driver can't find them.
> ISA accesses are also much more reliable.
> 
> Please test the w83627hf driver in CVS and give us some feedback.
> 

Well, it is not yet ported to 2.5, and the state this box is
in (NPTL, etc), I _cannot_ use a 2.4 kernel.  I also do not know
if I currently have the time to port it to 2.5.

Finally, what is the plan .. split the w83781d into smaller
drivers for each class of chip ?  If so, don't you still
need i2c support for some w836* chips?  Won't then also
be better to call the drivers w837xx.c and w836xx.c ?


Regards,

-- 

Martin Schlemmer



-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030617/4ebe9368/attachment.bin
