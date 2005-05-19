From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Patches to Marcelo and Linus
Message-Id: <m2elgfcbre.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CDFF579.88423391@paradyne.com>
In-Reply-To: <3CDFF579.88423391@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "albert" = Albert Cranford <ac9410@bellsouth.net> writes:

Hi

>> yes, we would love your help.
>> Ingo was going to do it but has been busy -
>> Ingo, do you have any work-in-progress to contribute?
>> 
>> There are 3 patches:
>> 2.4 i2c
>> 2.5 i2c
>> 2.5 lm_sensors
>> 
>> Are you willing to do all 3?
>> 
>> Are you generating from our 2.6.3 or CVS?
>> If CVS, I have some SMBus 2.0 work-in-progress
>> in i2c-core that we may want to take out
>> before submission.
>> 
>> Albert Cranford wrote:
>> >
>> > Hello Philip,
>> > Is there still a need to sync up to 2.4 and 2.5?
>> > I would be willing to help since I've done most of the
>> > work already.  Its real easy using bitkeeper which is
>> > the revision control of the kernel.
>> > Let me know.
>> > Albert
>> > --
>> > Albert Cranford Deerfield Beach FL USA
>> > ac9410@bellsouth.net

albert> Yes all three.  I would get the 2.6.3 up to date first,
albert> then get the CVS.
albert> But what about lm_sensors for 2.4 ?  My personal 2.4 tree
albert> has lots of lm_sensors in it.
albert> I'll start with a an i2c patch for 2.5 and pass it through
albert> the group.

I am integrating lm_sensors through 2.4 in the Mandrake kernel, if you
want, I can integrate it in 2.4, I have the patches and the test users
:)  Then you can integrate 2.5 branch.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
