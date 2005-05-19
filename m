From: bweber@imsconsultants.com (Bob Weber)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: New i2c driver for ETX-mgx board from Kontron
Message-Id: <1056762095.4918.5.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1056749667.1873.35.camel@linux.local>
In-Reply-To: <1056749667.1873.35.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Mark.

The Kontron board is an x86-based board designed for embedded
applications. Most of what I read on the website seems geared towards
PCs, but i2c is big in the embedded world, and I'd personally like to
see such drivers supported on the website too. 

If you'll put it on the website, I'll send you the file and patches. I
think someone would find it useful. But, it is not really a general
interest board. Let me know what you think.

- Bob

On Fri, 2003-06-27 at 16:41, Mark D. Studebaker wrote:
> You can contribute by sending us a patch against CVS or against a 2.5 kernel.
> See also doc/developers/new-drivers in lm_sensors.
> However if the driver is not of general interest
> (I myself have never heard of Kontron, and GPIO bit-banger drivers
> are generally non-standard) then it may not be worth
> putting into CVS or the kernel.
> 
> 
> Bob Weber wrote:
> > Hello. I recently wrote (ported, actually) an i2c driver for the ETX-mgx
> > board from Kontron. This board uses a Winbond chip for I/O. The I2c
> > driver bit-bangs a couple I/O pins. 
> > 
> > How do I contribute this to the lm_sensors project? Besides the driver,
> > I modified Config.in and Makefile in the kernel drivers directory, and
> > i2c-id.h in the include/linux directory.
> > 
> > - Bob Weber
> >   R&B Embedded Technologies
> >   email: bweber@imsconsultants.com
> >   email: rjweber@ieee.org
> > 
> > 
> 
> 
