From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: i2c bit bashing adapter number allocation (fwd)
Message-Id: <200301291323.h0TDNbZ16513@morannon.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cam Mayor wrote:
From cmayor@iders.ca Wed Jan 29 01:25:05 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h0T0P4q01958 ; Wed, 29 Jan 2003 01:25:05 +0100
Return-Path: <cmayor@iders.ca>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Wed, 29 Jan 2003 01:25:05 +0100 (CET)
Received: (qmail-ldap/ctrl 15017 invoked from network); 29 Jan 2003 00:15:40 -0000
Received: from h24-66-20-25.wp.shawcable.net (HELO iders01.iders.ca) ([24.66.20.25]) (envelope-sender <cmayor@iders.ca>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 29 Jan 2003 00:15:40 -0000
Received: from kilauea.iders.ca (kilauea.iders.ca [200.123.101.201])
	by iders01.iders.ca (8.12.6/8.12.6/Debian-8) with SMTP id h0T0FM7d029699;
	Tue, 28 Jan 2003 18:15:22 -0600
Content-Type: text/plain;
  charset="iso-8859-1"
From: Cam Mayor <cmayor@iders.ca>
Organization: Iders Engineering Inc
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, simon@tk.uni-linz.ac.at,
   frodol@dds.nl
Subject: Re: i2c bit bashing adapter number allocation
Date: Tue, 28 Jan 2003 18:15:22 -0600
X-Mailer: KMail [version 1.2]
Cc: arm-linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
References: <03012817221704.02271@kilauea.iders.ca> <20030128233456.F16065@flint.arm.linux.org.uk>
In-Reply-To: <20030128233456.F16065@flint.arm.linux.org.uk>
MIME-Version: 1.0
Message-Id: <03012818152206.02271@kilauea.iders.ca>
Content-Transfer-Encoding: 8bit
X-Loop-Procmail: PreventLoop

After lots of digging, I found a lead to the answer to where to find an 
answer in the place i should have looked but didn't remember - the 
MAINTAINERS file.  

Simon, Frodo, do you have an opinion on where i should submit the following:

On Tuesday 28 January 2003 17:34, Russell King - ARM Linux wrote:
> On Tue, Jan 28, 2003 at 05:22:17PM -0600, Cam Mayor wrote:
> > In the file ./include/linux/i2c-id.h
> > there is a list of bit-algorithm adapters and their associated sequential
> > numbers.
> > eg.
> > 	#define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface                 
> > */
> >
> > Are the numbers allocated in a first-come-first-serve (or
> > first-to-propagate-patch-gets-it), or are they allocated in a more
> > bureaucratic way?  I see nothing listed in ./Documentation/i2c about
> > this, and i wish to add our hardware to the list.
>
> I have no idea; there appears to be no documented method for these IDs.

I suspect this device will only be used for ARM linux, as it is bit-bashed 
from an ARM processor.  However, i don't want to have to continually be 
patching the device number.

Russell, it looks like at least two of these allocations are present in the 
2.4.19-rmk5 patch, so perhaps i should just submit this patch to you.

I've added the two I2C maintainers to the mail to see if they have an opinion 
on whether i should submit the one-line patch to them or to submit it with 
the rest of the i2c code that i'm going to submit to the -rmk tree.

cheers,
cam

-- 
Cameron Mayor
Iders Incorporated


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
