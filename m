From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: About to release
Message-Id: <3F09A6CB.2030100@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030707154107.556a1372.khali@linux-fr.org>
In-Reply-To: <20030707154107.556a1372.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm ready when you guys are.  I will be out Friday and Saturday, but 
otherwise I can release when we're ready.  I'm assuming we are still 
grabbing HEAD from cvs for the releases?  If there are any differences 
to how I should release, just update doc/developers/checklist for me, 
and I'll take care of the rest.

Thanks again for the continued hard work!


Phil

PS- I've been thinking more about moving all the Lm_sensors off my 
company's hardware and onto a dedicated server (no rush, though).  I'd 
love to get a Penguin Computing 1u server for this... I wonder if we are 
'near and dear' enough to their hearts to get a donation? ;')  Anybody 
have connections?

Mark Studebaker wrote:

>I'll retest sensors-detect tonight and let's take another
>day for testing and reviewing the docs.
>
>We can give Phil the OK on Wednesday and he can release late in the week.
>(Phil likes releasing late in the week to avoid weekday load on his server)
>
>Jean Delvare wrote:
>  
>
>>>Agreed, I think the last thing is fixing the perl problem in
>>>sensors-detect.
>>>      
>>>
>>Hopefully fixed. I had no answer from Jim Morris, but I really expect my
>>fix to make everyone happy (old Perls as well as brand new UTF-8
>>systems).
>>
>>    
>>
>>>Let's not check in anything else except for that fix and
>>>documentation updates.
>>>      
>>>
>>I finished committing my code changes, and I updated some docs. Let's
>>freeze the CVS now (except for necessary bugfixes of course). There is
>>no need to worry anyway. I think we'll have a 2.8.1 release rather soon
>>after 2.8.0, after the first wave of bug reports will have crushed on
>>our mailing list. This has been almost 7 months since 2.7.0 was released
>>and I think this is way too much.
>>
>>Phil (Edelbrock), are you ready for a release?
>>
>>Do we have any reason to wait for Mark Hoffman's return before releasing
>>(I don't see any)?
>>
>>--
>>Jean Delvare
>>http://www.ensicaen.ismra.fr/~delvare/
>>    
>>
>
>  
>
