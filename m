From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 10 Apr 2007 06:25:25 +0000
Subject: Re: [lm-sensors] What to do ta have new sensor patch included in
Message-Id: <461B2DD5.4030008@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <461b2ac080b93@wp.pl>
In-Reply-To: <461b2ac080b93@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Krzysztof Helt wrote:
> Hi,
> 
> I tried to port THMC50/ADM1022 driver for 2.6 kernel tree. Where
> should I post the patch?
> 
> I sent it one month ago to this list, but it seemed to get ignored. 
> 
> I can report that I happily use this driver in the Compaq AP550
> workstation with two ADM1022 chips for over a month now.
> 
> The sensors command does not handle it correctly (lack of board
> definition and new 2.6 kernel interface). I can also patch the
> sensors command, but I need to have accepted interface to the
> chip (pwm1, tempX_input files).
> 

I could review your patch, but that useless as Jean then still wants to review 
it again himself :(

Jean, sorry if I sounded a bit harsh yesterday, but you criticizing a driver 
you've been ignoring for 3 months brushed my hair the wrong way. With this 
post, do you see my point now? Now we have 3 drivers awaiting review, and lm93 
coming soon. Why won't you accept reviews done by others? Its not like Juerg 
and I have made it easy on ourselves, we both did a pretty thorough review.

Also we're talking about new drivers* here, drivers which won't even get 
autoloaded, but people need to manually activate. So even if there is a bug, 
its not like this will cause a regression for existing setups.

*new, but tested my driver has been tried by several people without problems.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
