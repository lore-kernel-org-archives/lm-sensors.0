From: aurelien@jarno.name (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <20040512103952.GA26337@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 11, 2004 at 05:31:52PM +0200, Jean Delvare wrote:
> >New patch attached, hope this time it will be ok.
> 
> It's fine, I'll apply that.
> 
> Maybe it would be worth adding that some chips also have individual beep
> enable/disable bits mapped on alarm bits? Not sure though, since the
> rest of the sensors.conf.eg file does mention neither the alarms nor the
> beeps entries.

I have thinked of that, however it may be difficult for the users to
look into the sources to get the masks to enable or disable individual
alarms.

Maybe the first thing to do is to list the masks for each chip that
support individual alarms in the documentation.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
