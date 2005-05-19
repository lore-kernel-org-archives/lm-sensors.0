From: dalek@exceedtech.net (dale)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Error during shutdown
Message-Id: <200307161047.32413.dalek@exceedtech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307160526.45022.dalek@exceedtech.net>
In-Reply-To: <200307160526.45022.dalek@exceedtech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 16 July 2003 12:40 pm, you wrote:
> > I installed lm_sensors and gkrellm onto my system and it works fine.
> > However when I shut my system down I get a error message.  It's gone
> > pretty quick but this is what I could make out after several restarts.
> >  /etc/init.d/lm_sensors
> > line 73  [: -ge: unary operator expected.  I have uninstalled and
> > reinstalled the lm_sensors package to see if it was just a glitch.  I
> > even deleted the files a re-ran sensors-detect.  It still does it.
> > Any help would be appreciated.  I have attached a copy of the file.
>
> This script comes with your Mandrake 9.1 distribution, so the error is
> theirs, not ours. However, I think I know how to fix it. Go to line 72
> and replace
>   i=`expr $Pmodules`
> with
>   i=$modules
>
> Please try this and tell me how it goes.

I replaced the line as you said.  No more error and a nice clean shutdown.  
That explained a lot with it being a script error.  I didn't get the error 
the first time I installed because I installed from a tar.gz package, that 
was downloaded, and it has no error in the script.
Should I e-mail Mandrake about the boo boo?  I may install next time from the 
downloaded file.  Not as easy as a rpm in Mandrake but your copy works 
better. :-)

Thanks much for your help.  I like watching the temps.  103 degrees so far at 
99% processing.  Cool huh?

dalek@exceedtech.net
