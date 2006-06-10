From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 10 Jun 2006 07:27:39 +0000
Subject: [lm-sensors] LM Sensors Autoconfig Tool - Database aspects
Message-Id: <448A746B.9030005@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44862F5D.6090404@gmail.com>
In-Reply-To: <44862F5D.6090404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jim Cromie wrote:
> Hans de Goede wrote:
> 
> hi Hans,
> 
>> Jim Cromie wrote:
>>  
>>> This is an important choice of directions.  Setting that aside for
>>> the moment,
>>> the database has great value in its own right, esp if this is
>>> recognized early, and maximized.
>>>
>>> Id suggest looking for available fingerprint-worthy items - they
>>> offer the possiblity of
>>> setting up multiple indices which at minimum could help to optimize
>>> the implementation.
>>>
>>>     
>>
>> I agree after seeing some of the dmidecode posts here it has become
>> clear to me that dmidecode output alone will not be enough (sigh) as
>> many bioses don't have proper tables.
>>
>>
>>   
> Ooh that sounds like agreement of sorts -
> 
> I went back to the webite you posted links to, what you said there seems
> more reliant on dmidecode than I think you're thinking now..
> 
> We have a quality of information problem.  This is true on many levels .
> We're trying to improve an untenable situation ( trying to make optimized
> configuration decisions based upon incomplete info about nearly
> un-knowable mobo environs, at least wrt probing currently) with other
> imperfect info.
> - improve Q of the data which drives choices
> - use more data
>    - must learn which data is good
> 

<snip>

Yes I agree we have a quality of data problem, but the solution you're
suggesting is way to complex and fuzzy. We want a system where a human
can say, hey the autconf tool thingie got it wrong because:
-empty / unusable dmi-table and an accidentially identical bios
 checksum.
And then ask himself now how are we going to solve this?


Instead of a human just saying: hey the autoconf tool thingie got it
wrong, gees what a surprise with the fuzzy logic heuristic approach it
has (not). Now what the hell went wrong with the fuzzy logic heuristic
is a mistery though. And let me guess your answer: we need to get even
more data.

We may even end up solving this the same way as is done for monitors. If
a monitor can't be DCC-probed then the installer asks the user what
monitor he has. We could do the same for mobo's, except that the user
would first have to start a tool to get this question, we don't want the
user to be asked this out of the blue as many users probably won't know
the answer.

So my approach is vastly different I'm afraid: I want to build:
1) a database with good sensors.conf for as many motherboards as
   possible
2) A tool which will try to automaticly detect which motherboard a user
   has with _zero_ false positives and if it succeeds then automaticly
   sets the correct configuration. If it fails then things work as they
   do today, they don't (without manual intervention) :)


Regards,

Hans


