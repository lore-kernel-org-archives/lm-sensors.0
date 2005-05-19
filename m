From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Pre-release tests
Message-Id: <3F0B6CA0.6090609@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030707213700.3eef7104.khali@linux-fr.org>
In-Reply-To: <20030707213700.3eef7104.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think we are done and Phil you can do a release at any time.
I don't know much about #6 below but it seems like a minor issue
we can defer until next time.
mds

Jean Delvare wrote:
>>First of all, sensors-detect tests OK for me now. Good job.
> 
> 
> Great. I only hope the UTF-8 systems will enjoy it as much as you seem
> to do ;) I really think they will.
> 
> 
>>On #1-5 below, I don't feel strongly either way about any of these
>>issues, feel free to do what you propose if you want.
> 
> 
> OK, I've commited everything to CVS. You are all welcome to tell me if
> you like the texts I added at the end of both "make install". The great
> thing is that we know have these texts as placeholders for anything we
> want to say to the users for either release or CVS testers.
> 
> I then tested on my fourth system, works like a charm.
> 
> 
>>I note that we do have some Big Fat Warnings in the CVS part of
>>the download page, we can copy those up after the release
>>and enhance if necessary.
> 
> 
> I think that we should rather base our release warning on the text I
> used at the end of i2c "make install". The text for CVS seems to warn
> more about the fact that it is CVS and thus possibly unstable than about
> anything else.
> 
> I finally add a sixth point to be discussed about:
> 
> 6* Our installation process leaves the old i2c-pcf-epp.o and
> i2c-elektor.o (as is or possibly compressed) modules. These drivers are
> marked as "will not build outside kernel tree" in i2c's makefile. What's
> the idea? Are these modules included by mkpatch? These old modules are
> likely to crash the system since they will not be compatible with our
> new I2C structures. I guess the safe way would be to delete them.
> 
> I don't know enough about these two modules, what they are used for and
> the reason why they are not part of our build process to decide what to
> do. Comments and explanations wanted!
> 
