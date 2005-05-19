From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: ECS-k7s5a sensors
Message-Id: <200306191228.25314.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306161757.32702.Joseph@McQuade.info>
In-Reply-To: <200306161757.32702.Joseph@McQuade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joseph,

pls try not to load any i2c modules at boot time. Then run sensors-detect und 
give us pls output from: 1) syslog (/var/log/syslog or /var/log/messages , 
this depths on ur distribution); 2) output from sensors-detect; 3) lspci -vvv

We need these informations in order to help u running lm_sensors.

Thanks in advance...

Am Donnerstag, 19. Juni 2003 10:02 schrieb Joseph McQuade:
> If I knew how to bring up the log i'd send it along.. as I said I am quite
> new to this.. When I ran the sensors-detect It said I had no sensors. Even
> on boot it tells me to run modprobe i2c and that is all it says. I downlaod
> i2c-sis630. When I ran that as modprobe i2c-sis630 It said no sensors
> detected. Maybe I am doing something wrong... I don't truly know.. I'm
> sending the information that it gives me. Maybe I am doing something wrong,
> and Its not giving me the information needed casue Im not telling it the
> right thing..
>
> On Thursday 19 June 2003 03:37 am, you wrote:
> > > After rebooting linux brought to my attention on boot, that lm_sensors
> > > has a error and stats i need to run modprobe even then it still says
> > > the same thing..
> > >
> > > Just wanted to give you a head ups on what has happened so far.
> >
> > We'd need more details if you want us to help you. Tell us what the
> > warnings were, what you tried, what happened then. Show us what
> > sensors-detect reported (full log), and what sensors displays.
> >
> > "It doesn't work" alone is not something we can work on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 2500 bytes
Desc: signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030619/d06936d6/smime.bin
