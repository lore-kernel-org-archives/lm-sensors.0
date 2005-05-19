From: chb@tzis.net (Christoph Breitler)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <1075052249.3266.11.camel@Technetium.pse.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Son, den 25.01.2004 schrieb Jean Delvare um 18:17:

> Turns out to be an error in sensors.conf. This file references a third
> temperature channel that the w83697hf doesn't have. It's commented out
> by default, but I guess you uncommented the lines (set temp3_over and
> set temp3_hyst), and this causes the trouble you're in.
> 
> Delete these lines from your configuration file, and it should be OK.
> 
> I'll do the same in our default configuration file. Strange that nobody
> reported the problem so far. Maybe people simply don't uncomment lines
> they don't need.

I see, I would never have thought of some config errors in the
sensors.conf file with such an error message, always thought it had
something to do with /sys or the modules in general.

When uncommenting these lines I just thought to set up the default max
temp values. 

Maybe there should be something added to the error message that this can
also be caused by wrong settings in sensors.conf

> Thanks for the report.

Thanks for helping me, even the problem was that simple and caused by me
:) 

