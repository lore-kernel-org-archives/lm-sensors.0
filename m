From: pete4abw@comcast.net (Peter Hyman)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: I2C crash - ADM1021
Message-Id: <1063920630.5184.13.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean!  Thank you for the reply.  Please understand that I was not
complaining.  I was just reporting a problem I had in the hope that it
will help others.  It just took awhile for me to figure it out and I
found it very curious!

I'm going to answer all your questions.

On Thu, 2003-09-18 at 17:07, Jean Delvare wrote:

> What's that Win4Lin thing?
A program that allows a true windows system to run inside of Linux under
X.  Similar to VMWare except I can cut and paste between Windows and
Linux, and it is much less of a system hog.  I still do some work in
Windows :(!  http://www.netraverse.com if you're interested.
> 

> Well, I am really sorry for you. We are doing our best to prevent these
> problems, but it turns out that the I2C/SMBus operations are risky on a
> few systems, and there's almost nothing we can do against that, apart
> from plain stopping the project.

Oh, don't do that!  I am not sorry, I enjoy learning.  What got me going
was the line that adm1021 COULD cause problems.  I wanted to know WHAT!
> 
> Thanks a lot for taking the time to report (and not even complain about
> what happened to you).
> 
> There are a few comments and questions that come to me after reading the
> files you attached.
> 
> Although I don't know which chipset is at 0x18, I remember that we had a
> similar dump reported a few days ago.
> 
> The chip at 0x4c is doubtlessly a LM90, and is detected as such (BTW,
> note that you need the latest CVS for it to refresh correctly).
Yes, I have the latest CVS
> 
> No idea what could be at 0x4e, but it is neither a LM75 nor a ADM1021
> clone, sensors-detect is obviously wrong here. So you can remove lm75
> from your module list.
> 
> At 0x52 you have a SPD EEPROM, also detected OK by sensors-detect.
> 
> At 0x69, this must be a clock ship that we usually advise not to play
> with ;)
> 
> Now, for the adm1021 problems, I'm puzzled. The option line in
> /etc/sensors.conf, as suggested by sensors-detect, prevents the driver
> from using any of the three addresses at which you have chipsets (0x18,
> 0x4c, 0x4e) so loading it shouldn't have had any effect. But, since it
> was crashing your system, it must have been doing something. What, that
> I can't understand. Do you have any log that survived the crashes so
> that we could try understanding what happened?
> 
No, nothing survived.  As soon as modprobe adm1021 is executed, the
system goes dead, and worse, the hard disk gets corrupted so that when
fsck runs on reboot, Linux cannot even boot -- all the inode tables are
trashed.  The only possible thing I was thinking was that in my kernel
config file, while no modules are loaded, there is one line that is
strange.

CONFIG_I2C_MAINBOARD=y

is the only thing checked off.  I think this is just to allow the kernel
to create modules, not actually install anything.

> Again, thanks for reporting.

If I can help narrow it down more, I will let you know.  Best wishes!
-- 
Peter Hyman
Home:(609)395-1211 Office: (609)655-1184, Fax:(609)655-0285
Stop Telemarketers.  Sign up for Do Not Call at http://donotcall.gov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 193 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030918/dee440c7/attachment.bin
