From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 21 Jan 2006 00:52:21 +0000
Subject: [lm-sensors] move to new website - status?
Message-Id: <20060121005221.GD31433@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <43D15E0D.1020309@sh.cvut.cz>
In-Reply-To: <43D15E0D.1020309@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 20, 2006 at 11:02:53PM +0100, Rudolf Marek wrote:
> What is missing to complete the move to trac? Here is the list what
> I think needs to be fixed:
> 
> 1) picture issue?
> 2) "extended formating" wiki feature is not enabled?
> 3) port the newdrivers/supported table (implies 2 is enabled)
> 4) port ticket system
> 5) switch to svn completely
> 
> Anything else?

The flipping picture issue in trac seems to be a known issue, but
there is still no upstream fix for it. I'd place that further back in
the queue to give upstream a chance to fix it. OR to allow
experimenting with switching from cgi to mod_python serving, which
might fix the issue (since the bug seems to be in trac's cgi methods).

The switch to svn can be done as soon as everyone with current CVS
write access is comfortable with the test svn repo. The repo can be
remigrated from current CVS within short time, so as soon as there is
agreement, give us the go, and we'll set it up for good.

That's the first item I'd like to see done.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060121/ef7a0483/attachment.bin
