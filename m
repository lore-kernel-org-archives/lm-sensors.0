From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: /usr vs /usr/local
Message-Id: <20030823192402.1e0dbcef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815221829.0f870e63.khali@linux-fr.org>
In-Reply-To: <20030815221829.0f870e63.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > A suggestion for the next time you package the sensors userspace
> > tools. In sensors-detect, we suggest the user should run
> > "/usr/local/bin/sensors -s". You should change that to
> > "/usr/bin/sensors-s" since that's where you install that program.
> > Could confuse the users...
> 
> Thanks, I just fixed that, repackaged and the new packages will appear
> at atrpms later.

OK, thanks.

> I run a
> find %{buildroot} -type f | xargs file | grep -E '(ASCII|Bourne
> shell)' | awk -F: '{print $1}' \
>   | xargs perl -pi -e's,/usr/local,/usr,'
> over the installed files, to catch also documentation bits.

Interesting. It may give strange results however. I'm thinking of our
sensors-detect here (but it should be OK since it's Perl, so neither
ASCII nor Bourne shell). For example, the following line:
  @dmidecode = ( '/usr/local/sbin/dmidecode', '/usr/sbin/dmidecode' );
would become:
  @dmidecode = ( '/usr/sbin/dmidecode', '/usr/sbin/dmidecode' );
and produce the following output:

"Please provide one of the following:
  /usr/sbin/dmidecode
  /usr/sbin/dmidecode"

It's harmless but may confuse the user ;)

We may change that part however, so that your trick would work.

Another thing I'm thinking of, back to the initial problem, is that we
could make the script detect where sensors is (we already do for device
files, modules.conf and dmidecode) so that the script works whatever the
configuration. In this case, you wouldn't have to do anything special on
your side (and, even, doing something could harmlessly break the
script).

Any opinion?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
