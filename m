From: rutger@nospam.com (rutger@nospam.com)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: pwmconfig fix
Message-Id: <20040508190100.GA6436@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 08, 2004 at 01:32:19PM +0200, Jean Delvare wrote:
> > [little bug report + fix]
> > 
> > On my Asus P4P800 motherboard with a w83627thf sensor chip, pwmconfig
> > from lm_sensors-2.8.6 doesn't detect the pwm-files by default
> > (2.6.6-rc3, module w83627hf).
> > (...)
> > As you can see the pwm files are called 'fan[1-9]_pwm'. Likewise for
> > the fan inputs, which are called fan[1-9]_input.
> > 
> > After changing this in pwmconfig to take those files into account,
> > your script worked. Thanks.
> 
> I've changed that, hopefully in the proper way. Thanks for reporting.
> Unfortunately I don't have pwm-capable system to test with here. Would
> you please be kind enough and checkout the latest CVS version of the
> script, and ensure it works OK?
> 
> Thanks again.

Latest version of lm_sensors2? I did a fresh checkout of lm_sensors2
which didn't solve anything (cvs -d
:pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout lm_sensors2).


-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
