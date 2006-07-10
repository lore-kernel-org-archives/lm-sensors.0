From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Mon, 10 Jul 2006 05:20:50 +0000
Subject: [lm-sensors] new account(s) - trac/wiki
Message-Id: <3682.194.45.26.221.1152508850.squirrel@webmail.otaku42.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <44B1651F.4030007@sh.cvut.cz>
In-Reply-To: <44B1651F.4030007@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

> On Sun, Jul 09, 2006 at 10:20:47PM +0200, Rudolf Marek wrote:
>> Phil, Axel please is it possible to:
>> 1) remove those old imported tickets (close them)
>> 2) remove the spam?
> Where is it? The trac installation allows for easy removal of whole
> tickets. Spam comments need to be cut out via SQL :/

Nope. There is a nice plugin that allows to easily remove tickets as well
as changes (comments, attribute modifications, ...) to tickets. We use it
on madwifi.org to get rid of comment spam quite successfully.

The plugin can be found here:
http://trac-hacks.org/wiki/TicketDeletePlugin

It requires WebAdmin, which is already included in 0.10dev.

>> 3) I think trac-10 should have some captcha or some account plugin.
>>    Maybe we should move to this direction. Or is there a way how to
>> write
>> something to new ticket page about the "ticket" account?
> AFAIK there is no captcha support anywhere in trac yet

Captcha's are bad for usability, and personally I avoid it wherever
possible. Forcing users to make use of registration (or providing a
default login) also has a negative effect on the usability IMO. There are
other measures that can be taken against spam:

1. The above mentioned TicketDeletePlugin to remove existing spam and
those spam posts that makes it to the ticket engine albeit the measures
that are in effect (no anti-spam method is perfect).

2. https. Spam bots don't know https, but the users' browser does.
However, he will have to click a few buttons to accept the home-made
certificate, unless the project is ready to invest some money to get one
that is signed by a trusted CA.

3. mod_security, if Trac is running on Apache. Almost all Trac spam I've
seen so far is getting POSTed to .../ticket/<number>#preview, where
legitimate ticket submissions are POSTed to .../ticket/<number> (without
#preview). Most of the spam that is thrown on Trac does not get through
because of this (Trac is telling the spammer that someone else has
modified the ticket since he has started to "edit" it), however it still
puts a bit of unnecessary load on the server.
Another thing I've noticed is that spammers don't have neither the
trac_auth nor the trac_session cookie.

I'm looking at mod_security now and will give it a try to filter out spam
by these findings.

4. SpamFilter plugin: http://trac.edgewall.org/wiki/SpamFilter

This requires 0.10dev r3180 or later. It provides various methods to
filter out spam: via regular expressions (used on quite a few sites), by
blacklisting IPs (not very useful IMO), via akismet and with a Bayes
filter.


IMO, either 2 or a combination of 3 and 4 should be quite effective,
reducing the spam that shows up on the site to a minimum.

> and the registration plugin is for 0.9. So the best we can currently
> hope is that 0.10 gets finally released, so that some plugins are
> brought up to date including the registration/authentication plugins.
>
> Until then account registration needs to be manually handled.

Registration won't help for too long, see:
http://trac-hacks.org/ticket/443 for example.

Bye, Mike


