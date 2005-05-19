From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: pwmconfig: bug in temporary file creation
Message-Id: <20050125112833.GA17302@home.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050124140712.GA17184@bode.aurel32.net>
In-Reply-To: <20050124140712.GA17184@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 25, 2005 at 11:59:57AM +0100, Jean Delvare wrote:
> Indeed mktmp seems to be more widely available. Any idea why tempfile
> exists though? I wonder why we have two commands doing basically the
> same thing.
They differs by the fact tempfile uses tempnam(), whereas mktemp uses
mkstemp(). I don't know exactly the difference, but after reading the
manpage, it seems that tempnam() only return a valid filename, whereas
mkstemp() create a file with 0600 permissions, and return its name. 

So, it's seems that mkstemp() is more secure, as it is possible to
create a file between the call to tempnam() and actual creation of the
file. However, it's only my interpretation, I am not sure about that.

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
