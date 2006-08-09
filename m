From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Wed, 09 Aug 2006 20:09:55 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04704F7F7C3@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean, 

> -----Original Message-----
> From: Jean Delvare [mailto:khali at linux-fr.org] 
> Sent: Wednesday, August 09, 2006 1:13 PM
> To: Calabro, Anthony
> Cc: LM Sensors
> Subject: Re: [lm-sensors] Flex Scanner Jammed Problem
> 
> Hi Anthony,
> 
> > Very interesting results... When I turned off the %option 
> nodefault, 
> > it showed me everyhting that was happening incorrectly in 
> the parsing, 
> > and the way I finally made it run without error and 
> correctly work, I 
> > had to put the in0 in quotes also.  Ex:  "in0".  That way a 
> label lin 
> > looked something like this:
> > 
> > label "in0" "VCore 1"
> > label "in1" "VCore 2"
> > 
> > Doing this causes sensors -s to run without error and also now 
> > displays the correct labels when you run sensors...  Im 
> still messing 
> > around and trying different things to attempt to figure out 
> why this 
> > is happening or if there is anything else going on here.  
> Ill keep you 
> > up to date on what I find out.
> 
> Wow. It is known that labels need to be quoted when they do 
> not begin with a letter, but for regular ones like "in0" 
> that's completely new to me. I really wonder what causes your 
> version of libsensors to behave like this.
> 
> What about my question on the locale you use?
> 
> Anyway, thanks for keeping us informed, this is really appreciated.
> That way we may help if other users report a similar problem.
> 
> --
> Jean Delvare
> 
> 


If I run sensors  v2.10.0 with the libsensors v2.8.7, the parser works
correctly with the original sensors.conf input file.  I wonder if there
is a problem with where it is being compiled...

So right now I have sensors 2.10.0 running with either libsensors 2.8.7
or 2.10.0.  in either case I am getting weird sensors readings....  Most
voltages read 4.08 V, and the fans and temps are not returning any
values. 

