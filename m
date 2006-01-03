From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 03 Jan 2006 07:25:25 +0000
Subject: [lm-sensors] project status and future
Message-Id: <1136273126.4455.15.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AF1E4A.90902@sh.cvut.cz>
In-Reply-To: <43AF1E4A.90902@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On Mon, 2006-01-02 at 23:38 +0100, Axel Thimm wrote:
> didn't we want to use mediawiki instead of trac's embedded wiki?
> 
> http://lm-sensors.org/wiki/
> 
> vs
> 
> http://lm-sensors.org/trac/wiki/

I'd say no. While mediawiki might be more powerful regarding the markup
it uses, we will loose one of the features of Trac: the possibility to
easily link between tickets, wiki, changeset comments, and other Trac
objects.

Trac uses the Wiki markup nearly everywhere where someone can enter text
(the tickets for example), and if we decided to use Mediawiki for the
main wiki, users would be forced to cope with two different wiki markup
dialects.

Bottom line: personally I'd strongly vote for the Trac-internal wiki
rather than Mediawiki in this case.

> As wikispamming is just around the corner, we need to restrain freely
> editing 

madwifi.org runs Trac for about three months now. We had no incident of
Wiki spam so far, and only one or two incidents of minor vandalism
(someone thought it would be funny to remove parts of a newbie
documentation).

We allow changes to anonymous users, with the exception of only a few
pages. One of them is a page where I publish my public GPG key.
Everything else can be edited freely.

I have a bot running in our IRC channel that announces
added/deleted/changed wiki pages and tickets, as well as new Subversion
commits. That way it's easy to have a quick look on the changes, which
can then be reverted if necessary.

> and have some wiki operators (e.g. people that acknowledge
> other people's wiki accounts).

Accounts for Trac (which includes the Wiki) will have to be created in
two (three) steps:
1. adding the account credentials to a htpasswd file
2. adding the corresponding permissions to the user via trac-admin
(permission add ...)

3. (optional) The user has to log in and fill in the fields on the
"Settings" page to create a valid session. Without this session his name
won't occur in the drop-down list of the "(re)assign to" field of
tickets.

> > Also someone with trac admin please update the logo ;)

See:
http://lm-sensors.org/trac/wiki/TracInterfaceCustomization#ProjectLogoandIcon

Needs to be done by someone with shell access to the server, write
access to the trac.ini and, depending on the way Trac is installed (as
CGI or using mod_python), the rigths to restart Apache.

Bye, Mike


