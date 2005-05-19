From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Email loop, bounced mails
Message-Id: <20040706191716.GA5637@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <40EAD851.6090902@edgedesign.us>
In-Reply-To: <40EAD851.6090902@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 06, 2004 at 12:01:59PM -0700, Philip Edelbrock wrote:
> 
> sensors and lm78 are aliases for each other.  Right now the list is a 
> simple procmailrc script which forwards to everyone.  It tries to screen 
> out bounces and spam by screening headers (spam is detected from a 
> spambayes header).  At some point I'll make the plunge at using 
> something like Majordomo.  It's only been in the last year or so that 
> we've had more than, say, 10 people on the list.

Heh, OK.

My point is quite simple actually. I'm pretty sure the problem we just saw could
be easily avoidable by using normal mail list software.

BTW, I'm not a procmail guru, but maybe it's possible to tweak the script so it 
uses different (not list) "envelope from" e-mail address. This at least will 
help prevent similar problems until you migrate to "real" mail list sw.

As a suggestion, put this script somewhere on www, maybe sombody who knows 
procmail will help us here :).

Eugene.
