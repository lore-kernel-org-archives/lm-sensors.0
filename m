From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: /usr vs /usr/local
Message-Id: <20030824171200.123d7c5f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815221829.0f870e63.khali@linux-fr.org>
In-Reply-To: <20030815221829.0f870e63.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> On Sat, Aug 23, 2003 at 07:24:02PM +0200, Jean Delvare wrote:
> > Another thing I'm thinking of, back to the initial problem, is that
> > we could make the script detect where sensors is (we already do for
> > device files, modules.conf and dmidecode) so that the script works
> > whatever the configuration. In this case, you wouldn't have to do
> > anything special on your side (and, even, doing something could
> > harmlessly break the script).
> > 
> > Any opinion?
> 
> This sounds a bit like an autoconf task. It would mean converting the
> lm_sensors checks into m4 chuncks, which probably isn't worth while
> for only defining the installation prefix.

It's a bit more complex than that. Some parts (e.g. dmidecode) may be
brought by external sources, so checking all possible locations sounds
good. On the other hand, looking for files only in "our" prefix could
prevent multiple versions conflicts (although conflicts can happen with
modules, and there is no prefix for them).

We won't migrate to m4, that's sure.

All I want is to make packager's life easier, so that they don't need to
maintain loads of patches for lm_sensors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
