From: phil@edgedesign.us (Philip Edelbrock)
Date: Fri, 30 Dec 2005 19:24:20 +0000
Subject: [lm-sensors] trac, svn, mediawiki
Message-Id: <43B58964.2010309@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Axel Thimm wrote:
> On Thu, Dec 29, 2005 at 03:06:13PM -0800, Philip Edelbrock wrote:
> 
>>>Then, everyone interested in trac can help setting it up. Michael, Phil
>>>and others, please get in touch and decide who will do what, and where
>>>the application will be hosted. It can be either at Phil's server
>>>(which was hosting the older ticket system) or at Axel Thimm's facility
>>>(which hosts the mailing list already). I'd rather avoid having a third
>>>location for lm-sensors' stuff so as to not confuse people (starting
>>>with ourselves).
>>
>>I will see how hard it will be to implement on my server, unless 
>>somebody has a better home in mind.
> 
> 
> The server hosting lm-sensors.org already has trac&svn support (it is
> used for another OSS project, ivtvdriver.org). I can setup trac (and
> even svn, converting cvs to svn) in rather shortish time to test it,
> if you like. Phil has also an ssh account on this machine to have full
> access to trac and friends.
> 

This seems like a good idea to me.  This server here is too old to 
support Trac it seems.  I got far enough to get things installed but I 
get segfaults.

I've been using svn on the development side for a few months on another 
project.  I like it.  Those familiar with cvs and not svn shouldn't have 
much trouble adapting.

I suggest that you go ahead and do the cvs->svn conversion and get Trac 
going, unless there are objections? (can't imagine why not)  Do you need 
a raw dump of the CVS directory on the server, or can it slurp it over 
the network?

After Trac/wiki is up we can start migrating content over.  I might 
tweak the graphic design a little.  The stock Trac nav is a little bland 
and very recognizable.

I can also prep the tickets and get them moved over, too.

Thanks, Axel.


Phil

