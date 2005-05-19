From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <4185AF58.6010204@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Khali and I discussed this at length this weekend on IRC.
We agree on a general direction toward a generic implementation,
modeled in part on i2c-virtual.
In the meantime, we agree that his i2c-amd756-4882 module is straightforward
is headed in the right direction, and is acceptable for 2.6;
so I no longer object to his patch.
In the near future I'll be working on cleaning up the original i2c-virtual implmementation.

mds



Jean Delvare wrote:
> Hi Mark,
> 
> 
>>I disagree.
>>I think the original proposal, dating back several months, is still valid.
>>The proposal, briefly, elaborates on the 'i2c-virtual' work done previously
>>which recognizes the PCA955x chip and generates the additional i2c busses,
>>with locking. This requires an adapter/algorithm pair of drivers and
>>changes in i2c-core for the locking. I'm sure you already have the email
>>threads where we've discussed previously.
>>Your proposal looks less general, more board-specific.
> 
> 
> Yes, I did read the i2c-virtual proposal. It looked interesting because
> it adds an architecture for the whole concept of SMBus multiplexing.
> However, it has several drawbacks:
> 
> 1* It affects the core. It is certainly acceptable for Linux 2.6
> (providing it actually proves to be useful) but I don't think such
> changes belong to 2.4/CVS where compatibility and stability are (well,
> should be) our main goal.
> 
> 2* SMBus multiplexing *is* board-specific, no matter how you look at it.
> For I2C multiplexers which are controllable with I2C commands (such as
> the PCA9540), autodetection may be used (but see below). However, on the
> S4882, multiplexing is done using 3 chips. The multiplexing control is
> done by a PCA9556, which is an 8-pin GPIO chip. These pins (4 and 4) are
> connected to two PCA9516 chips which do the real SMBus multiplexing job
> according to the value of their input pins. You have to realize that the
> PCA9516 chips could be controlled in a completely different way
> (Super-I/O chips have GPIO pins which could be used for this for
> example). And the PCA9556 chip could be controlling anything, not
> necessarily SMBus multiplexers. This setup is simply not detectable.
> Additionally, there are possible optimizations that cannot be done
> automatically. For example, for the S4882, I merged virtual busses by
> pairs, so as to have one virtual bus per CPU, which is both more
> convenient for the user and less resource consuming.
> 
> 3* Multiplexer controllers are usually hard, if not impossible, to
> detect. The PCA9540 has a single register which is accessed with
> smbus_{read,write}_byte commands, NOT smbus_{read,write}_byte_data
> commands. The only thing that saves us for this one is its relatively
> rare address (0x70). PCA9556 chips have four registers, no
> identification register and eight possible addresses. I think that my
> heuristics to detect it in sensors-detect are acceptable, but this
> highlights the fact that we could face multiplexer chips that are simply
> not detectable. This adds up to the fact that multiplexers controller
> are not necessarily chips on the SMBus.
> 
> 4* The previous proposal is around for quite some times now, but was
> never merged in. If I remember correctly you had implementation
> objections, which were never addressed.
> 
> 5* There are only a couple boards with multiplexing out there, and I can
> only hope that there won't be too many more in the future. Multiplexing
> makes things slower and more complex, as everyone can easily understand.
> I'm not sure it's worth to add things at the core level for just a
> handful of boards.
> 
> So, I understand that you like defining clean interfaces for new things,
> I do to. However, I don't see any added value in this specific case.
> This won't allow for fully automatic detection. This won't allow for
> code refactoring either, since each chip can be used in different ways.
> And there isn't that much code to refactor either. In the case of the
> S4882, the multiplexing control is just one smbus transfer for initial
> configuration, and one smbus transfer for bus switching. If we really
> want to refactor code, we could add an helper function in i2c-core (or
> whatever) that creates N virtual busses from one physical bus.
> 
> I am personally easier with refactoring code afterwards, when we know
> what can be moved in the common part,
> 
> My question was about whether my code was acceptable in the current
> context, not whether there were prefered (but more complex) ways to
> achieve the same goal. If anyone comes with a more generic
> implementation at a later which everyone enjoys, I will of course update
> my code to make use of it.
> 
> 
>>I'll continue to review your emails and code from the past week,
>>perhaps we can disuss on IRC this weekend.
> 
> 
> Thanks. Note that I will not be able to spend too much time on IRC this
> weekend though, since I will not be at home all the time. I'll take my
> laptop with me and connect as time and technical conditions permit.
> 
> Thanks again,
> Jean
> 
