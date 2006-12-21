From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 21 Dec 2006 12:44:18 +0000
Subject: [lm-sensors] sensors.conf syntax: anyone use escape sequences?
Message-Id: <20061221124418.GB12560@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061112140142.GB8009@jupiter.solarsys.private>
In-Reply-To: <20061112140142.GB8009@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

(resurrecting an old thread here)

* Jean Delvare <khali at linux-fr.org> [2006-11-17 11:26:16 +0100]:
> Hi Mark,
> 
> On Sun, 12 Nov 2006 09:01:42 -0500, Mark M. Hoffman wrote:
> > This is a question about sensors.conf syntax:
> > 
> > For a quoted string, libsensors currently accepts C language escape sequences
> > like '\n' for newline, etc.  It also accepts octal escapes, like '\015', but
> > for some reason it doesn't accept hex escapes, like '\x20'.
> > 
> > Question: is anyone actually using these escapes?
> > 
> > I wouldn't mind getting rid of them.
> 
> I've never seen them used. I agree that octal escapes don't sound very
> useful, assuming libsensors accepts all character values in quoted
> strings, and not only the 32-127 range. Same applies to C language
> escape sequences, except \n, as I guess there is no other way to
> include a newline in a string?

You raise a good point here.  The existing scanner accepts any characters from
the 'alnum' class for unquoted identifiers.  This corresponds to isalnum() of
the C standard library.  That function changes behavior depending on locale.

The end-result is that the behavior of the scanner depends on the locale
setting at _compile-time_ instead of at run-time.  (That's when flex checks
isalnum() to build its static tables.)  That's just nasty.

Right now, the code does accept everything between quotes, which is good.  For
the unquoted behavior, I think it should accept strictly ASCII (32-127) in
order to avoid having the run-time behavior influenced by the compile-time
locale setting.  Any better ideas?

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


