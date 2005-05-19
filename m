From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030704235106.7c14d29a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > Could be... But there is one last thing I would like to try. My
> > > changes(-k3) don't seem to have had any effect, so I'm trying
> > > something similar but different. Please get
> > >   http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k4
> > > and tell me, again, it it behaves differently with and without an
> > > UTF-8 locale.
> > 
> > That seemed to fix it!!!
> 
> "Ah ah ah (evil laugh) you nasty little bug, you thought you could
> lurk forever? Diiiiiiiie!"

Jim, still around? Although the UTF-8 fix finally worked, it turned out
to be incompatible with older versions of Perl MDS is still using. I
think I know what to do but I'd like to make sure it doesn't make the
UTF-8 trouble come back again. This is very very unlikely to happen, but
who knows...

Please edit your local copy of sensors-detect, search for the "sub
initialize_ioports" and make that function looks like this:

sub initialize_ioports
{
  sysopen (IOPORTS, "/dev/port", O_RDWR)
    or die "/dev/port: $!\n";
  binmode (IOPORTS);
}

(If you still have the -k4 script, it will probably mean removing
O_BINARY and :raw. These are the things older Perl don't know about.)

Then let us know if the UTF-8 test still works, or not. Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
