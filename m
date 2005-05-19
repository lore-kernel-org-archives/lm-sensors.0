From: cgfreita@netsite.com.br (cgfreita)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040805214628.1d23e71a.cgfreita@netsite.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

WARNING: This e-mail has been altered by MIMEDefang.  Following this
paragraph are indications of the actual changes made.  For more
information about your site's MIMEDefang policy, contact
andrew.net.au Postmaster <postmaster@andrew.net.au>.  For more information about MIMEDefang, see:

            http://www.roaringpenguin.com/mimedefang/enduser.php3

An attachment named jean.sh was removed from this document as it
constituted a security hazard.  If you require this document, please contact
the sender and arrange an alternate means of receiving it.


An attachment named jean_1.sh was removed from this document as it
constituted a security hazard.  If you require this document, please contact
the sender and arrange an alternate means of receiving it.


An attachment named woops.sh was removed from this document as it
constituted a security hazard.  If you require this document, please contact
the sender and arrange an alternate means of receiving it.

-------------- next part --------------
Jean,

> > The results are attached, including the shell script I used.
> > I sent you the results for fan2, as you asked, and for fan1,
> > because fan2 here appears to be the CPU cooler. Anyway, using
> > fan1 the corresponding fan was stopped at the end of the script.
> > :-)
> 
> OK, so it must be working. I should have told you to set the fan
> clock divider to 8 before starting the test, but the results are
> still significant.
> 
> I've updated the driver:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-rc1.diff
> 
> It should now force the fan speed reading to 0 when PWM is enabled
> with a duty cycle of 0%. So for example the following sequence
> should work fine:
> 
> echo 0 > fan1_pwm_enable
> echo 0 > fan1_pwm
> sleep 4
> cat fan1_input (should return 3000 or so)
> echo 1 > fan1_pwm_enable (fan should stop)
> sleep 3
> cat fan1_input (should return 0)
> 
> With the previous version if would have returned the last known
> speed or some other random non-zero value (it seems) while the fan
> would clearly be stopped.

	patch -R -p1 beta3.diff
	patch -p1 < rc1.diff
	Worked. Compiled fine.
	The tests above worked, as you can see at attached file (*rc1.txt).

	Just for curiosity I tried to use 90 as fan1_pwm value. I opened the
case to confirm if fan was still running.
	As you will see at *woops.txt (result of woops.sh), I found a
strange behaviour. I don't know if it is important, but I thought you
should know.
	I made another test (attached) trying to help.

> If you confirm that this version of the driver works fine for you,
> I'll submit it for incorporation into Greg's tree.

	I am trying to give you the best information I can, to help as much
as I can, but I am worried about disturbing you a lot.
	I mean, I have never helped testing software like this, so I am
always thinking if I am being a problem more than a helper. :-)

> > Ok. I was just wondering if some strange values could be the
> > result of some interference.
> 
> Unless you refer to interference in the designers brains, I don't
> think so ;)

	Hahahahahahahahaha. :-D
 
> Thanks a lot for testing, it looks like we finally came to a working
> 2.6 driver.

	It is working here. My gkrellm is always showing my fans and voltages
(just vid does not appear there, but it doesn't matter). I am happy.
	I noticed the behaviour above, but I don't know if it is important.
And, anyway, I can turn off my fan. :-)
	As I say, I want to help, but I don't want to disturb you or became a
problem. When you fell it is ready, so it is ready. :-)
	If you need more information, just tell me.
	Thank you for coding the driver.

Cheers,

Cassio Freitas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: jean_is_running.txt
Type: application/octet-stream
Size: 24652 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040805/29ef13f4/jean_is_running.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: jean_results_rc1.txt
Type: application/octet-stream
Size: 7 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040805/29ef13f4/jean_results_rc1.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: jean_results_woops.txt
Type: application/octet-stream
Size: 4548 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040805/29ef13f4/jean_results_woops.obj
