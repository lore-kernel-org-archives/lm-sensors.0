From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 30 May 2006 09:47:01 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060530094701.GA24093@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 30, 2006 at 10:16:31AM +0200, Jean Delvare wrote:
> As for trac, I'm not really familiar with it, but it looks to me like
> users could be different from code contributors, so I'm not certain it
> makes sense to have a common authentication method.

Yes, this is true, but contributors should have the same name in both
authentication systems, as for example trac&svn can deduce a ticket
action from a commit. Say khali commits something with a log message
of "Add patch XYZ, this finally fixes #2002.", then trac will
automagically close this ticket with the name of the svn committer.

So every registred committer in svn should also be registred in trac
with the same name. It doesn't have to be the same authentication
method, though, and in fact the authetication databases will be
different, as we will probably have more (non-anonymous) trac users
than committers.

> What are the benefits of using htdigest for subversion compared to
> ssh? Are there drawbacks? I really don't care much as long as it
> works, so if others have stronger (motivated) opinions, please speak
> up.

The benefits of using http+htdigest against svn+ssh are:

o higher performance: ssh needs several new connections with each
  commit/update. You can work around this by using something that
  caches ssh connections like fsh or ssh -M.

o Same URL like anonymous svn checkouts: svn+ssh needs an URI which
  maps exactly the basolute path on the file system,
  e.g.
  svn+ssh://lm-sensors.org/srv/lm-sensors.org/svn/lm-sensors/
  instead of
  http://lm-sensors.org/svn/lm-sensors/

o Priviledge separation: svn+ssh has privileges on the whole repo, you
  can either write to it or not. For having different commiter ACLs
  for i2c vs lm-sensors this is very difficult (you need to add
  another layer of something like userv, see [1])

o account management: Adding a .htdigest line by anyone having an ssh
  account with group lm-sensors (e.g. Jean, Phil, Rudolf and Mark) vs
  creating ssh accounts (which only I can do).

o Pick random usernames for the commits, e.g. khali, frodo
  etc. svn+ssh fixes you to the ssh account name which is again
  dictated by the local account policies.

While it looks like a pile of arguments in favour of http+htdigest,
these aren't blockers. There are also drawbacks:

o http+htdigest stores your password on your local disc,
  ssh+svn+ssh-agent stores it nowhere 

o ssh+svn is more secure than http+htdigest. One could then go
  https+htdigest or https+certificates, but then the setup is equally
  troublesome like for svn+ssh

Again this doesn't cost the world. So from my POV I think
http+htdigest has some little advantages compared to svn+ssh, but it's
up to you what you'll prefer.

(I'm hosting/working with both kinds of repos currently, so both
models work OK)

[1] http://www.chiark.greenend.org.uk/~sgtatham/svn.html

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060530/5c8c1723/attachment.bin
