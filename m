From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Jun 2011 22:43:14 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <1308264194.8271.419.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-06-16 at 17:00 -0400, Jean Delvare wrote:
> On Thu, 16 Jun 2011 13:27:54 -0700, Guenter Roeck wrote:
> > On Thu, Jun 16, 2011 at 04:23:44PM -0400, Guenter Roeck wrote:
> > > On Thu, Jun 16, 2011 at 04:06:10PM -0400, everythingsfree@lineone.net wrote:
> > > > Thanks Guenter & Jean for the replies.
> > > > 
> > > > I found this web page with some 
> > > > info and was following that (but just used the Makefile as downloaded):
> > > > 
> > > > 
> > > > https://wiki.ubuntu.com/CoreTemp
> > > > That checked and updated a few things 
> > > > plus downloaded other (it covered everything Guenter had suggested) but 
> > > > I still get errors:
> > > > 
> > > [ ... ]
> > > > I 
> > > > would have assumed that 'MSR_IA32_TEMPERATURE_TARGET' would be defined 
> > > > in a header file and that that would be in the 'linux-headers-2.6.32-24-
> > > > server' package that was downloaded, perhaps not?
> > > > 
> > > > Any suggestions?  
> > > > I'll keep looking on-line...
> > > 
> > > The build worked for me with linux-headers-2.6.32-25-server.
> > > Can you update your system to the latest kernel version and try again ?
> > > It should be 2.6.32-32 as far as I can see.
> > > 
> > Sorry, I got that wrong; it was 2.6.35-25, not 2.6.32-25.
> > 
> > Wel'll have to add the missing defines manually. I'll send you an update later tonight.
> 
> I've attached my compatibility patch for your reference. But it's
> probably easier for Dave to just use my driver.
> 
Yes, agreed.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
