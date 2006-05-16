From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 16 May 2006 07:27:46 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060516092746.fedb68b8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

[Rudolf Marek]
> > Please can you resync SVN with CVS? I think we can switch after that
> > because the commits to both repositories were quite anoying...

[Axel Thimm]
> OK. Someone with access to the cvs repo needs to copy it over to the
> server (I have no access). Last time either Philip or Jean copied it,
> I don't remember anymore. For the migration one needs the RCS files
> (foo,v) - anonymous cvs access is not enough.
> 
> Just rsync the CVS repo to devel.atrpms.net:/srv/lm-sensors.org/cvs
> (or any place else) and I'll do the syncing.

I have no access to the CVS repository, only Philip Edelbrock has.
Phil, can you please:
* Turn the i2c, lm_sensors and lm_sensors2 modules to read-only.
* Rsync the i2c and lm_sensors2 modules to Axel's server.

I don't think we want to copy the old lm_sensors module to the new
server, that would be a waste of time and energy. I guess we also don't
need the website module, as the new site will be handled differently.
The website module must stay active on the old CVS repository though,
as we will want to maintain the old site until the new one is fully
operational.

-- 
Jean Delvare

