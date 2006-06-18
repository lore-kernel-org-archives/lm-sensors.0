From: brian@rapsure.net (Brian Beardall)
Date: Sun, 18 Jun 2006 22:18:40 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <1150669120.25402.2.camel@rapsure.rapsure.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2006-06-18 at 21:58 +0200, Jean Delvare wrote:
> Hi Brian,
> 
> Quoting myself:
> > > Please stop dropping Lou from the loop, he is certainly interested in
> > > your case and may not be subscribed to the mailing list.
> 
> You did it once again... :(
Sorry about that, I'll CC lou now. Hey lou you might need to do the same
as I did, if you didn't get the message about the latest sensors-detect,
then I'll CC it to you.

> > My output from the latest sensors-detect:
> > # sensors-detect revision $Revision$ ($Date$)
> 
> Argh, I hope we can educate trac/subversion to fill these fields on the
> fly :(
> 
> > Next adapter: SMBus PIIX4 adapter at 0400
> > Do you want to scan it? (YES/no/selectively):
> > (...)
> > Client found at address 0x4c
> > (...)
> > Probing for `Fintek F75383S/M'... Success!
> >     (confidence 7, driver `to-be-written')
> 
> You have your answer, there is indeed a secondary chip on the
> motherboard. Unfortunately no driver exists for this chip yet. I've
> updated our NewDrivers page to mention that you would be interested in
> a driver.
> 


