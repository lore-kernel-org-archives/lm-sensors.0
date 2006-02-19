From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 19 Feb 2006 12:47:07 +0000
Subject: [lm-sensors] move to new website - status?
Message-Id: <20060219134707.4db5fc55.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D15E0D.1020309@sh.cvut.cz>
In-Reply-To: <43D15E0D.1020309@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> On Fri, Jan 20, 2006 at 11:02:53PM +0100, Rudolf Marek wrote:
> > What is missing to complete the move to trac? Here is the list what
> > I think needs to be fixed:
> > 
> > 1) picture issue?
> > 2) "extended formating" wiki feature is not enabled?
> > 3) port the newdrivers/supported table (implies 2 is enabled)
> > 4) port ticket system
> > 5) switch to svn completely
> > 
> > Anything else?
> 
> The flipping picture issue in trac seems to be a known issue, but
> there is still no upstream fix for it. I'd place that further back in
> the queue to give upstream a chance to fix it. OR to allow
> experimenting with switching from cgi to mod_python serving, which
> might fix the issue (since the bug seems to be in trac's cgi methods).

Any news about this? I don't see the picture flipping anymore myself,
so it seems to be fixed. Anyone still having the problem?

Axel, did you enable the extended formating as Rudolf asked? We need it.

> The switch to svn can be done as soon as everyone with current CVS
> write access is comfortable with the test svn repo. The repo can be
> remigrated from current CVS within short time, so as soon as there is
> agreement, give us the go, and we'll set it up for good.

Do you have enough ssh key by now? We can't switch until you have at
least mine, Rudolf's and Mark Hoffman's. Others can send their key
later, after we have collectively agreed to grant them write access, of
course.

BTW, will it be possible to have different permissions for the i2c and
lm_sensors2 repositories? I'd like to grant more people developer
access to lm_sensors2, but write access to the i2c repository needs to
be restricted as changes to it are supposed to be very rare now.

Now that lm_sensors 2.10.0 has been released, I think it is a really
good time to switch to SVN, if nobody objects. Phil, could you switch
the i2c and lm_sensors2 CVS repositories to read-only? So we are
certain that changes are not lost. Note that the website repository
should be kept writable so that we can at least announce the website
change.

About the tickets, I think Phil was done with porting the old tickets
to Trac, is it true? Anything left to do on this front?

Thanks,
-- 
Jean Delvare

