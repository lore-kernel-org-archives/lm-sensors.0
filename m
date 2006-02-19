From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sun, 19 Feb 2006 13:51:52 +0000
Subject: [lm-sensors] move to new website - status?
Message-Id: <20060219135152.GG26231@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D15E0D.1020309@sh.cvut.cz>
In-Reply-To: <43D15E0D.1020309@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 19, 2006 at 02:28:52PM +0100, Axel Thimm wrote:
> > BTW, will it be possible to have different permissions for the i2c and
> > lm_sensors2 repositories? I'd like to grant more people developer
> > access to lm_sensors2, but write access to the i2c repository needs to
> > be restricted as changes to it are supposed to be very rare now.
> 
> Not through ssh access. In this case the developer only sees a
> database there is no fine grained per file/directory access. If you
> want to go that way there are two possibilities:
> 
> o Have separate repos for lm_sensors and i2c. That would not be nice,
>   as it would effectively mean separate trac installs, too.
> 
> o don't use ssh access, but http & dav
> 
> I think if there will be ACLs then we'd need to go with http &
> dav. For the users/developers this might be even nicer, as the URL is
> the same as the ones for the anonymous access.
> 
> In that case, authentication wouldn't happen anymore with ssh keys,
> but via http/https methods.
> 
> I'd recommend to make sure the repo layout is compatible with the idea
> of different ACLs for i2c and lm_sensors (e.g. top level dirs are
> lm_sensors/i2c and trunk/branch/tag comes beneath), and start with ssh
> key authentication for now, which is already set up. We can later
> switch to a different authentication schemes to allow for ACLs.

I forgot to mention that the http access method has the nice
sideeffect that you can share the same authentication with trac, that
also uses http authentication.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060219/472222ee/attachment.bin
