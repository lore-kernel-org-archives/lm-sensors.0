From: Jeff Rickman <jrickman@myamigos.us>
Date: Sat, 19 Mar 2011 01:35:26 +0000
Subject: Re: [lm-sensors] Logging and plotting
Message-Id: <4D84085E.4050009@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D83AE4E.7030402@cfl.rr.com>
In-Reply-To: <4D83AE4E.7030402@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 3/18/2011 2:11 PM, Phillip Susi wrote:
> Is there a way to log the sensors from a server over say, a 24 hour
> period, and plot the results?
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

I use a Perl-based CGI called Systemgraph:
http://www.decagon.de/sw/systemgraph/

Systemgraph collects the data in RRDtool databases on the host machine 
being measured. As long as the host is "up" and "crond" is running, 
Systemgraph will quietly collect data. Impact to system resources, even 
on an Intel Atom 230 CPU or VIA C7-D 1.5GHz CPU is minimal in my experience.

In my case I use Fedora Core. The FC RPMs also worked for me under RHEL6 
(Scientific Linux 6.0). I have used Apache and BOA as the web server for 
Systemgraph. OpenSuse, Gentoo and Slackware are also supported. Source 
code is available.

Setup should take about 15 minutes or less. Install the appropriate 
files. Edit the Systemgraph config file. Possibly make minor edits to 
one or more of the Systemgraph Perl scripts (usually rrd_health.pl which 
handles sensors that LM_Sensors would talk to). Wait for the data to 
display.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
