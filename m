From: alexander@isacson.info (Alexander Isacson)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: VIA VT1211 Port to 2.6.x in progress
Message-Id: <1073599305.26709.5.camel@alexanders>
List-Id: <lm-sensors.vger.kernel.org>
References: <EFEF4C473088B847B64CD953D2A6A104FE80E1@sdso14a.par.siemens.fr>
In-Reply-To: <EFEF4C473088B847B64CD953D2A6A104FE80E1@sdso14a.par.siemens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is great news! I was in a little over my head on this one.

I spent about a day on the port in mid December and did all the easy
stuff and got a grip of the porting process. But then I realized that I
needed more info for the conversions and what not so I put it on hold
over the holidays. 

I actually resumed work on the driver today and started comparing it to
the via686a driver. 

Basically what I'm trying to say is that my port is almost non-existent
(but I'll of course share any code).

Regards
Alexander

On Thu, 2004-01-08 at 22:55, Jean Delvare wrote:
> > I am currently working on the vt1211 port from lm_sensors-2.8.2
> > to the brand new kernel 2.6.x. It is working quite well (right now
> > only temp? are working, but the remaining part is not a hard work to
> > do).
> 
> Great news :)
> 
> > I first hope I am not working on another people's task...
> 
> Indeed you are, more or less. Alexander (CC'd) once was doing the same.
> No news since mid-December though, so I don't know if he finished the
> port or not.
> 
> > Then, it would be kind from you to provide me a kind of API for
> > the '/sys' interface used by the 'sensors' program.
> 
> Everything is detailed in Documentation/i2c/sysfs-interface of Linux
> 2.6.1-rc1 and later. If something's missing, let us know.
> 
> > PS : don't be afraid of my @siemens.com email address, I am just a
> > one-year trainee here, and I'm not working on some linux-related
> > siemens project (are there any ?).
> 
> Oh my god, he is working at Siemens. Let's be afraid! ;) We have had
> good relationships with FSC in the past, and are supporting three of
> their chips (Scylla, Hermes and Poseidon).
> 
> > PSx2 : where could I find a hacker involved (currently or in the past)
> > of the vt1211 devel, I could have questions for him(/her) about the
> > necessity of mutexes in this driver...
> 
> I hope that Mark D. Studebaker, who is present on this list and wrote
> the driver, will be able to help.
> 
> Alexander & Francois, please get in touch with each other, share your
> works and provide a working driver for 2.6, so that we can have it
> included in Linux 2.6.2.
> 
> Thanks!
-- 
Alexander Isacson <alexander@isacson.info>
