From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Email loop, bounced mails
Message-Id: <40EAF727.5070801@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <40EAD851.6090902@edgedesign.us>
In-Reply-To: <40EAD851.6090902@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


sensors and lm78 are aliases for each other.  Right now the list is a 
simple procmailrc script which forwards to everyone.  It tries to screen 
out bounces and spam by screening headers (spam is detected from a 
spambayes header).  At some point I'll make the plunge at using 
something like Majordomo.  It's only been in the last year or so that 
we've had more than, say, 10 people on the list.


Phil

Eugene Surovegin wrote:
> On Tue, Jul 06, 2004 at 07:06:08PM +0200, Jean Delvare wrote:
> 
>>Frankly there's nothing you could
>>have done IMHO, the headers were just too broken.
> 
> 
> Well, I have a question then.
> Is <lm78@stimpy.netroedge.com> forwarded to the whole list?
> 
> If yes, this is _very_ broken mail list setup.
> 
> Usually, "envelope from" address when sent from mail list is set to some special 
> "bounce" address, not to the list itself.
> 
> Eugene.
> 
