From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Wed, 08 Mar 2006 23:17:57 +0000
Subject: [lm-sensors] lm-sensors-notify (was: Added hysteresis to fancontrol)
Message-Id: <20060308231757.GD4146@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 06, 2006 at 12:29:44PM +0100, Jean Delvare wrote:
> Axel, are SVN changes now reported on the lm-sensors-notify list? We
> can't switch until it works.

I finally found the bug, the whitelist was wrong so any commit mail on
svn would be rejected. :/

So now

o the commit mails work properly, and
o so *should* ticket notifications. E.g. new or changed tickets should
  fire a mail to lm-sensors-notify, too.
o Both have a reply-to set to this list, so when someone spots
  something worth to discuss the reply will automatically go to the
  discussion list.
o There is a neat feature with commit messages and tickets: If you use
  some magic wording the commit can automagically close or reference
  tickets. From the doc:

# It searches commit messages for text in the form of:
#   command #1
#   command #1, #2
#   command #1 & #2 
#   command #1 and #2
#
# You can have more then one command in a message. The following commands
# are supported. There is more then one spelling for each command, to make
# this as user-friendly as possible.
#
#   closes, fixes
#     The specified issue numbers are closed with the contents of this
#     commit message being added to it. 
#   references, refs, addresses, re 
#     The specified issue numbers are left in their current status, but 
#     the contents of this commit message are added to their notes. 
#
# A fairly complicated example of what you can do is with a commit
# message of:
#
#    Changed blah and foo to do this or that. Fixes #10 and #12, and refs #12.
#
# This will close #10 and #12, and add a note to #12.

I didn't want to test the ticketing interaction with fake tickets as
Phil has done some work to get the tickets into production state.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060309/b2c629e1/attachment.bin
